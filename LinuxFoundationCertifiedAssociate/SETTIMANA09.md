# Settimana 9 — Automazione & Cloud (LFCA)

**Tempo stimato**: 7-9 ore  
**Obiettivo**: Creare script Bash, automatizzare task con cron, introduzione a Docker e concetti cloud

---

## Introduzione

L'automazione è fondamentale per ridurre errori, risparmiare tempo e rendere ripetibili le operazioni. Questa settimana copre scripting bash, scheduling con cron e un'introduzione a Docker per la containerizzazione.

### Concetti chiave

- **Bash script**: automatizzare sequenze di comandi
- **cron**: scheduler per task ripetitivi
- **systemd timers**: alternativa moderna a cron
- **Docker**: containerizzazione applicazioni

---

## Bash Scripting

Bash (Bourne Again SHell) è l'interprete di comandi standard in Linux.

### Script base

```bash
#!/bin/bash
# Commento: questo è uno script di esempio

echo "Hello, World!"
```

**Shebang** (`#!/bin/bash`): indica quale interprete usare.

### Rendere script eseguibile

```bash
# Crea script
nano myscript.sh

# Rendi eseguibile
chmod +x myscript.sh

# Esegui
./myscript.sh
```

### Variabili

```bash
#!/bin/bash

# Definizione variabile
NAME="Alice"
AGE=30

# Uso variabile
echo "Nome: $NAME"
echo "Età: $AGE"

# Senza spazi attorno a =
WRONG = "value"  # ERRORE!
CORRECT="value"  # OK

# Concatenazione
FULL_NAME="$NAME Smith"
echo $FULL_NAME

# Variabili di sistema
echo "User: $USER"
echo "Home: $HOME"
echo "Path: $PATH"
```

### Variabili speciali

```bash
#!/bin/bash

# $0 = nome script
echo "Script name: $0"

# $1, $2, ... = argomenti
echo "First argument: $1"
echo "Second argument: $2"

# $# = numero argomenti
echo "Number of arguments: $#"

# $@ = tutti gli argomenti
echo "All arguments: $@"

# $? = exit code ultimo comando
ls /nonexistent
echo "Exit code: $?"

# $$ = PID script
echo "Process ID: $$"
```

Esempio uso:
```bash
./script.sh arg1 arg2 arg3
# $0 = ./script.sh
# $1 = arg1
# $2 = arg2
# $# = 3
# $@ = arg1 arg2 arg3
```

### Input utente

```bash
#!/bin/bash

# Leggi input
echo "Inserisci il tuo nome:"
read NAME
echo "Ciao, $NAME!"

# Leggi con prompt inline
read -p "Inserisci età: " AGE
echo "Hai $AGE anni"

# Leggi password (nasconde input)
read -sp "Password: " PASSWORD
echo
echo "Password salvata"

# Leggi con timeout (5 secondi)
read -t 5 -p "Risposta veloce: " ANSWER
```

### Condizioni

#### if statement

```bash
#!/bin/bash

AGE=18

if [ $AGE -ge 18 ]; then
    echo "Maggiorenne"
fi

# if-else
if [ $AGE -ge 18 ]; then
    echo "Maggiorenne"
else
    echo "Minorenne"
fi

# if-elif-else
if [ $AGE -lt 13 ]; then
    echo "Bambino"
elif [ $AGE -lt 18 ]; then
    echo "Adolescente"
else
    echo "Adulto"
fi
```

#### Operatori di confronto

**Numeri:**
```bash
-eq  # uguale
-ne  # diverso
-gt  # maggiore
-ge  # maggiore o uguale
-lt  # minore
-le  # minore o uguale

# Esempi
[ $A -eq $B ]
[ $AGE -gt 18 ]
```

**Stringhe:**
```bash
=    # uguale
!=   # diverso
-z   # stringa vuota
-n   # stringa non vuota

# Esempi
[ "$NAME" = "Alice" ]
[ "$STR" != "" ]
[ -z "$EMPTY" ]
[ -n "$NONEMPTY" ]
```

**File:**
```bash
-e   # esiste
-f   # è file regolare
-d   # è directory
-r   # leggibile
-w   # scrivibile
-x   # eseguibile

# Esempi
if [ -f "/etc/passwd" ]; then
    echo "File exists"
fi

if [ -d "/home/user" ]; then
    echo "Directory exists"
fi
```

### Exit codes

