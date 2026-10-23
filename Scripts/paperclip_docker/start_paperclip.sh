#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ENV_FILE="$SCRIPT_DIR/.env"
ENV_EXAMPLE="$SCRIPT_DIR/.env.example"

echo "=== Avvio di Paperclip AI in Docker Locale ==="

# Verifica presenza di Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker non è installato sul sistema." >&2
  exit 1
fi

# Verifica se il demone Docker è in esecuzione
if ! docker info >/dev/null 2>&1; then
  echo "Error: il demone Docker non sembra attivo o non hai i permessi necessari (prova ad avviare il servizio docker)." >&2
  exit 1
fi

# Creazione automatica di .env da .env.example se non esiste
if [[ ! -f "$ENV_FILE" ]]; then
  if [[ -f "$ENV_EXAMPLE" ]]; then
    echo "File .env non trovato. Creazione automatica da .env.example..."
    cp "$ENV_EXAMPLE" "$ENV_FILE"
  else
    echo "Error: né .env né .env.example trovati in $SCRIPT_DIR." >&2
    exit 1
  fi
fi

# Caricamento configurazione
# shellcheck disable=SC1090
source "$ENV_FILE"

# Generazione automatica dei secret se non impostati (garantendo persistenza)
UPDATED_ENV=false
if [[ -z "${BETTER_AUTH_SECRET:-}" ]]; then
  NEW_SECRET=$(openssl rand -hex 32)
  if grep -q '^BETTER_AUTH_SECRET=' "$ENV_FILE"; then
    sed -i "s|^BETTER_AUTH_SECRET=.*|BETTER_AUTH_SECRET=\"${NEW_SECRET}\"|" "$ENV_FILE"
  else
    printf '\nBETTER_AUTH_SECRET="%s"\n' "$NEW_SECRET" >> "$ENV_FILE"
  fi
  export BETTER_AUTH_SECRET="$NEW_SECRET"
  UPDATED_ENV=true
fi

if [[ -z "${PAPERCLIP_TOOL_ACTION_SIGNING_SECRET:-}" ]]; then
  NEW_TOOL_SECRET=$(openssl rand -hex 32)
  if grep -q '^PAPERCLIP_TOOL_ACTION_SIGNING_SECRET=' "$ENV_FILE"; then
    sed -i "s|^PAPERCLIP_TOOL_ACTION_SIGNING_SECRET=.*|PAPERCLIP_TOOL_ACTION_SIGNING_SECRET=\"${NEW_TOOL_SECRET}\"|" "$ENV_FILE"
  else
    printf '\nPAPERCLIP_TOOL_ACTION_SIGNING_SECRET="%s"\n' "$NEW_TOOL_SECRET" >> "$ENV_FILE"
  fi
  export PAPERCLIP_TOOL_ACTION_SIGNING_SECRET="$NEW_TOOL_SECRET"
  UPDATED_ENV=true
fi

if [[ "$UPDATED_ENV" = true ]]; then
  echo "Generati e salvati automaticamente secret di sicurezza in $ENV_FILE"
fi

# Configurazione default porta e cartella dati
PAPERCLIP_PORT="${PAPERCLIP_PORT:-3100}"
PAPERCLIP_DATA_DIR="${PAPERCLIP_DATA_DIR:-/mnt/Dati4/paperclip_data}"

# Creazione della directory esterna se non esiste
if [[ ! -d "$PAPERCLIP_DATA_DIR" ]]; then
  echo "Creazione cartella esterna dati persistenti: $PAPERCLIP_DATA_DIR"
  mkdir -p "$PAPERCLIP_DATA_DIR"
fi

echo "Cartella volume dati persistente: $PAPERCLIP_DATA_DIR"
echo "Porta configurata: $PAPERCLIP_PORT"

# Avvio container Docker tramite docker compose
echo "Avvio container Paperclip AI..."
docker compose -f "$SCRIPT_DIR/docker-compose.yml" --env-file "$ENV_FILE" up -d

# Controllo stato del container
sleep 2
if docker ps --filter "name=paperclip-ai" --format '{{.Names}}' | grep -q "paperclip-ai"; then
  echo "=================================================================="
  echo "🎉 Paperclip AI avviato con successo!"
  echo "Dashboard Web: http://localhost:${PAPERCLIP_PORT}"
  echo "Modalità:      ${PAPERCLIP_DEPLOYMENT_MODE:-local_trusted}"
  echo "Volume dati:   ${PAPERCLIP_DATA_DIR}"
  echo "=================================================================="
  echo "Per visualizzare i log in tempo reale: ./status_paperclip.sh"
  echo "Per fermare il container:              ./stop_paperclip.sh"
else
  echo "Attenzione: il container non risulta avviato. Controlla i log con:" >&2
  echo "docker compose -f $SCRIPT_DIR/docker-compose.yml logs" >&2
  exit 1
fi
