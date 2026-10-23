# Settimana 10 — Ripasso e Preparazione Esame LFCA

**Tempo stimato**: 8-10 ore  
**Obiettivo**: Consolidare conoscenze, fare pratica intensiva, prepararsi all'esame LFCA

---

## Introduzione

Questa è la settimana finale di preparazione. Focus su ripasso sistematico, esercizi pratici e simulazioni d'esame. L'esame LFCA verifica competenze pratiche su Linux.

### Info esame LFCA

- **Durata**: 90 minuti
- **Formato**: Performance-based (comandi reali, no quiz)
- **Ambiente**: Browser-based terminal su sistema Linux remoto
- **Punteggio minimo**: 66% per passare
- **Tentativi**: 1 tentativo incluso, possibile acquistare retry
- **Validità**: Certificazione lifetime (no scadenza)

---

## Aree chiave da ripassare

### 1. Navigazione filesystem e file operations

**Comandi essenziali:**
```bash
ls -la                   # Lista dettagliata con nascosti
cd /path                 # Cambia directory
pwd                      # Percorso corrente
cp file dest             # Copia
mv file dest             # Muovi/rinomina
rm file                  # Rimuovi
mkdir -p dir/subdir      # Crea directory ricorsivo
touch file               # Crea file vuoto
cat file                 # Visualizza contenuto
less file                # Visualizza paginato
head -n 10 file          # Prime 10 righe
tail -n 20 file          # Ultime 20 righe
tail -f file             # Segui file in real-time
find /path -name "*.txt" # Trova file
locate filename          # Trova veloce (usa database)
which command            # Trova path comando
```

**Domande frequenti:**
- Come trovi tutti i file .conf in /etc?
- Come copi directory ricorsivamente?
- Come visualizzi file grandi?
- Come segui un log in tempo reale?

**Esercizi:**
```bash
# Trova tutti i .log modificati oggi
find /var/log -name "*.log" -mtime 0 2>/dev/null

# Copia directory preservando permessi
cp -rp /source /destination

# Conta linee, parole, caratteri
wc -l /etc/passwd
wc -w /etc/passwd
wc -c /etc/passwd
```

### 2. Permessi e ownership

**Comandi essenziali:**
```bash
ls -l file               # Vedi permessi
chmod 755 file           # Cambia permessi (numerico)
chmod u+x file           # Aggiungi esecuzione utente (simbolico)
chmod g-w file           # Rimuovi scrittura gruppo
chown user:group file    # Cambia proprietario
chown -R user:group dir  # Ricorsivo
umask                    # Default permissions
```

**Permessi numerici:**
```
4 = read (r)
2 = write (w)
1 = execute (x)

755 = rwxr-xr-x
644 = rw-r--r--
600 = rw-------
777 = rwxrwxrwx (sconsigliato!)
```

**Domande frequenti:**
- Come rendi un file eseguibile?
- Come dai permessi 644 a un file?
- Come cambi owner ricorsivamente?

**Esercizi:**
```bash
# Rendi script eseguibile
chmod +x script.sh
# o
chmod 755 script.sh

# File leggibile/scrivibile solo da owner
chmod 600 private.txt

# Directory accessibile a tutti
chmod 755 /public/dir
```

### 3. Redirezione e pipe

**Operatori:**
```bash
>    # Redirect output (sovrascrive)
>>   # Append output
<    # Redirect input
2>   # Redirect stderr
2>&1 # Redirect stderr a stdout
|    # Pipe (output cmd1 → input cmd2)
```

**Esempi:**
```bash
# Salva output
ls -la > list.txt

# Append
echo "new line" >> file.txt

# Redirect errori
find / -name "*.conf" 2> /dev/null

# Redirect tutto
command > output.txt 2>&1

# Pipe
ps aux | grep nginx
cat file.txt | sort | uniq
```

**Domande frequenti:**
- Come ignori errori di un comando?
- Come salvi output e errori separatamente?
- Come conti linee uniche in un file?

**Esercizi:**
```bash
# Conta processi utente
ps aux | grep ^$USER | wc -l

# Top 10 file per dimensione
du -ah /var | sort -rh | head -10

# Trova IP unici in log
grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort -u
```

