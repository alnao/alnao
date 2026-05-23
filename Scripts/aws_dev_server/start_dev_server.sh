#!/usr/bin/env bash
set -euo pipefail

# Load configuration
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/.env"

log_msg() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "${LOG_PATH}"
}

log_msg "=== Starting dev server script ==="

# Get current public IP
MY_IP=$(curl -s https://checkip.amazonaws.com)
log_msg "Detected public IP: $MY_IP"

# Ensure EC2 instance is running
INSTANCE_STATE=$(aws ec2 describe-instances --instance-ids "$EC2_INSTANCE_ID" --query 'Reservations[].Instances[].State.Name' --output text)
log_msg "Current instance state: $INSTANCE_STATE"
if [[ "$INSTANCE_STATE" != "running" ]]; then
  log_msg "Starting EC2 instance $EC2_INSTANCE_ID"
  aws ec2 start-instances --instance-ids "$EC2_INSTANCE_ID" > /dev/null
  aws ec2 wait instance-running --instance-ids "$EC2_INSTANCE_ID"
  log_msg "EC2 instance started"
fi

# Get public IP of the instance
PUBLIC_IP=$(aws ec2 describe-instances --instance-ids "$EC2_INSTANCE_ID" --query 'Reservations[].Instances[].PublicIpAddress' --output text)
log_msg "Instance public IP: $PUBLIC_IP"

# Ensure security group allows current IP on all ports (TCP 0-65535)
SG_QUERY="SecurityGroups[].IpPermissions[?FromPort==\`0\` && ToPort==\`65535\` && IpRanges[?CidrIp=='${MY_IP}/32']].IpRanges"
RULE_EXISTS=$(aws ec2 describe-security-groups --group-ids "$SECURITY_GROUP_ID" --query "$SG_QUERY" --output text)
if [[ -z "$RULE_EXISTS" ]]; then
  log_msg "Adding inbound rule for $MY_IP to security group $SECURITY_GROUP_ID"
  aws ec2 authorize-security-group-ingress \
    --group-id "$SECURITY_GROUP_ID" \
    --protocol tcp \
    --port 0-65535 \
    --cidr "$MY_IP/32" > /dev/null
  log_msg "Inbound rule added"
else
  log_msg "Inbound rule for $MY_IP already present"
fi

# Create SSH tunnel (dynamic SOCKS proxy on port 7070)
if ss -tlnp | grep -q ':7070 '; then
  log_msg "Port 7070 already in use, skipping SSH tunnel creation"
else
  log_msg "Establishing SSH SOCKS proxy on localhost:7070"
  if ssh -i "$PEM_PATH" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -D 7070 -N -f ec2-user@"$PUBLIC_IP"; then
    log_msg "SSH tunnel established successfully"
  else
    log_msg "SSH tunnel failed"
    exit 1
  fi
fi

log_msg "=== Dev server start completed ==="