```bash
#!/bin/bash

# Esegui comando
ping -c 1 google.com > /dev/null 2>&1

# Check exit code
if [ $? -eq 0 ]; then
    echo "Ping successful"
else
    echo "Ping failed"
fi

# Forma abbreviata
if ping -c 1 google.com > /dev/null 2>&1; then
    echo "Ping successful"
else
    echo "Ping failed"
fi

# Exit code personalizzato
if [ ! -f "file.txt" ]; then
    echo "Error: file not found"
    exit 1
fi

# 0 = success, 1-255 = error
exit 0
```

### Loop

#### For loop

```bash
#!/bin/bash

# Sequenza numeri
for i in 1 2 3 4 5; do
    echo "Number: $i"
done

# Range
for i in {1..10}; do
    echo $i
done

# Step
for i in {0..20..2}; do
    echo $i  # 0, 2, 4, ..., 20
done

# C-style
for ((i=0; i<5; i++)); do
    echo $i
done

# Lista file
for file in /etc/*.conf; do
    echo "Processing: $file"
done

# Array
FILES=(file1.txt file2.txt file3.txt)
for file in "${FILES[@]}"; do
    echo $file
done
```

#### While loop

```bash
#!/bin/bash

COUNT=0
while [ $COUNT -lt 5 ]; do
    echo "Count: $COUNT"
    COUNT=$((COUNT + 1))
done

# Leggi file riga per riga
while read line; do
    echo "Line: $line"
done < file.txt

# Loop infinito
while true; do
    echo "Running..."
    sleep 1
done

# Until (opposto di while)
COUNT=0
until [ $COUNT -ge 5 ]; do
    echo $COUNT
    COUNT=$((COUNT + 1))
done
```

### Funzioni

```bash
#!/bin/bash

# Definizione funzione
function greet() {
    echo "Hello, $1!"
}

# Chiamata
greet "Alice"
greet "Bob"

# Funzione con return
function add() {
    local result=$(($1 + $2))
    echo $result
}

SUM=$(add 5 3)
echo "Sum: $SUM"

# Return code
function check_file() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

if check_file "/etc/passwd"; then
    echo "File exists"
fi
```

### Operazioni matematiche

```bash
#!/bin/bash

# Arithmetic expansion
A=5
B=3

SUM=$((A + B))
DIFF=$((A - B))
PROD=$((A * B))
DIV=$((A / B))
MOD=$((A % B))

echo "Sum: $SUM"
echo "Diff: $DIFF"
echo "Product: $PROD"
echo "Division: $DIV"
echo "Modulo: $MOD"

# Incremento
COUNT=0
COUNT=$((COUNT + 1))
((COUNT++))
((COUNT += 5))

# bc per floating point
RESULT=$(echo "scale=2; 10 / 3" | bc)
echo $RESULT  # 3.33
```

### Array

```bash
#!/bin/bash

# Definizione array
FRUITS=("apple" "banana" "orange")

# Accesso elementi
echo ${FRUITS[0]}  # apple
echo ${FRUITS[1]}  # banana

# Tutti gli elementi
echo ${FRUITS[@]}
echo ${FRUITS[*]}

# Numero elementi
echo ${#FRUITS[@]}

# Aggiungi elemento
FRUITS+=("grape")

# Loop array
for fruit in "${FRUITS[@]}"; do
    echo $fruit
done

# Indici
for i in "${!FRUITS[@]}"; do
    echo "$i: ${FRUITS[$i]}"
done
```

### Script di esempio completo

```bash
#!/bin/bash
# Backup script con logging

# Configurazione
SOURCE="/home/user/documents"
DEST="/backup"
DATE=$(date +%Y%m%d-%H%M%S)
LOGFILE="/var/log/backup.log"

# Funzione log
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

# Funzione backup
backup() {
    local src="$1"
    local dst="$2"
    
    log "Starting backup from $src to $dst"
    
    if [ ! -d "$src" ]; then
        log "ERROR: Source directory not found"
        return 1
    fi
    
    mkdir -p "$dst"
    
    if rsync -av --delete "$src/" "$dst/backup-$DATE/" >> "$LOGFILE" 2>&1; then
        log "Backup completed successfully"
        
        # Comprimi
        tar -czf "$dst/backup-$DATE.tar.gz" -C "$dst" "backup-$DATE"
        rm -rf "$dst/backup-$DATE"
        
        log "Backup archived: backup-$DATE.tar.gz"
        
        # Pulisci vecchi backup (>7 giorni)
        find "$dst" -name "backup-*.tar.gz" -mtime +7 -delete
        log "Old backups cleaned"
        
        return 0
    else
        log "ERROR: Backup failed"
        return 1
    fi
}

# Main
log "=== Backup script started ==="

if backup "$SOURCE" "$DEST"; then
    log "=== Backup script completed successfully ==="
    exit 0
else
    log "=== Backup script failed ==="
    exit 1
fi
```

