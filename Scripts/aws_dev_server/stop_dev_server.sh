#!/usr/bin/env bash
# Also run at system shutdown (esegui-allo-spegnimento.service): every network call
# has a timeout and a failed step does not abort the next ones, so shutdown never hangs
set -uo pipefail

# Load configuration
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$SCRIPT_DIR/.env"

log_msg() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') $1" >> "${LOG_PATH}"
}

# Errors go to the log too (at shutdown there is no terminal to read them)
exec 2>>"${LOG_PATH}"

# AWS CLI with short timeouts and few retries (defaults: 60s connect timeout + retries)
export AWS_RETRY_MODE=standard
export AWS_MAX_ATTEMPTS=2
aws_call() {
  timeout 25 aws --region "$AWS_REGION" --cli-connect-timeout 5 --cli-read-timeout 10 "$@"
}

log_msg "=== Stopping dev server script ==="

# Get current public IP
MY_IP=$(curl -s --connect-timeout 3 --max-time 5 https://checkip.amazonaws.com || true)
log_msg "Detected public IP: ${MY_IP:-<none>}"

# Remove inbound rule if present
if [[ -z "$MY_IP" ]]; then
  log_msg "Public IP not available (network down?), skipping security group cleanup"
else
  SG_QUERY="SecurityGroups[].IpPermissions[?FromPort==\`0\` && ToPort==\`65535\` && IpRanges[?CidrIp=='${MY_IP}/32']].IpRanges"
  if ! RULE_EXISTS=$(aws_call ec2 describe-security-groups --group-ids "$SECURITY_GROUP_ID" --query "$SG_QUERY" --output text); then
    log_msg "Failed to query security group $SECURITY_GROUP_ID"
  elif [[ -n "$RULE_EXISTS" ]]; then
    log_msg "Removing inbound rule for $MY_IP from security group $SECURITY_GROUP_ID"
    if aws_call ec2 revoke-security-group-ingress \
      --group-id "$SECURITY_GROUP_ID" \
      --protocol tcp \
      --port 0-65535 \
      --cidr "$MY_IP/32" > /dev/null; then
      log_msg "Inbound rule removed"
    else
      log_msg "Failed to remove inbound rule"
    fi
  else
    log_msg "No inbound rule for $MY_IP found, nothing to remove"
  fi
fi

# Stop EC2 instance if running (no wait: once requested, AWS completes the stop on its own)
if [[ -z "${EC2_INSTANCE_ID:-}" ]]; then
  log_msg "EC2_INSTANCE_ID not set, no instance to stop"
elif ! INSTANCE_STATE=$(aws_call ec2 describe-instances --instance-ids "$EC2_INSTANCE_ID" --query 'Reservations[].Instances[].State.Name' --output text); then
  log_msg "Failed to read state of EC2 instance $EC2_INSTANCE_ID"
else
  log_msg "Current instance state: $INSTANCE_STATE"
  if [[ "$INSTANCE_STATE" == "running" ]]; then
    log_msg "Stopping EC2 instance $EC2_INSTANCE_ID"
    if aws_call ec2 stop-instances --instance-ids "$EC2_INSTANCE_ID" > /dev/null; then
      log_msg "EC2 instance stop requested"
    else
      log_msg "Failed to stop EC2 instance $EC2_INSTANCE_ID"
    fi
  else
    log_msg "EC2 instance not running, no stop needed"
  fi
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
exit 0

: <<'FINE_COMMENTO' # Metti sempre gli apici singoli (' ') attorno alla prima parola ('FINE_COMMENTO').
- ciao, uso debian 13 e vorrei eseguire un sh ogni volta che spengo il computer
	Versione attuale: il servizio parte al boot (ExecStart=/bin/true) e lo script gira come ExecStop.
	Allo spegnimento systemd ferma i servizi in ordine inverso, quindi con After=network-online.target
	e After=warp-svc.service lo script gira PRIMA che rete e Cloudflare WARP vengano spenti.
	Funziona anche al riavvio. TimeoutStopSec limita comunque l'attesa massima.
	File: esegui-allo-spegnimento.service (in questa cartella)
		sudo systemctl disable esegui-allo-spegnimento.service
		sudo cp esegui-allo-spegnimento.service /etc/systemd/system/esegui-allo-spegnimento.service
		sudo systemctl daemon-reload
		sudo systemctl enable --now esegui-allo-spegnimento.service
	Verifica dopo un riavvio:
		journalctl -b -1 -u esegui-allo-spegnimento.service
		tail ~/.aws/dev_server.log
	Versione precedente (si bloccava: girava a rete/WARP già spenti e senza timeout):
		[Unit]
		DefaultDependencies=no
		Before=shutdown.target poweroff.target halt.target
		[Service]
		Type=oneshot
		ExecStart=/usr/local/bin/mioscript.sh
		TimeoutStartSec=0
		[Install]
		WantedBy=shutdown.target poweroff.target halt.target
FINE_COMMENTO
