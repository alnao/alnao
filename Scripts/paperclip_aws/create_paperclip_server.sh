#!/usr/bin/env bash
set -euo pipefail

# Carica configurazione
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
if [[ ! -f "$SCRIPT_DIR/.env" ]]; then
  echo "Error: file $SCRIPT_DIR/.env non trovato. Copia .env.example in .env e configuralo." >&2
  exit 1
fi
source "$SCRIPT_DIR/.env"

log_msg() {
  local log_dir
  log_dir=$(dirname "${LOG_PATH}")
  mkdir -p "$log_dir" 2>/dev/null || true
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "${LOG_PATH}"
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    log_msg "Missing required command: $1"
    echo "Error: missing required command '$1'" >&2
    exit 1
  fi
}

update_env_instance_id() {
  local new_instance_id="$1"
  local env_file="$SCRIPT_DIR/.env"

  if grep -q '^EC2_INSTANCE_ID=' "$env_file"; then
    sed -i "s|^EC2_INSTANCE_ID=.*|EC2_INSTANCE_ID=\"${new_instance_id}\"|" "$env_file"
  else
    printf '\nEC2_INSTANCE_ID="%s"\n' "$new_instance_id" >> "$env_file"
  fi
}

resolve_key_name() {
  if [[ -n "${EC2_KEY_NAME:-}" ]]; then
    printf '%s\n' "$EC2_KEY_NAME"
    return
  fi

  local pem_filename
  pem_filename=$(basename "$PEM_PATH")
  printf '%s\n' "${pem_filename%.pem}"
}

log_msg "=== Creating Paperclip AI server ==="

require_command aws
require_command mktemp
require_command openssl

# Parametri di dimensionamento
INSTANCE_TYPE="${INSTANCE_TYPE:-t3.medium}"
EBS_VOLUME_SIZE_GB="${EBS_VOLUME_SIZE_GB:-30}"
if ! [[ "$EBS_VOLUME_SIZE_GB" =~ ^[0-9]+$ ]] || [[ "$EBS_VOLUME_SIZE_GB" -lt 10 ]]; then
  log_msg "Invalid EBS_VOLUME_SIZE_GB: $EBS_VOLUME_SIZE_GB (minimo 10 GB per Docker e Paperclip)"
  echo "Error: EBS_VOLUME_SIZE_GB must be an integer >= 10" >&2
  exit 1
fi

# Nomi risorse
EC2_INSTANCE_NAME="${EC2_INSTANCE_NAME:-alnao-paperclip-ec2}"
EBS_VOLUME_NAME="${EBS_VOLUME_NAME:-alnao-paperclip-ebs}"
ENI_NAME="${ENI_NAME:-alnao-paperclip-eni}"
for name_var in EC2_INSTANCE_NAME EBS_VOLUME_NAME ENI_NAME; do
  if [[ -z "${!name_var// }" ]]; then
    log_msg "Invalid $name_var: empty value"
    echo "Error: $name_var cannot be empty" >&2
    exit 1
  fi
done

# Definizione dei 6 Tag obbligatori (Name + i 5 tag comuni):
# 1. Name
# 2. Environment
# 3. Project
# 4. Owner
# 5. CostCenter
# 6. ManagedBy
TAG_ENVIRONMENT="${TAG_ENVIRONMENT:-dev}"
TAG_PROJECT="${TAG_PROJECT:-Paperclip}"
TAG_OWNER="${TAG_OWNER:-AlNao}"
TAG_COST_CENTER="${TAG_COST_CENTER:-dev}"
TAG_MANAGED_BY="${TAG_MANAGED_BY:-Sh}"

COMMON_TAGS="{Key=Environment,Value=$TAG_ENVIRONMENT},{Key=Project,Value=$TAG_PROJECT},{Key=Owner,Value=$TAG_OWNER},{Key=CostCenter,Value=$TAG_COST_CENTER},{Key=ManagedBy,Value=$TAG_MANAGED_BY}"

KEY_NAME=$(resolve_key_name)
if [[ -z "$KEY_NAME" ]]; then
  log_msg "Unable to resolve key name"
  echo "Error: unable to resolve EC2 key name from PEM_PATH/EC2_KEY_NAME" >&2
  exit 1
fi

