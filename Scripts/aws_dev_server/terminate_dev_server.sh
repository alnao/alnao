#!/usr/bin/env bash
set -euo pipefail

# Load configuration
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/.env"

log_msg() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "${LOG_PATH}"
}

if [[ -z "${EC2_INSTANCE_ID:-}" ]]; then
  echo "Error: EC2_INSTANCE_ID is empty in $SCRIPT_DIR/.env" >&2
  exit 1
fi

log_msg "=== Terminating dev server ==="
log_msg "Requested termination for instance $EC2_INSTANCE_ID"

INSTANCE_STATE=$(aws ec2 describe-instances \
  --region "$AWS_REGION" \
  --instance-ids "$EC2_INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].State.Name' \
  --output text 2>/dev/null || true)

if [[ -z "$INSTANCE_STATE" || "$INSTANCE_STATE" == "None" ]]; then
  log_msg "Instance $EC2_INSTANCE_ID not found"
  echo "Instance $EC2_INSTANCE_ID not found"
  exit 0
fi

if [[ "$INSTANCE_STATE" == "terminated" ]]; then
  log_msg "Instance $EC2_INSTANCE_ID is already terminated"
  echo "Instance $EC2_INSTANCE_ID is already terminated"
  exit 0
fi

aws ec2 terminate-instances --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID" > /dev/null
log_msg "Termination requested for instance $EC2_INSTANCE_ID"

aws ec2 wait instance-terminated --region "$AWS_REGION" --instance-ids "$EC2_INSTANCE_ID"
log_msg "Instance $EC2_INSTANCE_ID terminated"

echo "Terminated EC2 instance: $EC2_INSTANCE_ID"
log_msg "=== Dev server termination completed ==="
