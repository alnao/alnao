#!/bin/bash
# vpn-lightsail.sh - tunnel WireGuard verso un'istanza Lightsail in Irlanda, creata e cancellata a richiesta.
# Aggira le perdite della linea TIM: tutto il traffico viaggia dentro un solo flusso UDP (problema.md, 3.48).
#
# Uso:  vpn-lightsail.sh up        crea l'istanza (se non c'e') e attiva il tunnel
#       vpn-lightsail.sh down      spegne il tunnel e CANCELLA l'istanza (da quel momento non costa nulla)
#       vpn-lightsail.sh reconnect istanza gia' attiva ma tunnel spento: riaccende solo il tunnel
#       vpn-lightsail.sh status    stato dell'istanza e del tunnel, IP pubblico in uso
#       vpn-lightsail.sh diag      entra via SSH nel server e mostra WireGuard e il log di installazione
#       vpn-lightsail.sh test      50 richieste HTTPS e 150 query DNS attraverso il tunnel
#
# Requisiti: aws CLI configurata, NetworkManager, wireguard-tools (sudo apt install wireguard-tools).
# Un'istanza Lightsail spenta (stopped) si paga lo stesso: per questo "down" la cancella.
#
# Sicurezza della rete: il tunnel completo (tutto il traffico) viene attivato SOLO dopo aver verificato
# l'handshake con un tunnel "di prova" che porta soltanto 10.66.0.1, quindi internet non si interrompe.
set -euo pipefail

REGION=eu-west-1
AZ=eu-west-1a
NAME=vpn-tim
BUNDLE=nano_3_0          # $5/mese, 0,5 GB RAM, 2 vCPU, 1 TB di traffico
BLUEPRINT=debian_13
PORT=51820
CON=wg-lightsail         # nome della connessione NetworkManager e dell'interfaccia
DIR=~/.config/vpn-lightsail
NET=10.66.0
PEM=$DIR/lightsail-default.pem

# tag applicati alle risorse create (stessi tag di aws_dev_server/create_dev_server.sh)
TAG_ENVIRONMENT="${TAG_ENVIRONMENT:-dev}"
TAG_PROJECT="${TAG_PROJECT:-Proxy}"
TAG_OWNER="${TAG_OWNER:-AlNao}"
TAG_COST_CENTER="${TAG_COST_CENTER:-dev}"
TAG_MANAGED_BY="${TAG_MANAGED_BY:-Sh}"
TAGS=("key=Name,value=$NAME" "key=Environment,value=$TAG_ENVIRONMENT" "key=Project,value=$TAG_PROJECT"
      "key=Owner,value=$TAG_OWNER" "key=CostCenter,value=$TAG_COST_CENTER" "key=ManagedBy,value=$TAG_MANAGED_BY")

aws_ls() { aws lightsail --region "$REGION" "$@"; }

tunnel_attivo() { nmcli -t -f NAME con show --active | grep -qx "$CON"; }

stato_istanza() {
  aws_ls get-instance --instance-name "$NAME" --query 'instance.state.name' --output text 2>/dev/null || echo assente
}

ip_istanza() { aws_ls get-instance --instance-name "$NAME" --query 'instance.publicIpAddress' --output text; }

ssh_srv() {
  ssh -i "$PEM" -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=no \
      -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR "admin@$(ip_istanza)" "$@"
}

chiavi_client() {
  mkdir -p "$DIR"; chmod 700 "$DIR"
  [ -f "$DIR/client.key" ] || (umask 077; wg genkey > "$DIR/client.key")
  wg pubkey < "$DIR/client.key" > "$DIR/client.pub"
  [ -s "$PEM" ] || (umask 077; aws_ls download-default-key-pair --query privateKeyBase64 --output text > "$PEM")
}