---

## Cron - Task Scheduling

cron esegue comandi a intervalli regolari.

### Sintassi crontab

```
# ┌───────────── minuto (0 - 59)
# │ ┌───────────── ora (0 - 23)
# │ │ ┌───────────── giorno del mese (1 - 31)
# │ │ │ ┌───────────── mese (1 - 12)
# │ │ │ │ ┌───────────── giorno della settimana (0 - 7) (0 e 7 = domenica)
# │ │ │ │ │
# │ │ │ │ │
# * * * * * comando da eseguire
```

### Gestione crontab

```bash
# Edita crontab utente corrente
crontab -e

# Visualizza crontab
crontab -l

# Rimuovi crontab
crontab -r

# Edita crontab altro utente (come root)
sudo crontab -u alice -e
```

### Esempi crontab

```bash
# Ogni minuto
* * * * * /path/script.sh

# Ogni ora
0 * * * * /path/script.sh

# Ogni giorno alle 2:30 AM
30 2 * * * /path/script.sh

# Ogni domenica alle 3:00 AM
0 3 * * 0 /path/script.sh

# Primo giorno del mese alle 4:00 AM
0 4 1 * * /path/script.sh

# Ogni 15 minuti
*/15 * * * * /path/script.sh

# Ogni 6 ore
0 */6 * * * /path/script.sh

# Giorni lavorativi (lun-ven) alle 9:00 AM
0 9 * * 1-5 /path/script.sh

# Più orari
0 9,12,18 * * * /path/script.sh
```

### Shortcuts speciali

```bash
@reboot     # All'avvio
@yearly     # Annuale (0 0 1 1 *)
@annually   # Annuale (alias @yearly)
@monthly    # Mensile (0 0 1 * *)
@weekly     # Settimanale (0 0 * * 0)
@daily      # Giornaliero (0 0 * * *)
@midnight   # Mezzanotte (alias @daily)
@hourly     # Ogni ora (0 * * * *)

# Esempi
@daily /path/backup.sh
@reboot /path/startup.sh
```

### Variabili d'ambiente in crontab

```bash
# Definisci variabili all'inizio del crontab
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin
MAILTO=admin@example.com

# Poi i job
0 2 * * * /home/user/backup.sh
```

### Output e logging

```bash
# Redirect a file
0 2 * * * /path/script.sh > /tmp/script.log 2>&1

# Append a log
0 2 * * * /path/script.sh >> /var/log/script.log 2>&1

# Discard output
0 2 * * * /path/script.sh > /dev/null 2>&1

# Mail output (se MAILTO definito)
0 2 * * * /path/script.sh
```

### Cron di sistema

```bash
# Directory cron di sistema
/etc/cron.daily/     # Script giornalieri
/etc/cron.weekly/    # Script settimanali
/etc/cron.monthly/   # Script mensili
/etc/cron.hourly/    # Script ogni ora

# Metti script qui (devono essere eseguibili)
sudo cp script.sh /etc/cron.daily/
sudo chmod +x /etc/cron.daily/script.sh

# File /etc/crontab (system-wide)
sudo nano /etc/crontab
```

### Verificare cron job

```bash
# Log cron (Debian/Ubuntu)
grep CRON /var/log/syslog

# Log cron (RHEL/CentOS)
grep CRON /var/log/cron

# Tail real-time
sudo tail -f /var/log/syslog | grep CRON

# Verifica servizio attivo
systemctl status cron  # Debian/Ubuntu
systemctl status crond # RHEL/CentOS
```

---

## systemd Timers

Alternativa moderna a cron, più flessibile e integrata con systemd.

### Creare timer

Due file necessari:
1. Service file (`.service`)
2. Timer file (`.timer`)

```bash
# 1. Crea service
sudo nano /etc/systemd/system/backup.service

[Unit]
Description=Backup script

[Service]
Type=oneshot
ExecStart=/home/user/backup.sh

# 2. Crea timer
sudo nano /etc/systemd/system/backup.timer

[Unit]
Description=Run backup daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target

# 3. Abilita e avvia timer
sudo systemctl daemon-reload
sudo systemctl enable backup.timer
sudo systemctl start backup.timer

# 4. Verifica
systemctl list-timers
systemctl status backup.timer
```

