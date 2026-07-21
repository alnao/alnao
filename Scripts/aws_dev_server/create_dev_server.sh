#!/usr/bin/env bash
set -euo pipefail

# Load configuration
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/.env"

log_msg() {
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

log_msg "=== Creating dev server ==="

require_command aws
require_command mktemp

EBS_VOLUME_SIZE_GB="${EBS_VOLUME_SIZE_GB:-8}"
if ! [[ "$EBS_VOLUME_SIZE_GB" =~ ^[0-9]+$ ]] || [[ "$EBS_VOLUME_SIZE_GB" -lt 1 ]]; then
  log_msg "Invalid EBS_VOLUME_SIZE_GB: $EBS_VOLUME_SIZE_GB"
  echo "Error: EBS_VOLUME_SIZE_GB must be an integer >= 1" >&2
  exit 1
fi

EC2_NAME_TAG="${EC2_NAME_TAG:-alnao-dev-proxy-server}"
if [[ -z "${EC2_NAME_TAG// }" ]]; then
  log_msg "Invalid EC2_NAME_TAG: empty value"
  echo "Error: EC2_NAME_TAG cannot be empty" >&2
  exit 1
fi

KEY_NAME=$(resolve_key_name)
if [[ -z "$KEY_NAME" ]]; then
  log_msg "Unable to resolve key name"
  echo "Error: unable to resolve EC2 key name from PEM_PATH/EC2_KEY_NAME" >&2
  exit 1
fi

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

EXISTING_TAG_INSTANCE_IDS=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --filters "Name=tag:Name,Values=$EC2_NAME_TAG" "Name=instance-state-name,Values=pending,running,stopping,stopped,shutting-down" \
  --query 'Reservations[].Instances[].InstanceId' \
  --output text)

if [[ -n "$EXISTING_TAG_INSTANCE_IDS" && "$EXISTING_TAG_INSTANCE_IDS" != "None" ]]; then
  log_msg "Creation blocked: instance(s) already exist with Name tag $EC2_NAME_TAG: $EXISTING_TAG_INSTANCE_IDS"
  echo "Error: found existing instance(s) with Name tag '$EC2_NAME_TAG': $EXISTING_TAG_INSTANCE_IDS. Aborting create." >&2
  exit 1
fi

# Resolve latest Amazon Linux 2023 AMI dynamically for the selected region.
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

SUBNET_ID=$(aws ec2 describe-subnets \
  --region "$AWS_REGION" \
  --filters "Name=vpc-id,Values=$VPC_ID" "Name=default-for-az,Values=true" \
  --query 'Subnets[0].SubnetId' \
  --output text)

if [[ -z "$SUBNET_ID" || "$SUBNET_ID" == "None" ]]; then
  log_msg "Unable to find default subnet in VPC $VPC_ID"
  echo "Error: unable to find a default subnet in VPC $VPC_ID" >&2
  exit 1
fi

USER_DATA_FILE=$(mktemp)
trap 'rm -f "$USER_DATA_FILE"' EXIT
cat > "$USER_DATA_FILE" <<'EOF'
#!/bin/bash
echo "$(date +'%Y-%m-%d %H:%M:%S') user_data bootstrap executed" >> /var/log/dev_server_user_data.log
EOF

log_msg "Creating EC2 with AMI $AMI_ID, key $KEY_NAME, security group $SECURITY_GROUP_ID, subnet $SUBNET_ID, name tag $EC2_NAME_TAG"
INSTANCE_ID=$(aws ec2 run-instances \
  --region "$AWS_REGION" \
  --image-id "$AMI_ID" \
  --instance-type t3.micro \
  --key-name "$KEY_NAME" \
  --security-group-ids "$SECURITY_GROUP_ID" \
  --subnet-id "$SUBNET_ID" \
  --block-device-mappings "[{\"DeviceName\":\"/dev/xvda\",\"Ebs\":{\"VolumeSize\":$EBS_VOLUME_SIZE_GB,\"VolumeType\":\"gp3\",\"DeleteOnTermination\":true}}]" \
  --user-data "file://$USER_DATA_FILE" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$EC2_NAME_TAG}]" "ResourceType=volume,Tags=[{Key=Name,Value=$EC2_NAME_TAG}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

if [[ -z "$INSTANCE_ID" || "$INSTANCE_ID" == "None" ]]; then
  log_msg "EC2 creation failed: empty instance ID"
  echo "Error: EC2 creation failed" >&2
  exit 1
fi

log_msg "Waiting for instance $INSTANCE_ID to reach running state"
aws ec2 wait instance-running --region "$AWS_REGION" --instance-ids "$INSTANCE_ID"

update_env_instance_id "$INSTANCE_ID"
log_msg "Created instance $INSTANCE_ID and updated .env"

echo "Created EC2 instance: $INSTANCE_ID"
echo "Updated $SCRIPT_DIR/.env"

log_msg "=== Dev server creation completed ==="