# firewall Lightsail: WireGuard aperto; SSH solo dall'IP pubblico attuale e dalla console web
porte_firewall() {
  local myip; myip=$(curl -4 -s --max-time 10 https://api.ipify.org)
  aws_ls put-instance-public-ports --instance-name "$NAME" --port-infos \
    "fromPort=$PORT,toPort=$PORT,protocol=udp" \
    "fromPort=22,toPort=22,protocol=tcp,cidrs=$myip/32,cidrListAliases=lightsail-connect" >/dev/null
}

crea_istanza() {
  # chiavi del server nuove a ogni creazione
  (umask 077; wg genkey > "$DIR/server.key")
  wg pubkey < "$DIR/server.key" > "$DIR/server.pub"
  local ud; ud=$(mktemp); chmod 600 "$ud"
  cat > "$ud" <<EOF
#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -q && apt-get install -y -q wireguard-tools nftables
echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/99-wg.conf && sysctl -p /etc/sysctl.d/99-wg.conf
mkdir -p /etc/wireguard
umask 077
cat > /etc/wireguard/wg0.conf <<WG
[Interface]
Address = $NET.1/24
ListenPort = $PORT
PrivateKey = $(cat "$DIR/server.key")
PostUp = nft add table ip wgnat; nft add chain ip wgnat post '{ type nat hook postrouting priority 100; }'; nft add rule ip wgnat post ip saddr $NET.0/24 oifname != "wg0" masquerade
PostDown = nft delete table ip wgnat

[Peer]
PublicKey = $(cat "$DIR/client.pub")
AllowedIPs = $NET.2/32
WG
systemctl enable --now wg-quick@wg0
EOF
  echo "Creo l'istanza $NAME ($BUNDLE, $BLUEPRINT, $AZ)..."
  aws_ls create-instances --instance-names "$NAME" --availability-zone "$AZ" \
    --blueprint-id "$BLUEPRINT" --bundle-id "$BUNDLE" --user-data "file://$ud" \
    --tags "${TAGS[@]}" >/dev/null
  rm -f "$ud"
  until [ "$(stato_istanza)" = running ]; do sleep 5; done
}

# aspetta che il server abbia finito l'installazione e che WireGuard sia in ascolto
attendi_server() {
  echo "Attendo che il server installi WireGuard (di solito 2-4 minuti)..."
  for t in $(seq 1 40); do
    if out=$(ssh_srv 'cloud-init status --wait >/dev/null 2>&1; sudo wg show wg0 listen-port 2>/dev/null || echo NO_WG' 2>/dev/null); then
      if [ "$out" = "$PORT" ]; then echo "Server pronto (WireGuard in ascolto su $PORT)"; return 0; fi
      echo "Installazione finita ma WireGuard NON e' attivo. Diagnosi:"; diag; exit 1
    fi
    sleep 10
  done
  echo "Il server non risponde in SSH dopo ~7 minuti. Prova: $0 diag"; exit 1
}

# $1 = IP server, $2 = porta locale, $3 = AllowedIPs, $4 = "completo" per DNS e rotta di default
configura_nm() {
  local ip=$1 lport=$2 allowed=$3 dns=""
  [ "${4:-}" = completo ] && dns="DNS = 1.1.1.1, 8.8.8.8"
  (umask 077; cat > "$DIR/$CON.conf" <<EOF
[Interface]
PrivateKey = $(cat "$DIR/client.key")
Address = $NET.2/24
$dns
MTU = 1420
ListenPort = $lport

[Peer]
PublicKey = $(cat "$DIR/server.pub")
Endpoint = $ip:$PORT
AllowedIPs = $allowed
PersistentKeepalive = 25
EOF
)
  nmcli con delete "$CON" >/dev/null 2>&1 || true
  nmcli con import type wireguard file "$DIR/$CON.conf" >/dev/null
  nmcli con down "$CON" >/dev/null 2>&1 || true      # l'import puo' attivarla da sola
  nmcli con mod "$CON" connection.autoconnect no ipv6.method disabled
  [ "${4:-}" = completo ] && nmcli con mod "$CON" ipv4.dns-priority -50
  return 0
}

verifica_chiave_server() {
  [ -f "$DIR/server.pub" ] || { echo "L'istanza esiste ma manca $DIR/server.pub: lancia 'down' e poi 'up'."; exit 1; }
}

up() {
  chiavi_client
  case "$(stato_istanza)" in
    assente) crea_istanza ;;
    running)
      verifica_chiave_server
      tunnel_attivo && { echo "Istanza attiva e tunnel gia' acceso: niente da fare."; return 0; }
      # allinea i tag anche sulle istanze create prima che fossero aggiunti
      aws_ls tag-resource --resource-name "$NAME" --tags "${TAGS[@]}" >/dev/null ;;
    *) echo "Istanza in stato $(stato_istanza): aspetta qualche secondo e riprova."; exit 1 ;;
  esac
  porte_firewall
  attendi_server
  local ip; ip=$(ip_istanza)
  echo "Server: $ip:$PORT"
  attiva_tunnel "$ip"
}

# istanza gia' attiva ma tunnel spento (riavvio del PC, cambio di rete, nmcli con down...):
# riaccende solo il tunnel, senza ricreare nulla su AWS
reconnect() {
  local st; st=$(stato_istanza)
  [ "$st" = running ] || { echo "Istanza: $st. Per crearla e attivare il tunnel: $0 up"; exit 1; }
  tunnel_attivo && { echo "Tunnel gia' attivo."; return 0; }
  verifica_chiave_server
  chiavi_client
  attiva_tunnel "$(ip_istanza)"
}