# Controllo se l'istanza specificata in .env è già attiva
if [[ -n "${EC2_INSTANCE_ID:-}" ]]; then
  EXISTING_ID_STATE=$(aws ec2 describe-instances \
    --region "$AWS_REGION" \
    --instance-ids "$EC2_INSTANCE_ID" \
    --query 'Reservations[0].Instances[0].State.Name' \
    --output text 2>/dev/null || true)

  if [[ -n "$EXISTING_ID_STATE" && "$EXISTING_ID_STATE" != "None" && "$EXISTING_ID_STATE" != "terminated" ]]; then
    log_msg "Creation blocked: EC2_INSTANCE_ID $EC2_INSTANCE_ID already exists in state $EXISTING_ID_STATE"
    echo "Error: EC2_INSTANCE_ID $EC2_INSTANCE_ID already exists (state: $EXISTING_ID_STATE). Aborting create." >&2
    exit 1
  fi
fi

# Controllo se esiste già un'istanza con lo stesso tag Name
EXISTING_TAG_INSTANCE_IDS=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --filters "Name=tag:Name,Values=$EC2_INSTANCE_NAME" "Name=instance-state-name,Values=pending,running,stopping,stopped,shutting-down" \
  --query 'Reservations[].Instances[].InstanceId' \
  --output text)

if [[ -n "$EXISTING_TAG_INSTANCE_IDS" && "$EXISTING_TAG_INSTANCE_IDS" != "None" ]]; then
  log_msg "Creation blocked: instance(s) already exist with Name tag $EC2_INSTANCE_NAME: $EXISTING_TAG_INSTANCE_IDS"
  echo "Error: found existing instance(s) with Name tag '$EC2_INSTANCE_NAME': $EXISTING_TAG_INSTANCE_IDS. Aborting create." >&2
  exit 1
fi

# Risoluzione dinamica AMI Amazon Linux 2023 per l'architettura x86_64
AMI_ID=$(aws ssm get-parameter \
  --region "$AWS_REGION" \
  --name /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 \
  --query 'Parameter.Value' \
  --output text)

if [[ -z "$AMI_ID" || "$AMI_ID" == "None" ]]; then
  log_msg "Unable to resolve AMI ID"
  echo "Error: unable to resolve AMI ID from SSM" >&2
  exit 1
fi

# Risoluzione VPC dal Security Group
VPC_ID=$(aws ec2 describe-security-groups \
  --region "$AWS_REGION" \
  --group-ids "$SECURITY_GROUP_ID" \
  --query 'SecurityGroups[0].VpcId' \
  --output text)

if [[ -z "$VPC_ID" || "$VPC_ID" == "None" ]]; then
  log_msg "Unable to resolve VPC ID from security group"
  echo "Error: unable to resolve VPC ID for security group $SECURITY_GROUP_ID" >&2
  exit 1
fi

# Risoluzione Subnet di default nel VPC
SUBNET_ID=$(aws ec2 describe-subnets \
  --region "$AWS_REGION" \
  --filters "Name=vpc-id,Values=$VPC_ID" "Name=default-for-az,Values=true" \
  --query 'Subnets[0].SubnetId' \
  --output text)

if [[ -z "$SUBNET_ID" || "$SUBNET_ID" == "None" ]]; then
  SUBNET_ID=$(aws ec2 describe-subnets \
    --region "$AWS_REGION" \
    --filters "Name=vpc-id,Values=$VPC_ID" \
    --query 'Subnets[0].SubnetId' \
    --output text)
fi

if [[ -z "$SUBNET_ID" || "$SUBNET_ID" == "None" ]]; then
  log_msg "Unable to find subnet in VPC $VPC_ID"
  echo "Error: unable to find subnet in VPC $VPC_ID" >&2
  exit 1
fi

# Generazione secrets per Paperclip
BETTER_AUTH_SECRET_VAL=$(openssl rand -hex 32)
PAPERCLIP_TOOL_ACTION_SIGNING_SECRET_VAL=$(openssl rand -hex 32)
PAPERCLIP_PORT_VAL="${PAPERCLIP_PORT:-3100}"
PAPERCLIP_DEPLOYMENT_MODE_VAL="${PAPERCLIP_DEPLOYMENT_MODE:-authenticated}"
PAPERCLIP_DEPLOYMENT_EXPOSURE_VAL="${PAPERCLIP_DEPLOYMENT_EXPOSURE:-private}"
ANTHROPIC_KEY_VAL="${ANTHROPIC_API_KEY:-}"
OPENAI_KEY_VAL="${OPENAI_API_KEY:-}"

