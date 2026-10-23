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

log_msg "=== Stopping Paperclip server ($EC2_INSTANCE_ID) ==="

PAPERCLIP_PORT="${PAPERCLIP_PORT:-3100}"

# Chiusura eventuale tunnel SSH locale
if pgrep -f "ssh.*-L ${PAPERCLIP_PORT}:localhost:${PAPERCLIP_PORT}" > /dev/null; then
  log_msg "Terminating SSH tunnel on port $PAPERCLIP_PORT"
  pkill -f "ssh.*-L ${PAPERCLIP_PORT}:localhost:${PAPERCLIP_PORT}" || true
  log_msg "SSH tunnel terminated"
  echo "Tunnel SSH su porta $PAPERCLIP_PORT chiuso."
fi

# Stop dell'istanza EC2
INSTANCE_STATE=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$EC2_INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].State.Name' \
  --output text 2>/dev/null || true)
log_msg "Current instance state: $INSTANCE_STATE"

if [[ "$INSTANCE_STATE" == "running" ]]; then
  log_msg "Stopping EC2 instance $EC2_INSTANCE_ID"
  aws ec2 stop-instances --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID" > /dev/null
  aws ec2 wait instance-stopped --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID"
  log_msg "EC2 instance stopped"
  echo "Istanza EC2 $EC2_INSTANCE_ID arrestata con successo."
else
  log_msg "EC2 instance not running (state: $INSTANCE_STATE), no stop needed"
  echo "L'istanza EC2 non è in esecuzione (stato: $INSTANCE_STATE)."
fi

log_msg "=== Paperclip server stop completed ==="
