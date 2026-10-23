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
  if [[ "$EC2_INSTANCE_ID" =~ [[:space:]] ]]; then
    echo "Error: trovate istanze multiple con il tag Name '$EC2_INSTANCE_NAME': $EC2_INSTANCE_ID" >&2
    exit 1
  fi
fi

if [[ -z "${EC2_INSTANCE_ID:-}" ]]; then
  echo "Error: EC2_INSTANCE_ID è vuoto in $SCRIPT_DIR/.env e nessuna istanza trovata con Name '$EC2_INSTANCE_NAME'" >&2
  exit 1
fi

log_msg "=== Terminating Paperclip server ($EC2_INSTANCE_ID) ==="

PAPERCLIP_PORT="${PAPERCLIP_PORT:-3100}"
# Chiusura tunnel SSH
if pgrep -f "ssh.*-L ${PAPERCLIP_PORT}:localhost:${PAPERCLIP_PORT}" > /dev/null; then
  pkill -f "ssh.*-L ${PAPERCLIP_PORT}:localhost:${PAPERCLIP_PORT}" || true
fi

INSTANCE_STATE=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$EC2_INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].State.Name' \
  --output text 2>/dev/null || true)

if [[ -z "$INSTANCE_STATE" || "$INSTANCE_STATE" == "None" ]]; then
  log_msg "Instance $EC2_INSTANCE_ID not found"
  echo "Istanza $EC2_INSTANCE_ID non trovata."
  exit 0
fi

if [[ "$INSTANCE_STATE" == "terminated" ]]; then
  log_msg "Instance $EC2_INSTANCE_ID is already terminated"
  echo "Istanza $EC2_INSTANCE_ID già terminata."
  exit 0
fi

echo "Richiesta terminazione per l'istanza $EC2_INSTANCE_ID..."
aws ec2 terminate-instances --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID" > /dev/null
log_msg "Termination requested for instance $EC2_INSTANCE_ID"

aws ec2 wait instance-terminated --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID"
log_msg "Instance $EC2_INSTANCE_ID terminated"

# Reset di EC2_INSTANCE_ID in .env
if grep -q '^EC2_INSTANCE_ID=' "$SCRIPT_DIR/.env"; then
  sed -i 's|^EC2_INSTANCE_ID=.*|EC2_INSTANCE_ID=""|' "$SCRIPT_DIR/.env"
fi

echo "Terminata con successo l'istanza EC2: $EC2_INSTANCE_ID"
echo "EC2_INSTANCE_ID resettato nel file .env."
log_msg "=== Paperclip server termination completed ==="