### Sintassi OnCalendar

```bash
# Giornaliero a mezzanotte
OnCalendar=daily

# Ogni lunedì alle 10:00
OnCalendar=Mon 10:00

# Ogni ora
OnCalendar=hourly

# Specifico
OnCalendar=2025-01-01 00:00:00

# Ogni 15 minuti
OnCalendar=*:0/15

# Test sintassi
systemd-analyze calendar "Mon 10:00"
```

### Vantaggi timer vs cron

- Log integrati con journalctl
- Esecuzione mancata recuperabile (Persistent=true)
- Dipendenze tra servizi
- Più preciso (sub-secondo)

---

## Docker Basics

Docker permette di eseguire applicazioni in container isolati.

### Installazione Docker

```bash
# Debian/Ubuntu
sudo apt update
sudo apt install docker.io -y

# RHEL/CentOS (Docker CE)
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io -y

# Avvia Docker
sudo systemctl start docker
sudo systemctl enable docker

# Verifica
sudo docker --version
sudo docker run hello-world

# Aggiungi utente a gruppo docker (no sudo)
sudo usermod -aG docker $USER
newgrp docker  # o logout/login
```

### Comandi base Docker

```bash
# Info sistema
docker info
docker version

# Immagini
docker images              # Lista immagini
docker pull nginx          # Scarica immagine
docker rmi nginx           # Rimuovi immagine

# Container
docker ps                  # Container attivi
docker ps -a               # Tutti i container
docker run nginx           # Esegui container
docker stop container_id   # Ferma container
docker start container_id  # Avvia container
docker restart container_id # Riavvia container
docker rm container_id     # Rimuovi container

# Cleanup
docker system prune        # Rimuovi oggetti inutilizzati
docker system prune -a     # Rimuovi tutto non usato
```

### Eseguire container

```bash
# Run semplice
docker run nginx

# Run in background (-d detached)
docker run -d nginx

# Con nome
docker run -d --name webserver nginx

# Con port mapping
docker run -d -p 8080:80 nginx
# Locale:8080 → Container:80

# Con variabile ambiente
docker run -d -e MYSQL_ROOT_PASSWORD=secret mysql

# Con volume
docker run -d -v /host/path:/container/path nginx

# Interattivo con shell
docker run -it ubuntu /bin/bash

# One-shot (auto-remove dopo stop)
docker run --rm alpine echo "Hello"
```

### Gestire container

```bash
# Log container
docker logs container_id
docker logs -f container_id  # follow

# Esegui comando in container running
docker exec container_id ls /
docker exec -it container_id /bin/bash

# Ispeziona container
docker inspect container_id

# Stats risorse
docker stats
docker stats container_id

# Top processi
docker top container_id
```

### Dockerfile

Crea immagini personalizzate:

```bash
# Crea Dockerfile
nano Dockerfile
```

```dockerfile
FROM ubuntu:22.04

# Maintainer
LABEL maintainer="user@example.com"

# Aggiorna e installa
RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Copia file
COPY index.html /var/www/html/

# Porta
EXPOSE 80

# Comando default
CMD ["nginx", "-g", "daemon off;"]
```

```bash
# Build immagine
docker build -t myimage:1.0 .

# Run
docker run -d -p 80:80 myimage:1.0
```

### Docker Compose

Gestisce applicazioni multi-container:

```bash
# Installa docker-compose
sudo apt install docker-compose -y

# Crea docker-compose.yml
nano docker-compose.yml
```

```yaml
version: '3'

services:
  web:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
  
  db:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: secret
    volumes:
      - db-data:/var/lib/mysql

volumes:
  db-data:
```

```bash
# Avvia stack
docker-compose up -d

# Stop stack
docker-compose down

# View logs
docker-compose logs -f

# Lista servizi
docker-compose ps
```

---

## Esercizi pratici

### Esercizio 1: Script backup

```bash
#!/bin/bash
# backup-simple.sh

SOURCE="$HOME/documents"
DEST="$HOME/backups"
DATE=$(date +%Y%m%d-%H%M%S)

mkdir -p "$DEST"

echo "Starting backup..."
tar -czf "$DEST/backup-$DATE.tar.gz" "$SOURCE"

if [ $? -eq 0 ]; then
    echo "Backup successful: $DEST/backup-$DATE.tar.gz"
    
    # Rimuovi backup vecchi (>7 giorni)
    find "$DEST" -name "backup-*.tar.gz" -mtime +7 -delete
    echo "Old backups removed"
else
    echo "Backup failed"
    exit 1
fi
```

### Esercizio 2: Script sistema info

```bash
#!/bin/bash
# sysinfo.sh

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "Users logged in: $(who | wc -l)"
echo

echo "=== CPU ==="
lscpu | grep "Model name"
echo "CPU usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%"
echo

echo "=== Memory ==="
free -h
echo

echo "=== Disk ==="
df -h / /home
echo

echo "=== Network ==="
ip -4 addr show | grep inet
echo

echo "=== Top 5 processes by memory ==="
ps aux --sort=-%mem | head -6
```

### Esercizio 3: Cron setup

```bash
# 1. Crea script
nano ~/daily-backup.sh

#!/bin/bash
tar -czf ~/backup-$(date +%Y%m%d).tar.gz ~/documents
find ~/backup-*.tar.gz -mtime +7 -delete

# 2. Rendi eseguibile
chmod +x ~/daily-backup.sh

# 3. Aggiungi a crontab
crontab -e

# Aggiungi riga:
0 2 * * * /home/user/daily-backup.sh >> /home/user/backup.log 2>&1

# 4. Verifica
crontab -l
```

### Esercizio 4: Docker web server

```bash
# 1. Pull immagine
docker pull nginx

# 2. Crea pagina custom
mkdir -p ~/docker-web
echo "<h1>Hello from Docker!</h1>" > ~/docker-web/index.html

# 3. Run con volume mount
docker run -d \
  --name my-nginx \
  -p 8080:80 \
  -v ~/docker-web:/usr/share/nginx/html:ro \
  nginx

# 4. Test
curl localhost:8080

# 5. Verifica log
docker logs my-nginx

# 6. Stop e rimuovi
docker stop my-nginx
docker rm my-nginx
```

### Esercizio 5: systemd timer

```bash
# 1. Crea script
sudo nano /usr/local/bin/cleanup.sh

#!/bin/bash
find /tmp -type f -mtime +7 -delete
echo "Cleanup completed at $(date)" >> /var/log/cleanup.log

sudo chmod +x /usr/local/bin/cleanup.sh

# 2. Crea service
sudo nano /etc/systemd/system/cleanup.service

[Unit]
Description=Cleanup old temp files

[Service]
Type=oneshot
ExecStart=/usr/local/bin/cleanup.sh

# 3. Crea timer
sudo nano /etc/systemd/system/cleanup.timer

[Unit]
Description=Run cleanup weekly

[Timer]
OnCalendar=weekly
Persistent=true

[Install]
WantedBy=timers.target

# 4. Abilita
sudo systemctl daemon-reload
sudo systemctl enable cleanup.timer
sudo systemctl start cleanup.timer

# 5. Verifica
systemctl list-timers
systemctl status cleanup.timer
```

---

## Comandi da memorizzare

```bash
# === Bash ===
chmod +x script.sh           # Rendi eseguibile
./script.sh arg1 arg2        # Esegui con argomenti
bash -x script.sh            # Debug mode

# === Cron ===
crontab -e                   # Edita crontab
crontab -l                   # Lista crontab
0 2 * * * /path/script.sh    # Daily alle 2 AM
*/15 * * * * /path/script.sh # Ogni 15 minuti
@daily /path/script.sh       # Giornaliero

# === Docker ===
docker pull image            # Scarica immagine
docker run -d -p 80:80 nginx # Run container
docker ps                    # Lista container attivi
docker logs container_id     # Log container
docker exec -it container_id bash  # Shell in container
docker stop container_id     # Ferma container
docker rm container_id       # Rimuovi container
```

---

## Checklist settimana 9

- [ ] So creare script bash base
- [ ] So usare variabili e argomenti
- [ ] So usare if/for/while
- [ ] So creare funzioni bash
- [ ] So gestire exit codes
- [ ] Conosco sintassi crontab
- [ ] So creare cron job
- [ ] So verificare log cron
- [ ] Ho installato Docker
- [ ] So eseguire container Docker
- [ ] So usare port mapping
- [ ] So visualizzare log container
- [ ] Ho fatto tutti gli esercizi pratici

---

## Risorse aggiuntive

- Bash Guide: https://www.gnu.org/software/bash/manual/
- Cron syntax: https://crontab.guru/
- Docker documentation: https://docs.docker.com/
- Bash scripting tutorial: https://www.shellscript.sh/

**Prossima settimana**: Ripasso generale e preparazione esame LFCA
