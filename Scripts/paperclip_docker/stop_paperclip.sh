#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ENV_FILE="$SCRIPT_DIR/.env"

echo "=== Arresto di Paperclip AI Locale ==="

if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

if docker compose -f "$SCRIPT_DIR/docker-compose.yml" stop 2>/dev/null; then
  echo "Container paperclip-ai fermato con successo."
  echo "I dati, i task e le impostazioni restano salvati nel volume esterno:"
  echo "${PAPERCLIP_DATA_DIR:-/mnt/Dati4/paperclip_data}"
else
  echo "Nessun container attivo trovato per Paperclip."
fi