### 4. Ricerca con grep e find

**grep:**
```bash
grep pattern file        # Cerca pattern
grep -i pattern file     # Case insensitive
grep -r pattern /path    # Ricorsivo
grep -v pattern file     # Inverti (non match)
grep -n pattern file     # Con numero riga
grep -c pattern file     # Conta match
grep -A 3 pattern file   # 3 righe dopo
grep -B 3 pattern file   # 3 righe prima
grep -C 3 pattern file   # 3 righe prima e dopo
```

**find:**
```bash
find /path -name "file"  # Per nome
find /path -type f       # Solo file
find /path -type d       # Solo directory
find /path -size +100M   # File >100MB
find /path -mtime -7     # Modificati ultimi 7 giorni
find /path -user alice   # Proprietario alice
find /path -perm 644     # Permessi specifici
find /path -exec cmd {} \; # Esegui comando su risultati
```

**Esercizi:**
```bash
# File .conf contenenti "localhost"
find /etc -name "*.conf" -exec grep -l "localhost" {} \;

# File grandi non acceduti da 1 anno
find /home -type f -size +1G -atime +365

# Errori SSH in log
grep -i "failed" /var/log/auth.log | grep ssh
```

### 5. Gestione utenti e gruppi

**Comandi essenziali:**
```bash
useradd alice            # Crea utente
useradd -m -s /bin/bash alice  # Con home e shell
usermod -aG group alice  # Aggiungi a gruppo
userdel alice            # Elimina utente
userdel -r alice         # Elimina con home
passwd alice             # Cambia password
id alice                 # Info utente
groups alice             # Gruppi utente
who                      # Utenti loggati
w                        # Utenti e cosa fanno
last                     # Ultimi login
```

**Gruppi:**
```bash
groupadd developers      # Crea gruppo
groupmod -n newname old  # Rinomina gruppo
groupdel developers      # Elimina gruppo
gpasswd -a alice group   # Aggiungi utente a gruppo
gpasswd -d alice group   # Rimuovi utente da gruppo
```

**File importanti:**
```bash
/etc/passwd              # Database utenti
/etc/shadow              # Password cifrate
/etc/group               # Database gruppi
/etc/gshadow             # Password gruppi
```

**Esercizi:**
```bash
# Crea utente con home
sudo useradd -m -s /bin/bash testuser
sudo passwd testuser

# Aggiungi a gruppo sudo
sudo usermod -aG sudo testuser

# Verifica
id testuser
groups testuser

# Elimina utente
sudo userdel -r testuser
```

### 6. sudo

**Configurazione:**
```bash
# Edita sudoers (SEMPRE con visudo)
sudo visudo

# Esempi configurazione:
# Utente può eseguire tutto
alice ALL=(ALL:ALL) ALL

# Gruppo sudo può tutto
%sudo ALL=(ALL:ALL) ALL

# Utente può restart nginx senza password
alice ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx

# Gruppo può gestire apache
%webadmin ALL=(ALL) /usr/bin/systemctl * apache2
```

**Comandi:**
```bash
sudo command             # Esegui come root
sudo -u alice command    # Esegui come alice
sudo -i                  # Login shell root
sudo -s                  # Shell root
sudo -l                  # Lista permessi sudo utente
sudo -k                  # Cancella cache credenziali
```

**Esercizi:**
```bash
# Dai permessi restart nginx
sudo visudo
# Aggiungi: alice ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx

# Test
sudo -u alice sudo systemctl restart nginx
```

### 7. Processi e servizi

**Processi:**
```bash
ps aux                   # Tutti i processi
ps aux | grep nginx      # Cerca processo
top                      # Monitor interattivo
htop                     # Monitor migliore (se installato)
pgrep nginx              # PID processo
pkill nginx              # Termina per nome
kill PID                 # Termina processo
kill -9 PID              # Force kill
killall nginx            # Termina tutti nginx
nice -n 10 command       # Avvia con priorità
renice -n 5 -p PID       # Cambia priorità
```

