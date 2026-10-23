#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ENV_FILE="$SCRIPT_DIR/.env"

if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

echo "=================================================================="
echo "Stato Container Paperclip AI:"
docker compose -f "$SCRIPT_DIR/docker-compose.yml" ps

echo ""
echo "Spazio occupato nel volume esterno (${PAPERCLIP_DATA_DIR:-/mnt/Dati4/paperclip_data}):"
if [[ -d "${PAPERCLIP_DATA_DIR:-/mnt/Dati4/paperclip_data}" ]]; then
  du -sh "${PAPERCLIP_DATA_DIR:-/mnt/Dati4/paperclip_data}" 2>/dev/null || true
else
  echo "Directory non ancora creata."
fi

echo ""
echo "Ultimi 25 log del container:"
echo "------------------------------------------------------------------"
docker compose -f "$SCRIPT_DIR/docker-compose.yml" logs --tail 25
echo "=================================================================="
echo "Per seguire i log in streaming: docker compose -f $SCRIPT_DIR/docker-compose.yml logs -f"
