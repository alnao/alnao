# AWS Dev Server

Script per gestire una piccola istanza EC2 (Amazon Linux 2023, `t3.micro`) usata come **proxy SOCKS** personale: il PC apre un tunnel SSH verso l'istanza e il traffico passa da `localhost:7070`.

Tutti gli script leggono la configurazione da `.env` (nella stessa cartella) e scrivono il log nel file indicato da `LOG_PATH`.

## Configurazione

Copia `.env.example` in `.env` e compila i valori:

| Variabile | Descrizione |
|---|---|
| `AWS_REGION` | Regione AWS (es. `eu-central-1`) |
| `EC2_INSTANCE_ID` | ID dell'istanza; viene scritto in automatico da `create_dev_server.sh` |
| `SECURITY_GROUP_ID` | Security group dell'istanza, dove vengono aggiunte/rimosse le regole per il tuo IP |
| `PEM_PATH` | Chiave privata SSH (`.pem`) usata per il tunnel |
| `EC2_KEY_NAME` | Nome della key pair in AWS (se assente viene ricavato dal nome del file `.pem`) |
| `EBS_VOLUME_SIZE_GB` | Dimensione del disco (default `8`) |
| `EC2_INSTANCE_NAME`, `EBS_VOLUME_NAME` | Tag `Name` di istanza e volume (default `alnao-dev-proxy-ec2` / `alnao-dev-proxy-ebs`) |
| `LOG_PATH` | File di log comune a tutti gli script |

Requisiti: `aws` CLI v2 configurata con credenziali valide, `curl`, `ssh`. Tutti gli script passano `--region "$AWS_REGION"` ad ogni chiamata AWS, quindi la regione di default del profilo non conta.

## Script

### `create_dev_server.sh`
Crea una nuova istanza EC2:
- si blocca se esiste già un'istanza attiva con lo stesso `EC2_INSTANCE_ID` o con lo stesso tag `Name`;
- ricava l'ultima AMI Amazon Linux 2023 da SSM, la VPC dal security group e la subnet di default;
- lancia una `t3.micro` con disco `gp3` (cancellato alla terminazione) e tag comuni (`Environment`, `Project`, `Owner`, `CostCenter`, `ManagedBy`) su istanza, volume e interfaccia di rete;
- aspetta che sia `running` e scrive il nuovo `EC2_INSTANCE_ID` in `.env`.

### `start_dev_server.sh`
Avvia il proxy:
1. rileva il tuo IP pubblico (`checkip.amazonaws.com`);
2. avvia l'istanza se è spenta e aspetta che sia `running`;
3. aggiunge al security group una regola in ingresso TCP 0-65535 per il tuo IP (`/32`);
4. apre il tunnel SSH SOCKS (`ssh -D 7070 -N -f`) verso `ec2-user@<IP istanza>`, se la porta 7070 non è già occupata.

### `stop_dev_server.sh`
Ferma il proxy, ed è anche lo script eseguito **allo spegnimento/riavvio** del PC:
1. rimuove dal security group la regola per il tuo IP attuale;
2. chiede lo stop dell'istanza se è `running` (senza aspettare: AWS lo completa da solo);
3. chiude il tunnel SSH.

Ogni chiamata di rete ha un timeout e un passaggio fallito non blocca i successivi: lo script termina sempre in tempi brevi, anche senza rete.

### `terminate_dev_server.sh`
Elimina definitivamente l'istanza (e il suo disco). Se `EC2_INSTANCE_ID` è vuoto cerca l'istanza tramite il tag `EC2_INSTANCE_NAME`; esce senza errori se l'istanza non esiste o è già terminata.

### `esegui-allo-spegnimento.service`
Unit systemd che esegue `stop_dev_server.sh` allo spegnimento e al riavvio. È installata in `/etc/systemd/system/esegui-allo-spegnimento.service`.

Il servizio "parte" al boot senza fare niente (`ExecStart=/bin/true`) e lancia lo script quando viene fermato (`ExecStop`). Siccome systemd allo spegnimento ferma i servizi in ordine inverso rispetto all'avvio, e il servizio è dichiarato `After=` rete, NetworkManager, DNS e `warp-svc` (Cloudflare WARP), lo script gira **prima** che la rete venga spenta. Gira come utente `alnao` (usa le credenziali di `~/.aws`) e ha un tetto massimo di 90 secondi (`TimeoutStopSec`).

Installazione (richiede sudo):
```bash
sudo cp esegui-allo-spegnimento.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now esegui-allo-spegnimento.service
```

Verifica dopo un riavvio:
```bash
journalctl -b -1 -u esegui-allo-spegnimento.service
tail ~/.aws/dev_server.log
```

## Uso tipico

```bash
./create_dev_server.sh      # una volta sola, crea l'istanza
./start_dev_server.sh       # avvia istanza + tunnel, poi usa il proxy SOCKS su localhost:7070
./stop_dev_server.sh        # ferma tutto (lo fa anche lo spegnimento del PC)
./terminate_dev_server.sh   # elimina l'istanza quando non serve più
```

## Modifiche del 23/10/2026: spegnimento che restava appeso

**Problema.** A volte lo spegnimento del PC restava bloccato. Il log mostrava che, quando partiva allo spegnimento, `stop_dev_server.sh` non arrivava mai in fondo: si fermava dopo "Stopping dev server script" o dopo "Detected public IP", quindi né la regola del security group né l'istanza venivano fermate.

**Cause.**
- Il vecchio servizio (`DefaultDependencies=no`, `Before=shutdown.target`) lanciava lo script quando rete, DNS e Cloudflare WARP (da cui passa il traffico verso AWS) si stavano già spegnendo.
- Nessuna chiamata di rete aveva un limite: `curl` senza timeout, `aws` con 60 s di connect timeout più i retry, `aws ec2 wait` fino a ~10 minuti, e il servizio con `TimeoutStartSec=0` (attesa infinita).
- Con `set -e` un errore qualsiasi interrompeva lo script senza lasciare traccia nel log.
- Lo script non girava al riavvio (mancava `reboot.target`).

**Cosa è stato fatto.**
- `stop_dev_server.sh`: timeout su `curl` e su ogni chiamata `aws` (`--cli-connect-timeout 5`, `--cli-read-timeout 10`, massimo 2 tentativi, `timeout 25`), eliminata l'attesa `wait instance-stopped`, ogni passaggio indipendente dagli altri, gestione di `EC2_INSTANCE_ID` assente, errori scritti nel log. La versione precedente è in `stop_dev_server.sh.bak`.
- Nuovo `esegui-allo-spegnimento.service`: lo script ora gira come `ExecStop` di un servizio avviato dopo rete e WARP, quindi allo spegnimento gira prima che vengano fermati. Copre anche il riavvio, gira come `alnao` e ha un limite di 90 s.
- Il servizio è stato installato al posto del vecchio in `/etc/systemd/system/`.