**Segnali:**
```bash
kill -l                  # Lista segnali
kill -15 PID             # SIGTERM (graceful)
kill -9 PID              # SIGKILL (force)
kill -1 PID              # SIGHUP (reload config)
```

**systemd:**
```bash
systemctl start service  # Avvia
systemctl stop service   # Ferma
systemctl restart service # Riavvia
systemctl reload service  # Ricarica config
systemctl status service  # Stato
systemctl enable service  # Abilita all'avvio
systemctl disable service # Disabilita
systemctl is-active service  # Verifica se attivo
systemctl is-enabled service # Verifica se abilitato
systemctl list-units     # Lista unità
systemctl daemon-reload  # Ricarica systemd
```

**Esercizi:**
```bash
# Trova processi che usano più CPU
ps aux --sort=-%cpu | head -10

# Termina tutti i processi di un utente
sudo pkill -u alice

# Verifica se nginx è attivo
systemctl is-active nginx

# Riavvia e abilita servizio
sudo systemctl restart nginx
sudo systemctl enable nginx
```

### 8. Log e journalctl

**journalctl:**
```bash
journalctl               # Tutti i log
journalctl -f            # Segui in real-time
journalctl -u nginx      # Log servizio specifico
journalctl -p err        # Solo errori
journalctl --since "1 hour ago"  # Ultima ora
journalctl --since "2025-01-01"  # Da data
journalctl --until "2025-01-31"  # Fino a data
journalctl -b            # Boot corrente
journalctl -b -1         # Boot precedente
journalctl -k            # Kernel messages
journalctl --disk-usage  # Spazio occupato
journalctl --vacuum-time=7d  # Cancella log >7 giorni
```

**Log tradizionali:**
```bash
/var/log/syslog          # Log sistema generale
/var/log/auth.log        # Autenticazione
/var/log/kern.log        # Kernel
/var/log/dmesg           # Boot messages
/var/log/nginx/          # Nginx logs
/var/log/apache2/        # Apache logs

# Visualizza
tail -f /var/log/syslog
grep "error" /var/log/syslog
```

**Esercizi:**
```bash
# Log SSH ultima ora
journalctl -u ssh --since "1 hour ago"

# Errori critici oggi
journalctl -p crit --since today

# Segui log nginx
journalctl -u nginx -f
```

### 9. Networking

**Comandi base:**
```bash
ip addr                  # Indirizzi IP
ip link                  # Interfacce rete
ip route                 # Routing table
ping host                # Test connettività
ping -c 4 host           # 4 pacchetti
traceroute host          # Traccia percorso
ss -tuln                 # Socket in ascolto
ss -tulnp                # Con PID/programma
netstat -tuln            # Vecchia alternativa a ss
curl url                 # HTTP client
wget url                 # Scarica file
dig domain               # DNS lookup
nslookup domain          # DNS lookup (vecchio)
host domain              # DNS lookup semplice
```

**File configurazione:**
```bash
/etc/hosts               # Host statici
/etc/resolv.conf         # DNS servers
/etc/network/interfaces  # Config rete (Debian old)
/etc/netplan/            # Config rete (Ubuntu new)
```

**Esercizi:**
```bash
# Test connettività
ping -c 4 google.com

# Verifica porte aperte
ss -tuln | grep LISTEN

# DNS lookup
dig google.com A
dig google.com MX

# Quale processo usa porta 80?
sudo ss -tulnp | grep :80
```

### 10. Gestione pacchetti

**apt (Debian/Ubuntu):**
```bash
sudo apt update          # Aggiorna lista
sudo apt upgrade         # Aggiorna pacchetti
sudo apt install pkg     # Installa
sudo apt remove pkg      # Rimuovi
sudo apt purge pkg       # Rimuovi con config
sudo apt autoremove      # Rimuovi orfani
apt search pkg           # Cerca
apt show pkg             # Info
dpkg -L pkg              # File da pacchetto
dpkg -S /path/file       # Pacchetto da file
```

**dnf (RHEL/Fedora):**
```bash
sudo dnf update          # Aggiorna
sudo dnf install pkg     # Installa
sudo dnf remove pkg      # Rimuovi
dnf search pkg           # Cerca
dnf info pkg             # Info
rpm -ql pkg              # File da pacchetto
rpm -qf /path/file       # Pacchetto da file
```