# $1 = IP server
attiva_tunnel() {
  local ip=$1
  # 1) tunnel di prova: porta solo 10.66.0.1, internet resta sulla linea normale.
  #    Ogni tentativo usa una porta locale diversa: se la combinazione e' "rotta" sulla linea TIM, se ne prova un'altra.
  local lport="" ok=""
  for t in $(seq 1 10); do
    lport=$(( 20000 + RANDOM % 40000 ))
    configura_nm "$ip" "$lport" "$NET.1/32"
    nmcli con up "$CON" >/dev/null
    if ping -q -c 2 -W 3 "$NET.1" >/dev/null 2>&1; then ok=1; echo "Handshake ok (porta locale $lport, tentativo $t)"; break; fi
    nmcli con down "$CON" >/dev/null 2>&1 || true
    echo "Tentativo $t, porta $lport: nessuna risposta, riprovo con un'altra porta"
  done
  if [ -z "$ok" ]; then
    echo "Nessun handshake in 10 tentativi: internet non e' stato toccato. Diagnosi del server:"; diag; exit 1
  fi
  # 2) tunnel completo con la porta che ha funzionato; se non risponde si spegne subito
  configura_nm "$ip" "$lport" "0.0.0.0/0" completo
  nmcli con up "$CON" >/dev/null
  if ! ping -q -c 3 -W 3 "$NET.1" >/dev/null 2>&1; then
    nmcli con down "$CON" >/dev/null 2>&1 || true
    echo "Il tunnel completo non risponde: spento, internet torna sulla linea normale."; exit 1
  fi
  echo "Tunnel attivo. IP pubblico ora: $(curl -s --max-time 10 https://api.ipify.org)"
}

down() {
  nmcli con down "$CON" >/dev/null 2>&1 && echo "Tunnel spento" || true
  if [ "$(stato_istanza)" != assente ]; then
    aws_ls delete-instance --instance-name "$NAME" >/dev/null
    echo "Istanza $NAME cancellata: da ora non costa piu' nulla"
  fi
  rm -f "$DIR/server.key" "$DIR/server.pub"
  local sip; sip=$(aws_ls get-static-ips --query 'staticIps[].name' --output text)
  [ -z "$sip" ] || echo "ATTENZIONE: IP statici presenti in $REGION (si pagano se non collegati): $sip"
}

status() {
  local st; st=$(stato_istanza)
  echo "Istanza: $st"
  if tunnel_attivo; then
    echo "Tunnel: attivo"
  else
    echo "Tunnel: spento"
    # l'istanza si paga anche se il tunnel e' spento: o lo si riaccende o la si cancella
    [ "$st" = running ] && echo "ATTENZIONE: istanza attiva ma tunnel spento. Riaccendilo con '$0 reconnect' (oppure '$0 down' per cancellare l'istanza)"
  fi
  echo "IP pubblico in uso: $(curl -s --max-time 10 https://api.ipify.org)"
}

diag() {
  [ "$(stato_istanza)" = running ] || { echo "Istanza: $(stato_istanza)"; return 0; }
  porte_firewall
  ssh_srv 'echo "--- cloud-init: $(cloud-init status 2>&1)"; echo "--- wg show"; sudo wg show 2>&1;
           echo "--- wg-quick@wg0"; sudo systemctl status wg-quick@wg0 --no-pager 2>&1 | tail -15;
           echo "--- nft"; sudo nft list ruleset 2>&1 | head -30;
           echo "--- log installazione"; sudo tail -40 /var/log/cloud-init-output.log' \
    || echo "SSH non riuscito verso $(ip_istanza)"
}

test_tunnel() {
  local url=https://api-test.paths.games/api/echo/status lente=0 errori=0 f=0
  for i in $(seq 1 50); do
    t=$(curl -o /dev/null -s --max-time 30 -w '%{time_total}' "$url") || { errori=$((errori+1)); continue; }
    awk -v t="$t" 'BEGIN{exit !(t>2)}' && lente=$((lente+1))
  done
  echo "HTTPS: $lente lente (>2 s), $errori in errore, su 50"
  for i in $(seq 1 150); do
    p=$(( 20000 + RANDOM % 40000 ))
    dig +tries=1 +time=2 -b "0.0.0.0#$p" @1.1.1.1 A "h$i-$RANDOM.google.com" >/dev/null 2>&1 || f=$((f+1))
  done
  echo "DNS da porte casuali: $f fallite su 150"
}

case "${1:-}" in
  up) up ;;
  down) down ;;
  reconnect) reconnect ;;
  status) status ;;
  diag) diag ;;
  test) test_tunnel ;;
  *) sed -n '5,11p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac