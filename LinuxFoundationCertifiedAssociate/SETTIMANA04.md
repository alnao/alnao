# Settimana 4 — Processi, Servizi e Logging (LFCA)
Tempo stimato: 2-3 ore

## Introduzione
Capire come funzionano i processi, come gestire i servizi con systemd e come leggere i log è fondamentale per l'amministrazione di sistemi Linux.

## Gestione dei processi

### Comandi base per processi
 
#### ps — visualizza processi

```bash
# Processi utente corrente
ps

# Tutti i processi (BSD style)
ps aux

# Tutti i processi (Unix style)
ps -ef

# Processi in formato albero
ps auxf
pstree

# Filtra processi specifici
ps aux | grep nginx
pgrep nginx

# Formato personalizzato
ps -eo pid,ppid,cmd,%mem,%cpu | grep apache

```

#### top/htop — monitor interattivo

```bash
# Monitor processi in tempo reale
top

# Comandi in top:
# P - ordina per CPU
# M - ordina per memoria
# k - kill processo
# r - renice processo
# q - esci

# htop (più user-friendly)
sudo apt install htop
htop
```

#### Gestione priorità

```bash
# Avvia con priorità bassa (nice value 10)
nice -n 10 comando

# Cambia priorità processo esistente
renice 5 -p PID

# Nice values: -20 (max priority) a 19 (min priority)
# Solo root può usare valori negativi
```

#### Segnali e kill

```bash
# Termina processo (SIGTERM)
kill PID

# Forza terminazione (SIGKILL)
kill -9 PID

# Altri segnali comuni
kill -HUP PID    # rilegge configurazione
kill -STOP PID   # pausa processo
kill -CONT PID   # riprendi processo

# Kill per nome
killall processo
pkill pattern

# Lista segnali disponibili
kill -l
```

#### Background e foreground

```bash
# Avvia in background
comando &

# Manda processo in background
# (Ctrl+Z per sospendere, poi:)
bg

# Porta in foreground
fg

# Lista jobs
jobs

# Riprendi job specifico
fg %1
bg %2
```

### Informazioni processi

```bash
# Info dettagliate processo
cat /proc/PID/status
cat /proc/PID/cmdline

# File aperti da processo
lsof -p PID
ls -l /proc/PID/fd/

# Tree dei processi
pstree -p PID
```

## systemd e gestione servizi

### systemctl — controllo servizi

```bash
# Stato servizio
systemctl status nginx
systemctl status ssh

# Avvia servizio
sudo systemctl start nginx

# Ferma servizio
sudo systemctl stop nginx

# Riavvia servizio
sudo systemctl restart nginx

# Ricarica configurazione (senza riavvio)
sudo systemctl reload nginx

# Abilita all'avvio
sudo systemctl enable nginx

# Disabilita all'avvio
sudo systemctl disable nginx

# Verifica se abilitato
systemctl is-enabled nginx

# Verifica se attivo
systemctl is-active nginx
```

### Comandi systemctl utili

```bash
# Lista tutti i servizi
systemctl list-units --type=service

# Lista servizi attivi
systemctl list-units --type=service --state=active

# Lista servizi falliti
systemctl --failed

# Lista servizi abilitati all'avvio
systemctl list-unit-files --type=service --state=enabled

# Dipendenze servizio
systemctl list-dependencies nginx

# Mostra file unit
systemctl cat nginx.service

# Ricarica configurazioni systemd
sudo systemctl daemon-reload
```

### Creare servizio systemd personalizzato

```bash
# 1. Crea script
cat > /usr/local/bin/myapp.sh << 'EOF'
#!/bin/bash
while true; do
    echo "$(date): My app is running" >> /var/log/myapp.log
    sleep 60
done
EOF

sudo chmod +x /usr/local/bin/myapp.sh

# 2. Crea file unit
sudo nano /etc/systemd/system/myapp.service

# Contenuto:
[Unit]
Description=My Custom Application
After=network.target

[Service]
Type=simple
User=nobody
ExecStart=/usr/local/bin/myapp.sh
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target

# 3. Abilita e avvia
sudo systemctl daemon-reload
sudo systemctl enable myapp
sudo systemctl start myapp
sudo systemctl status myapp

# 4. Verifica log
tail -f /var/log/myapp.log
```

### Tipi di servizi systemd

- **simple**: processo principale (default)
- **forking**: processo fa fork e parent esce
- **oneshot**: esegue e esce (utile per script)
- **notify**: processo notifica quando pronto
- **dbus**: attivato da D-Bus

## Logging con journalctl

### journalctl — query systemd journal

```bash
# Tutti i log
journalctl

# Log in tempo reale (come tail -f)
journalctl -f

# Log di un servizio
journalctl -u nginx
journalctl -u ssh

# Log dal boot corrente
journalctl -b

# Log del boot precedente
journalctl -b -1

# Log da una data
journalctl --since "2024-01-15 10:00:00"
journalctl --since "1 hour ago"
journalctl --since today
journalctl --since yesterday

# Log fino a una data
journalctl --until "2024-01-15 12:00:00"

# Combina since e until
journalctl --since "2024-01-15" --until "2024-01-16"

# Log per priorità
journalctl -p err        # solo errori
journalctl -p warning    # warning e superiori
journalctl -p info       # info e superiori

# Priorità: emerg (0), alert (1), crit (2), err (3), 
#           warning (4), notice (5), info (6), debug (7)

# Log di un PID
journalctl _PID=1234

# Log di un utente
journalctl _UID=1000

# Formato output
journalctl -o json       # JSON
journalctl -o json-pretty
journalctl -o verbose
journalctl -o short-iso  # timestamp ISO

# Ultime N righe
journalctl -n 50
journalctl -n 100 -u nginx

# Reverse order (più recenti prima)
journalctl -r

# Spazio usato dal journal
journalctl --disk-usage

# Verifica integrità
journalctl --verify
```