**Esercizi:**
```bash
# Cerca pacchetto nginx
apt search nginx

# Installa nginx
sudo apt install nginx -y

# Verifica file installati
dpkg -L nginx | head -20

# Aggiorna sistema
sudo apt update && sudo apt upgrade -y
```

### 11. Storage e filesystem

**Comandi:**
```bash
df -h                    # Spazio disco
df -i                    # Inodes
du -sh /path             # Dimensione directory
du -h --max-depth=1 /    # Sottodirectory root
lsblk                    # Block devices
mount                    # Mount points
sudo mount /dev/sdb1 /mnt # Monta
sudo umount /mnt         # Smonta
findmnt                  # Tree mount points
sudo blkid               # UUID dispositivi
```

**fstab:**
```bash
/etc/fstab               # Config mount automatico

# Formato:
# <device> <mount> <type> <options> <dump> <pass>
UUID=xxx /data ext4 defaults 0 2

# Test fstab
sudo mount -a
```

**Esercizi:**
```bash
# Trova directory grandi
sudo du -h / --max-depth=1 | sort -h

# UUID dispositivo
sudo blkid /dev/sda1

# Verifica uso inodes
df -i
```

### 12. Backup (tar, rsync)

**tar:**
```bash
tar -czf backup.tar.gz /path   # Crea
tar -xzf backup.tar.gz         # Estrai
tar -tzf backup.tar.gz         # Lista
tar -xzf backup.tar.gz -C /tmp # Estrai in /tmp
```

**rsync:**
```bash
rsync -av /src/ /dest/         # Sincronizza
rsync -av --delete /src/ /dest/ # Con cancellazione
rsync -avz user@host:/src/ /local/  # Da remoto
rsync -av --dry-run /src/ /dest/    # Test
```

**Esercizi:**
```bash
# Backup home directory
tar -czf ~/backup-$(date +%Y%m%d).tar.gz ~/documents

# Sincronizza directory
rsync -av --delete ~/source/ ~/destination/
```

### 13. Sicurezza (SSH, firewall)

**SSH:**
```bash
ssh-keygen -t ed25519    # Genera chiave
ssh-copy-id user@host    # Copia chiave
ssh user@host            # Connetti
/etc/ssh/sshd_config     # Config server

# Hardening:
PermitRootLogin no
PasswordAuthentication no
```

**UFW:**
```bash
sudo ufw status          # Status
sudo ufw enable          # Abilita
sudo ufw allow 22/tcp    # Consenti SSH
sudo ufw allow 80/tcp    # Consenti HTTP
sudo ufw deny 23/tcp     # Nega telnet
sudo ufw delete allow 80 # Elimina regola
sudo ufw reset           # Reset
```

**Esercizi:**
```bash
# Setup SSH key
ssh-keygen -t ed25519
# (se hai server) ssh-copy-id user@server

# Configura firewall
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status
```

### 14. Scripting e automazione

**Bash:**
```bash
#!/bin/bash
# Script base

VAR="value"
echo $VAR

if [ condition ]; then
    command
fi

for i in {1..5}; do
    echo $i
done
```

**Cron:**
```bash
crontab -e               # Edita crontab

# Formato:
# MIN HOUR DOM MON DOW COMMAND
0 2 * * * /path/script.sh

@daily /path/script.sh
@reboot /path/script.sh
```

**Esercizi:**
```bash
# Script backup
cat > backup.sh << 'EOF'
#!/bin/bash
tar -czf /backup/backup-$(date +%Y%m%d).tar.gz /data
find /backup -name "backup-*.tar.gz" -mtime +7 -delete
EOF
chmod +x backup.sh

# Schedule con cron
crontab -e
# 0 2 * * * /home/user/backup.sh
```

---

## Mock Test - 20 Domande LFCA Style

### Domanda 1
**Task:** Trova tutti i file .log in /var/log modificati nelle ultime 24 ore.

**Risposta:**
```bash
find /var/log -name "*.log" -mtime 0 2>/dev/null
```

### Domanda 2
**Task:** Crea un utente "alice" con home directory e shell bash, poi imposta la password.

**Risposta:**
```bash
sudo useradd -m -s /bin/bash alice
sudo passwd alice
```

### Domanda 3
**Task:** Dai permessi 644 al file report.txt (owner: rw, group: r, others: r).

**Risposta:**
```bash
chmod 644 report.txt
# o
chmod u=rw,g=r,o=r report.txt
```

### Domanda 4
**Task:** Avvia il servizio nginx e abilitalo all'avvio automatico.

**Risposta:**
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

### Domanda 5
**Task:** Visualizza i log del servizio SSH dell'ultima ora.

**Risposta:**
```bash
journalctl -u ssh --since "1 hour ago"
# o
journalctl -u sshd --since "1 hour ago"
```

### Domanda 6
**Task:** Verifica la connettività a google.com inviando 4 pacchetti ICMP.

**Risposta:**
```bash
ping -c 4 google.com
```

### Domanda 7
**Task:** Installa il pacchetto "htop" usando il package manager.

**Risposta:**
```bash
sudo apt install htop -y       # Debian/Ubuntu
# o
sudo dnf install htop -y       # RHEL/Fedora
```

### Domanda 8
**Task:** Crea un backup tar compresso gzip di /etc chiamato etc-backup.tar.gz.

**Risposta:**
```bash
sudo tar -czf etc-backup.tar.gz /etc
```

### Domanda 9
**Task:** Trova quale pacchetto ha installato il file /usr/bin/vim.

**Risposta:**
```bash
dpkg -S /usr/bin/vim           # Debian/Ubuntu
# o
rpm -qf /usr/bin/vim           # RHEL/Fedora
```

### Domanda 10
**Task:** Mostra i 10 processi che usano più memoria.

**Risposta:**
```bash
ps aux --sort=-%mem | head -10
```

### Domanda 11
**Task:** Copia ricorsivamente /home/user/docs in /backup preservando permessi e timestamp.

**Risposta:**
```bash
cp -rp /home/user/docs /backup
# o
rsync -av /home/user/docs/ /backup/docs/
```

### Domanda 12
**Task:** Aggiungi l'utente "bob" al gruppo "developers".

**Risposta:**
```bash
sudo usermod -aG developers bob
# o
sudo gpasswd -a bob developers
```

### Domanda 13
**Task:** Configura il firewall per consentire traffico HTTP (porta 80) e HTTPS (porta 443).

**Risposta:**
```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

### Domanda 14
**Task:** Cerca tutti i file contenenti la stringa "ERROR" in /var/log/syslog.

**Risposta:**
```bash
grep "ERROR" /var/log/syslog
# o case-insensitive
grep -i "error" /var/log/syslog
```

### Domanda 15
**Task:** Mostra lo spazio disco disponibile in formato human-readable.

**Risposta:**
```bash
df -h
```

### Domanda 16
**Task:** Termina il processo con PID 1234 usando il segnale SIGTERM.

**Risposta:**
```bash
kill 1234
# o esplicito
kill -15 1234
```

### Domanda 17
**Task:** Genera una chiave SSH ED25519 con commento "user@example.com".

**Risposta:**
```bash
ssh-keygen -t ed25519 -C "user@example.com"
```

### Domanda 18
**Task:** Schedula lo script /home/user/backup.sh per esecuzione giornaliera alle 3:00 AM.

**Risposta:**
```bash
crontab -e
# Aggiungi:
0 3 * * * /home/user/backup.sh
```

### Domanda 19
**Task:** Trova il numero di porta su cui il servizio nginx è in ascolto.

**Risposta:**
```bash
ss -tuln | grep nginx
# o
sudo netstat -tuln | grep nginx
```

### Domanda 20
**Task:** Sincronizza /data/source con /data/dest cancellando file in dest non presenti in source.

**Risposta:**
```bash
rsync -av --delete /data/source/ /data/dest/
```

---

## Scenari pratici completi

### Scenario 1: Setup nuovo utente sviluppatore

```bash
# 1. Crea utente
sudo useradd -m -s /bin/bash developer
sudo passwd developer

# 2. Aggiungi a gruppi necessari
sudo usermod -aG sudo developer
sudo usermod -aG docker developer