# Creazione script User Data per bootstrap su EC2 (Docker + Paperclip)
USER_DATA_FILE=$(mktemp)
trap 'rm -f "$USER_DATA_FILE"' EXIT
cat > "$USER_DATA_FILE" <<EOF
#!/usr/bin/env bash
set -euo pipefail
LOG_BOOTSTRAP="/var/log/paperclip_bootstrap.log"
exec >> "\$LOG_BOOTSTRAP" 2>&1

echo "\$(date +'%Y-%m-%d %H:%M:%S') Starting Paperclip bootstrap"

# Installazione Docker, Git e dipendenze
dnf update -y
dnf install -y docker git curl jq

# Abilitazione e avvio del servizio Docker
systemctl enable --now docker
usermod -aG docker ec2-user

# Installazione Docker Compose plugin
DOCKER_PLUGINS_DIR="/usr/local/lib/docker/cli-plugins"
mkdir -p "\$DOCKER_PLUGINS_DIR"
curl -sSL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-\$(uname -m)" -o "\$DOCKER_PLUGINS_DIR/docker-compose"
chmod +x "\$DOCKER_PLUGINS_DIR/docker-compose"
ln -sf "\$DOCKER_PLUGINS_DIR/docker-compose" /usr/local/bin/docker-compose
ln -sf "\$DOCKER_PLUGINS_DIR/docker-compose" /usr/bin/docker-compose

# Preparazione directory Paperclip
mkdir -p /opt/paperclip
cd /opt/paperclip

# Clone del repository ufficiale Paperclip
if [[ ! -d "/opt/paperclip/paperclip" ]]; then
  git clone https://github.com/paperclipai/paperclip.git /opt/paperclip/paperclip
fi

# Configurazione .env per Paperclip Docker Compose
cat > /opt/paperclip/paperclip/docker/.env <<'ENV_EOF'
HOST=0.0.0.0
PAPERCLIP_PORT=${PAPERCLIP_PORT_VAL}
PAPERCLIP_HOME=/paperclip
PAPERCLIP_DEPLOYMENT_MODE=${PAPERCLIP_DEPLOYMENT_MODE_VAL}
PAPERCLIP_DEPLOYMENT_EXPOSURE=${PAPERCLIP_DEPLOYMENT_EXPOSURE_VAL}
BETTER_AUTH_SECRET=${BETTER_AUTH_SECRET_VAL}
PAPERCLIP_TOOL_ACTION_SIGNING_SECRET=${PAPERCLIP_TOOL_ACTION_SIGNING_SECRET_VAL}
ANTHROPIC_API_KEY=${ANTHROPIC_KEY_VAL}
OPENAI_API_KEY=${OPENAI_KEY_VAL}
ENV_EOF

# Creazione del servizio Systemd per Paperclip
cat > /etc/systemd/system/paperclip.service <<'SERVICE_EOF'
[Unit]
Description=Paperclip AI Orchestration Platform
Requires=docker.service
After=docker.service network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/opt/paperclip/paperclip/docker
ExecStart=/usr/local/bin/docker-compose -f docker-compose.quickstart.yml up -d --build
ExecStop=/usr/local/bin/docker-compose -f docker-compose.quickstart.yml down
TimeoutStartSec=600

[Install]
WantedBy=multi-user.target
SERVICE_EOF

systemctl daemon-reload
systemctl enable --now paperclip.service

echo "\$(date +'%Y-%m-%d %H:%M:%S') Paperclip bootstrap completed"
EOF

log_msg "Creating EC2 instance ($INSTANCE_TYPE, disk ${EBS_VOLUME_SIZE_GB}GB) with all 6 tags on instance, volume and ENI..."

# Creazione istanza EC2 con tagging simultaneo di instance, volume ed ENI (tutti e 6 i tag)
INSTANCE_ID=$(aws ec2 run-instances \
  --region "$AWS_REGION" \
  --image-id "$AMI_ID" \
  --instance-type "$INSTANCE_TYPE" \
  --key-name "$KEY_NAME" \
  --security-group-ids "$SECURITY_GROUP_ID" \
  --subnet-id "$SUBNET_ID" \
  --block-device-mappings "[{\"DeviceName\":\"/dev/xvda\",\"Ebs\":{\"VolumeSize\":$EBS_VOLUME_SIZE_GB,\"VolumeType\":\"gp3\",\"DeleteOnTermination\":true}}]" \
  --user-data "file://$USER_DATA_FILE" \
  --tag-specifications \
    "ResourceType=instance,Tags=[{Key=Name,Value=$EC2_INSTANCE_NAME},$COMMON_TAGS]" \
    "ResourceType=volume,Tags=[{Key=Name,Value=$EBS_VOLUME_NAME},$COMMON_TAGS]" \
    "ResourceType=network-interface,Tags=[{Key=Name,Value=$ENI_NAME},$COMMON_TAGS]" \
  --query 'Instances[0].InstanceId' \
  --output text)