### Gestione journal

```bash
# Pulisci log vecchi (mantieni 2 giorni)
sudo journalctl --vacuum-time=2d

# Pulisci log (mantieni 500MB)
sudo journalctl --vacuum-size=500M

# Configurazione in /etc/systemd/journald.conf
sudo nano /etc/systemd/journald.conf

# Opzioni utili:
# SystemMaxUse=100M
# SystemKeepFree=1G
# MaxRetentionSec=1month

# Riavvia servizio
sudo systemctl restart systemd-journald
```

## File di log tradizionali in /var/log

```bash
# Log di sistema principali
/var/log/syslog          # log generale (Debian/Ubuntu)
/var/log/messages        # log generale (RHEL/CentOS)
/var/log/auth.log        # autenticazione
/var/log/kern.log        # kernel
/var/log/dmesg           # boot e kernel
/var/log/daemon.log      # demoni di sistema

# Log applicazioni
/var/log/apache2/        # Apache
/var/log/nginx/          # Nginx
/var/log/mysql/          # MySQL
/var/log/postgresql/     # PostgreSQL

# Comandi per leggere log
tail -f /var/log/syslog
tail -n 100 /var/log/auth.log
grep "error" /var/log/syslog
less /var/log/syslog
```

## Esercizi pratici

### Esercizio 1: Monitoraggio processi

```bash
# 1. Trova processi che usano più CPU
ps aux --sort=-%cpu | head -10

# 2. Trova processi che usano più memoria
ps aux --sort=-%mem | head -10

# 3. Trova PID di nginx
pgrep nginx
ps aux | grep nginx

# 4. Monitora processo specifico
watch -n 1 'ps aux | grep nginx'

# 5. Info dettagliate
top -p $(pgrep nginx | head -1)
```

### Esercizio 2: Gestione servizi

```bash
# 1. Verifica stato SSH
systemctl status ssh

# 2. Lista tutti i servizi
systemctl list-units --type=service --all

# 3. Trova servizi falliti
systemctl --failed

# 4. Disabilita servizio non necessario
sudo systemctl stop cups
sudo systemctl disable cups

# 5. Verifica servizi all'avvio
systemctl list-unit-files --type=service --state=enabled
```

### Esercizio 3: Creare servizio custom

```bash
# Crea servizio che fa backup ogni minuto
cat > ~/backup-script.sh << 'EOF'
#!/bin/bash
tar -czf /tmp/backup-$(date +%Y%m%d-%H%M%S).tar.gz /home/$USER/documents/ 2>/dev/null
find /tmp/backup-*.tar.gz -mmin +60 -delete
EOF

chmod +x ~/backup-script.sh

# Crea service file
sudo nano /etc/systemd/system/backup.service
# [vedi esempio sopra, adatta ExecStart]

sudo systemctl daemon-reload
sudo systemctl start backup
sudo systemctl status backup
```

### Esercizio 4: Analisi log

```bash
# 1. Errori SSH ultima ora
journalctl -u ssh --since "1 hour ago" -p err

# 2. Tentativi login falliti
sudo journalctl -u ssh | grep "Failed password"

# 3. Conta tentativi falliti
sudo journalctl -u ssh | grep -c "Failed password"

# 4. Log di avvio sistema
journalctl -b | less

# 5. Errori kernel
journalctl -k -p err

# 6. Crea report
{
    echo "=== System Log Report ==="
    echo "Date: $(date)"
    echo ""
    echo "Failed SSH logins:"
    sudo journalctl -u ssh --since today | grep -c "Failed password"
    echo ""
    echo "System errors:"
    journalctl -p err --since today --no-pager
} > system-report.txt
```

### Esercizio 5: Troubleshooting servizio

```bash
# Scenario: servizio non si avvia

# 1. Verifica stato
systemctl status myservice

# 2. Leggi log completo
journalctl -u myservice -n 100

# 3. Verifica configurazione
systemctl cat myservice

# 4. Verifica file eseguibile
ls -l /path/to/executable

# 5. Testa manualmente
sudo /path/to/executable

# 6. Ricarica e riavvia
sudo systemctl daemon-reload
sudo systemctl restart myservice
```

## Comandi rapidi di riferimento

```bash
# Processi
ps aux | grep pattern
top / htop
kill -9 PID
nice / renice

# Servizi
systemctl status service
systemctl start/stop/restart service
systemctl enable/disable service
systemctl list-units --type=service

# Log
journalctl -u service
journalctl -f
journalctl --since "1 hour ago"
journalctl -p err
tail -f /var/log/syslog
```

## Checklist competenze

- [ ] Usare ps, top, htop per monitorare processi
- [ ] Kill processi con diversi segnali
- [ ] Gestire priorità con nice/renice
- [ ] Controllare servizi con systemctl
- [ ] Creare servizio systemd base
- [ ] Leggere log con journalctl
- [ ] Filtrare log per data, servizio, priorità
- [ ] Analizzare log in /var/log

## Tempo suggerito
- 20 minuti: teoria
- 90 minuti: esercizi
- 20 minuti: troubleshooting scenari

## Risorse
- `man systemctl`, `man journalctl`, `man systemd.service`
- `/etc/systemd/system/` — servizi custom
- `/lib/systemd/system/` — servizi di sistema

Prossima settimana: Networking Base