# 3. Configura SSH
sudo mkdir -p /home/developer/.ssh
sudo touch /home/developer/.ssh/authorized_keys
sudo chmod 700 /home/developer/.ssh
sudo chmod 600 /home/developer/.ssh/authorized_keys
sudo chown -R developer:developer /home/developer/.ssh

# 4. Aggiungi chiave pubblica
echo "ssh-ed25519 AAAA..." | sudo tee -a /home/developer/.ssh/authorized_keys

# 5. Test sudo
sudo -u developer sudo whoami  # Dovrebbe chiedere password e mostrare "root"
```

### Scenario 2: Debug servizio web non raggiungibile

```bash
# 1. Verifica se servizio è attivo
systemctl status nginx

# 2. Se non attivo, avvia
sudo systemctl start nginx

# 3. Verifica porta in ascolto
ss -tuln | grep :80

# 4. Test connessione locale
curl localhost

# 5. Verifica firewall
sudo ufw status
sudo ufw allow 80/tcp

# 6. Verifica log errori
journalctl -u nginx -n 50
tail -f /var/log/nginx/error.log

# 7. Test DNS/connettività
ping -c 4 server-ip
```

### Scenario 3: Sistema quasi pieno

```bash
# 1. Identifica filesystem pieni
df -h

# 2. Trova directory grandi
sudo du -h / --max-depth=1 | sort -h

# 3. Trova file grandi
sudo find / -type f -size +100M -exec ls -lh {} \; 2>/dev/null

# 4. Pulisci:
# - Log vecchi
sudo find /var/log -name "*.log" -mtime +30 -delete

# - Cache pacchetti
sudo apt clean
sudo apt autoremove

