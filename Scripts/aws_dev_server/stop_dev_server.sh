#!/usr/bin/env bash
set -euo pipefail

# Load configuration
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/.env"

log_msg() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "${LOG_PATH}"
}

log_msg "=== Stopping dev server script ==="

# Get current public IP
MY_IP=$(curl -s https://checkip.amazonaws.com)
log_msg "Detected public IP: $MY_IP"

# Remove inbound rule if present
SG_QUERY="SecurityGroups[].IpPermissions[?FromPort==\`0\` && ToPort==\`65535\` && IpRanges[?CidrIp=='${MY_IP}/32']].IpRanges"
RULE_EXISTS=$(aws ec2 describe-security-groups --group-ids "$SECURITY_GROUP_ID" --query "$SG_QUERY" --output text)
if [[ -n "$RULE_EXISTS" ]]; then
  log_msg "Removing inbound rule for $MY_IP from security group $SECURITY_GROUP_ID"
  aws ec2 revoke-security-group-ingress \
    --group-id "$SECURITY_GROUP_ID" \
    --protocol tcp \
    --port 0-65535 \
    --cidr "$MY_IP/32" > /dev/null
  log_msg "Inbound rule removed"
else
  log_msg "No inbound rule for $MY_IP found, nothing to remove"
fi

# Stop EC2 instance if running
INSTANCE_STATE=$(aws ec2 describe-instances --instance-ids "$EC2_INSTANCE_ID" --query 'Reservations[].Instances[].State.Name' --output text)
log_msg "Current instance state: $INSTANCE_STATE"
if [[ "$INSTANCE_STATE" == "running" ]]; then
  log_msg "Stopping EC2 instance $EC2_INSTANCE_ID"
  aws ec2 stop-instances --instance-ids "$EC2_INSTANCE_ID" > /dev/null
  aws ec2 wait instance-stopped --instance-ids "$EC2_INSTANCE_ID"
  log_msg "EC2 instance stopped"
else
  log_msg "EC2 instance not running, no stop needed"
fi

# Kill SSH tunnel if running
if pgrep -f "ssh -i \"$PEM_PATH\" -D 7070" > /dev/null; then
  log_msg "Terminating SSH tunnel"
  pkill -f "ssh -i \"$PEM_PATH\" -D 7070"
  log_msg "SSH tunnel terminated"
else
  log_msg "No SSH tunnel process found"
fi

log_msg "=== Dev server stop completed ==="
