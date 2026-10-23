#!/usr/bin/env bash
set -euo pipefail

# Carica configurazione
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
if [[ ! -f "$SCRIPT_DIR/.env" ]]; then
  echo "Error: file $SCRIPT_DIR/.env non trovato." >&2
  exit 1
fi
source "$SCRIPT_DIR/.env"

log_msg() {
  local log_dir
  log_dir=$(dirname "${LOG_PATH}")
  mkdir -p "$log_dir" 2>/dev/null || true
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "${LOG_PATH}"
}

# Risoluzione EC2_INSTANCE_ID dal tag Name se vuoto
if [[ -z "${EC2_INSTANCE_ID:-}" && -n "${EC2_INSTANCE_NAME:-}" ]]; then
  EC2_INSTANCE_ID=$(aws ec2 describe-instances \
    --region "$AWS_REGION" \
    --filters "Name=tag:Name,Values=$EC2_INSTANCE_NAME" "Name=instance-state-name,Values=pending,running,stopping,stopped" \
    --query 'Reservations[].Instances[].InstanceId' \
    --output text)
  if [[ "$EC2_INSTANCE_ID" == "None" ]]; then
    EC2_INSTANCE_ID=""
  fi
fi

if [[ -z "${EC2_INSTANCE_ID:-}" ]]; then
  echo "Error: EC2_INSTANCE_ID non configurato in .env e nessuna istanza trovata." >&2
  exit 1
fi

log_msg "=== Starting Paperclip server ($EC2_INSTANCE_ID) ==="

PAPERCLIP_PORT="${PAPERCLIP_PORT:-3100}"

# Verifica stato istanza
INSTANCE_STATE=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$EC2_INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].State.Name' \
  --output text)
log_msg "Current instance state: $INSTANCE_STATE"

if [[ "$INSTANCE_STATE" != "running" ]]; then
  log_msg "Starting EC2 instance $EC2_INSTANCE_ID"
  aws ec2 start-instances --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID" > /dev/null
  aws ec2 wait instance-running --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID"
  log_msg "EC2 instance started"
fi

PUBLIC_IP=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$EC2_INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)
log_msg "Instance public IP: $PUBLIC_IP"

# Rilevamento IP pubblico locale
MY_IP=$(curl -s https://checkip.amazonaws.com || true)
if [[ -n "$MY_IP" && -n "${SECURITY_GROUP_ID:-}" ]]; then
  log_msg "Local public IP: $MY_IP"
  # Consenti SSH dalla propria postazione se non già presente
  SSH_RULE_EXISTS=$(aws ec2 describe-security-groups \
    --region "$AWS_REGION" \
    --group-ids "$SECURITY_GROUP_ID" \
    --query "SecurityGroups[].IpPermissions[?FromPort==\`22\` && ToPort==\`22\` && IpRanges[?CidrIp=='${MY_IP}/32']].IpRanges" \
    --output text)
  if [[ -z "$SSH_RULE_EXISTS" ]]; then
    log_msg "Adding inbound SSH rule for $MY_IP to security group $SECURITY_GROUP_ID"
    aws ec2 authorize-security-group-ingress \
      --region "$AWS_REGION" \
      --group-id "$SECURITY_GROUP_ID" \
      --protocol tcp \
      --port 22 \
      --cidr "$MY_IP/32" > /dev/null 2>&1 || true
  fi
fi

# Creazione tunnel SSH locale verso la porta di Paperclip (porta 3100)
if ss -tlnp 2>/dev/null | grep -q ":${PAPERCLIP_PORT} "; then
  log_msg "Port $PAPERCLIP_PORT already in use on localhost, skipping SSH tunnel creation"
  echo "Porta $PAPERCLIP_PORT già occupata in locale."
else
  log_msg "Establishing SSH tunnel on localhost:$PAPERCLIP_PORT -> remote:$PAPERCLIP_PORT"
  if ssh -i "$PEM_PATH" \
         -o StrictHostKeyChecking=no \
         -o UserKnownHostsFile=/dev/null \
         -L "${PAPERCLIP_PORT}:localhost:${PAPERCLIP_PORT}" \
         -N -f "ec2-user@$PUBLIC_IP"; then
    log_msg "SSH tunnel established successfully"
    echo "Tunnel SSH stabilito con successo su http://localhost:$PAPERCLIP_PORT"
  else
    log_msg "SSH tunnel creation failed (l'istanza potrebbe stare ancora completando il boot SSH)"
    echo "Nota: se il tunnel fallisce, l'istanza potrebbe stare ancora inizializzando SSH. Riprova tra pochi secondi."
  fi
fi

echo "=================================================================="
echo "Paperclip Server avviato!"
echo "IP Pubblico EC2: $PUBLIC_IP"
echo "URL Dashboard: http://localhost:$PAPERCLIP_PORT"
echo "=================================================================="

log_msg "=== Paperclip server start completed ==="