# - Temp files
sudo rm -rf /tmp/*

# - Docker (se presente)
docker system prune -a

# 5. Verifica spazio recuperato
df -h
```

### Scenario 4: Configurazione backup automatico

```bash
# 1. Crea script backup
cat > /usr/local/bin/backup.sh << 'EOF'
#!/bin/bash
DEST="/backup"
DATE=$(date +%Y%m%d)
mkdir -p $DEST

# Backup
tar -czf $DEST/backup-$DATE.tar.gz /home /etc

# Pulisci vecchi (>7 giorni)
find $DEST -name "backup-*.tar.gz" -mtime +7 -delete

# Log
echo "Backup completed: $(date)" >> /var/log/backup.log
EOF

# 2. Rendi eseguibile
sudo chmod +x /usr/local/bin/backup.sh

# 3. Schedule con cron (daily 2 AM)
sudo crontab -e
# Aggiungi:
0 2 * * * /usr/local/bin/backup.sh

# 4. Test
sudo /usr/local/bin/backup.sh
ls -lh /backup/
```

### Scenario 5: Hardening SSH server

```bash
# 1. Backup configurazione
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# 2. Edita configurazione
sudo nano /etc/ssh/sshd_config

# Modifiche:
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222
MaxAuthTries 3
AllowUsers alice bob

# 3. Test configurazione
sudo sshd -t

# 4. Configura firewall per nuova porta
sudo ufw allow 2222/tcp
sudo ufw delete allow 22/tcp

# 5. ⚠️ Apri seconda sessione SSH prima di riavviare
# In altro terminale:
ssh -p 2222 user@server

# 6. Riavvia sshd (solo se test OK!)
sudo systemctl restart sshd

# 7. Installa fail2ban
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

---

## Checklist finale preparazione esame

### Competenze tecniche
- [ ] Navigazione filesystem fluida
- [ ] Gestione permessi (numerici e simbolici)
- [ ] Redirezione e pipe senza esitazione
- [ ] grep e find per ricerche complesse
- [ ] Gestione utenti e gruppi
- [ ] Configurazione sudo sicura
- [ ] Gestione processi e servizi systemd
- [ ] Query log con journalctl
- [ ] Configurazione rete base
- [ ] Test connettività e diagnostica
- [ ] Installazione/rimozione pacchetti
- [ ] Gestione spazio disco
- [ ] Backup con tar e rsync
- [ ] Configurazione SSH e chiavi
- [ ] Firewall con ufw
- [ ] Scripting bash base
- [ ] Scheduling con cron

### Preparazione pratica
- [ ] Ho fatto tutti gli esercizi settimane 1-9
- [ ] Ho completato tutti i mock test
- [ ] Ho risolto i 5 scenari completi
- [ ] Ho praticato su VM Linux reale
- [ ] Posso eseguire comandi senza consultare note
- [ ] Ho creato cheat-sheet personale
- [ ] Ho simulato condizioni esame (90 min, no internet)

### Preparazione logistica
- [ ] Account Linux Foundation creato
- [ ] Esame schedulato
- [ ] Webcam funzionante testata
- [ ] Microfono testato
- [ ] ID documento valido pronto
- [ ] Ambiente pulito (scrivania vuota)
- [ ] Browser aggiornato
- [ ] Connessione internet stabile verificata
- [ ] Nessuna interruzione programmata per 2 ore

---

## Consigli per l'esame

### Durante l'esame

1. **Leggi attentamente**: Ogni task ha requisiti specifici
2. **Verifica sempre**: Dopo ogni comando, verifica risultato
3. **Usa TAB completion**: Risparmia tempo ed evita errori
4. **man pages disponibili**: Usa `man command` se necessario
5. **No panic**: Se un task è difficile, salta e torna dopo
6. **Time management**: 90 minuti = ~4-5 minuti per task
7. **Doppio check**: Verifica path, nomi utente, permessi

### Comandi da verificare sempre

```bash
# Dopo creazione utente
id username

# Dopo chmod
ls -l file

# Dopo systemctl
systemctl status service

# Dopo firewall
sudo ufw status

# Dopo crontab
crontab -l
```

### Errori comuni da evitare

1. **Typos**: usa TAB completion
2. **Permessi**: verifica con ls -l
3. **Path assoluti vs relativi**: sempre assoluti quando in dubbio
4. **sudo dimenticato**: molti comandi richiedono sudo
5. **Trailing slash in rsync**: /source/ vs /source (differenza importante!)
6. **Variabili bash**: $VAR non VAR
7. **Crontab syntax**: verifica con crontab -l dopo modifica

---

## Risorse finali

### Documentazione
- Man pages integrate: `man command`
- LFCA Exam Domains: https://training.linuxfoundation.org/certification/linux-foundation-certified-it-associate/
- Linux Journey: https://linuxjourney.com/

### Pratica
- Crea VM Linux (VirtualBox/VMware) per pratica
- Usa servizi cloud gratuiti (AWS Free Tier, Google Cloud)
- KodeKloud LFCA labs: https://kodekloud.com/
- Prova Linux su container Docker

### Cheat sheet personale
Crea il tuo con comandi più difficili da ricordare, ad esempio:

```bash
# File operations
find / -name "*.conf" 2>/dev/null
find / -size +100M -mtime +7
tar -czf backup.tar.gz /path
rsync -av --delete /src/ /dest/

# Users/permissions
useradd -m -s /bin/bash user
chmod 755 file
chown user:group file

# Services
systemctl start|stop|restart|enable|disable service
journalctl -u service --since "1 hour ago"

# Network
ss -tuln
ping -c 4 host
dig domain

# Packages
apt update && apt upgrade
apt install|remove pkg

# Firewall
ufw allow|deny 80/tcp
ufw status
```

---

## Il giorno dell'esame

### Checklist finale
1. [ ] Notte di sonno adeguato
2. [ ] Colazione/pranzo leggero
3. [ ] Bagno visitato
4. [ ] Acqua a disposizione
5. [ ] Ambiente silenzioso
6. [ ] Scrivania vuota
7. [ ] Telefono silenziato/spento
8. [ ] Altri dispositivi lontani
9. [ ] ID documento pronto
10. [ ] Browser testato
11. [ ] Login anticipato 15 minuti
12. [ ] Mentalità positiva!

### Buona fortuna! 🎓🐧

Ricorda: L'esame LFCA verifica competenze pratiche che userai ogni giorno come professionista Linux. Non è solo un certificato, ma un investimento nel tuo futuro.

**You got this!** 💪