if [[ -z "$INSTANCE_ID" || "$INSTANCE_ID" == "None" ]]; then
  log_msg "EC2 creation failed: empty instance ID"
  echo "Error: EC2 creation failed" >&2
  exit 1
fi

log_msg "Waiting for instance $INSTANCE_ID to reach running state"
aws ec2 wait instance-running --region "$AWS_REGION" --instance-ids "$INSTANCE_ID"

# Controllo e riapplicazione garantita dei 6 tag per tutti i volumi e interfacce di rete associati
VOLUME_IDS=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].BlockDeviceMappings[].Ebs.VolumeId' \
  --output text)

for vol_id in $VOLUME_IDS; do
  aws ec2 create-tags \
    --region "$AWS_REGION" \
    --resources "$vol_id" \
    --tags "Key=Name,Value=$EBS_VOLUME_NAME" \
           "Key=Environment,Value=$TAG_ENVIRONMENT" \
           "Key=Project,Value=$TAG_PROJECT" \
           "Key=Owner,Value=$TAG_OWNER" \
           "Key=CostCenter,Value=$TAG_COST_CENTER" \
           "Key=ManagedBy,Value=$TAG_MANAGED_BY" >/dev/null
  log_msg "Verified 6 tags on volume $vol_id"
done

ENI_IDS=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].NetworkInterfaces[].NetworkInterfaceId' \
  --output text)

for eni_id in $ENI_IDS; do
  aws ec2 create-tags \
    --region "$AWS_REGION" \
    --resources "$eni_id" \
    --tags "Key=Name,Value=$ENI_NAME" \
           "Key=Environment,Value=$TAG_ENVIRONMENT" \
           "Key=Project,Value=$TAG_PROJECT" \
           "Key=Owner,Value=$TAG_OWNER" \
           "Key=CostCenter,Value=$TAG_COST_CENTER" \
           "Key=ManagedBy,Value=$TAG_MANAGED_BY" >/dev/null
  log_msg "Verified 6 tags on network interface $eni_id"
done

update_env_instance_id "$INSTANCE_ID"
log_msg "Created instance $INSTANCE_ID and updated .env"

# Ottieni IP Pubblico
PUBLIC_IP=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text 2>/dev/null || true)

echo "=================================================================="
echo "Istanza EC2 creata con successo: $INSTANCE_ID"
echo "Tutte le risorse (Instance, Volume EBS, ENI) sono state taggate con i 6 tag:"
echo " - Name: $EC2_INSTANCE_NAME / $EBS_VOLUME_NAME / $ENI_NAME"
echo " - Environment: $TAG_ENVIRONMENT"
echo " - Project: $TAG_PROJECT"
echo " - Owner: $TAG_OWNER"
echo " - CostCenter: $TAG_COST_CENTER"
echo " - ManagedBy: $TAG_MANAGED_BY"
echo "File .env aggiornato con EC2_INSTANCE_ID=\"$INSTANCE_ID\""
if [[ -n "$PUBLIC_IP" && "$PUBLIC_IP" != "None" ]]; then
  echo "IP Pubblico dell'istanza: $PUBLIC_IP"
  echo ""
  echo "Per accedere all'interfaccia Paperclip tramite Tunnel SSH (consigliato e sicuro):"
  echo "  ssh -i \"$PEM_PATH\" -L ${PAPERCLIP_PORT_VAL}:localhost:${PAPERCLIP_PORT_VAL} ec2-user@$PUBLIC_IP"
  echo "Poi apri nel browser: http://localhost:${PAPERCLIP_PORT_VAL}"
  echo "(Nota: il bootstrap Docker/Paperclip richiede 2-4 minuti per il build iniziale al primo avvio)"
fi
echo "=================================================================="

log_msg "=== Paperclip AI server creation completed ==="
