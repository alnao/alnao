# Settimana 8 — Sicurezza Base (LFCA)

**Tempo stimato**: 7-9 ore  
**Obiettivo**: Configurare SSH, gestire permessi avanzati con ACL, configurare firewall con ufw

---

## Introduzione

La sicurezza è fondamentale in qualsiasi sistema Linux. Questa settimana copre gli aspetti base ma essenziali: autenticazione sicura con SSH, controlli di accesso avanzati e protezione di rete con firewall.

### Concetti chiave

- **SSH**: protocollo sicuro per accesso remoto
- **Chiavi SSH**: autenticazione senza password
- **ACL**: Access Control Lists per permessi granulari
- **Firewall**: controllo traffico di rete in ingresso/uscita

---

## SSH - Secure Shell

SSH è il protocollo standard per accedere a sistemi Linux in remoto in modo sicuro.

### Installazione SSH

```bash
# Server SSH (per accettare connessioni)
sudo apt install openssh-server    # Debian/Ubuntu
sudo dnf install openssh-server    # RHEL/Fedora

# Client SSH (di solito già installato)
sudo apt install openssh-client

# Avvia e abilita servizio
sudo systemctl start sshd
sudo systemctl enable sshd

# Verifica status
sudo systemctl status sshd

# Verifica porta in ascolto (default 22)
ss -ltn | grep :22
```

### Connessione SSH base

```bash
# Sintassi base
ssh username@hostname

# Esempi
ssh alice@192.168.1.100
ssh bob@server.example.com

# Con porta custom
ssh -p 2222 alice@192.168.1.100

# Con verbose (debug)
ssh -v alice@192.168.1.100
ssh -vv alice@192.168.1.100  # più dettagli
```

### Comandi SSH utili

```bash
# Esegui comando remoto
ssh user@host 'ls -la'

# Copia output remoto
ssh user@host 'cat /var/log/syslog' > local-copy.log

# Apri tunnel X11 (GUI)
ssh -X user@host
firefox &  # avvia firefox sul server, mostra localmente

# Port forwarding locale
ssh -L 8080:localhost:80 user@host
# Accedi a http://localhost:8080 → viene inoltrato a porta 80 del server

# Port forwarding remoto
ssh -R 9090:localhost:3000 user@host
# Porta 9090 del server → porta 3000 locale

# Keep alive
ssh -o ServerAliveInterval=60 user@host
```

---

## Chiavi SSH - Autenticazione senza password

Le chiavi SSH sono più sicure delle password e permettono automazione.

### Tipi di chiavi

- **RSA**: tradizionale, 2048+ bit
- **ED25519**: moderno, più sicuro e veloce (consigliato)
- **ECDSA**: elliptic curve
- **DSA**: obsoleto, non usare

### Generare chiave SSH

```bash
# Genera chiave ED25519 (consigliato)
ssh-keygen -t ed25519 -C "your_email@example.com"

# Genera chiave RSA 4096 bit
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Output:
# Generating public/private ed25519 key pair.
# Enter file in which to save the key (/home/user/.ssh/id_ed25519):
# Enter passphrase (empty for no passphrase):
# Enter same passphrase again:

# File generati:
# ~/.ssh/id_ed25519     (chiave privata - MANTIENI SEGRETA!)
# ~/.ssh/id_ed25519.pub (chiave pubblica - da copiare su server)
```

**Passphrase**: aggiunge un livello di sicurezza extra alla chiave privata.

### Proteggere chiave privata

```bash
# Verifica permessi corretti
ls -la ~/.ssh/

# Chiave privata deve essere 600 (solo proprietario read/write)
chmod 600 ~/.ssh/id_ed25519

# Chiave pubblica può essere 644
chmod 644 ~/.ssh/id_ed25519.pub

# Directory .ssh deve essere 700
chmod 700 ~/.ssh
```

### Copiare chiave su server

```bash
# Metodo 1: ssh-copy-id (più semplice)
ssh-copy-id user@server

# Con chiave specifica
ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server

# Con porta custom
ssh-copy-id -p 2222 user@server

# Metodo 2: manuale
cat ~/.ssh/id_ed25519.pub | ssh user@server 'cat >> ~/.ssh/authorized_keys'

# Metodo 3: copia diretta (se hai già accesso)
scp ~/.ssh/id_ed25519.pub user@server:~/.ssh/authorized_keys
```

### Testare autenticazione con chiave

```bash
# Login con chiave (dovrebbe non chiedere password)
ssh user@server

# Specifica chiave esplicita
ssh -i ~/.ssh/id_ed25519 user@server

# Debug se non funziona
ssh -v user@server
```

### SSH Agent - Gestione passphrase

Se la chiave ha passphrase, ssh-agent la memorizza durante la sessione.

```bash
# Avvia agent
eval $(ssh-agent)

# Aggiungi chiave
ssh-add ~/.ssh/id_ed25519
# Richiede passphrase una volta

# Lista chiavi caricate
ssh-add -l

# Rimuovi chiave
ssh-add -d ~/.ssh/id_ed25519

# Rimuovi tutte
ssh-add -D

# Termina agent
ssh-agent -k
```

### File di configurazione SSH client

File `~/.ssh/config` semplifica connessioni:

```bash
# Crea/edita config
nano ~/.ssh/config

# Esempio configurazione
Host myserver
    HostName 192.168.1.100
    User alice
    Port 22
    IdentityFile ~/.ssh/id_ed25519
    ServerAliveInterval 60

Host github
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_key

Host *.example.com
    User admin
    Port 2222

# Usa con:
ssh myserver         # invece di ssh alice@192.168.1.100
ssh github           # per GitHub
```

Permessi config:
```bash
chmod 600 ~/.ssh/config
```

---

## Configurazione server SSH

File di configurazione server: `/etc/ssh/sshd_config`

### Modifiche consigliate per sicurezza

```bash
# Backup prima di modificare
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Edita configurazione
sudo nano /etc/ssh/sshd_config
```

Impostazioni consigliate:

```
# Disabilita login root
PermitRootLogin no

# Disabilita autenticazione password (usa solo chiavi)
PasswordAuthentication no
PubkeyAuthentication yes

# Disabilita login con password vuota
PermitEmptyPasswords no

# Cambia porta default (opzionale, security through obscurity)
Port 2222

# Limita utenti
AllowUsers alice bob
# o
AllowGroups sshusers

# Timeout
ClientAliveInterval 300
ClientAliveCountMax 2

# Disabilita X11 forwarding se non necessario
X11Forwarding no

# Limita tentativi login
MaxAuthTries 3
MaxSessions 2

# Protocol (solo SSH v2)
Protocol 2
```

### Applica modifiche

```bash
# Test configurazione
sudo sshd -t

# Se OK, riavvia servizio
sudo systemctl restart sshd

# Verifica status
sudo systemctl status sshd
```

⚠️ **ATTENZIONE**: Prima di disconnetterti, apri una seconda sessione SSH per verificare che puoi ancora connetterti! Non rischiare di rimanere bloccato fuori.

### Fail2Ban - Protezione da brute force

```bash
# Installa Fail2Ban
sudo apt install fail2ban

# Avvia e abilita
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Configurazione (copia per non sovrascrivere con update)
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local

# Esempio configurazione SSH:
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600

# Riavvia
sudo systemctl restart fail2ban

# Status
sudo fail2ban-client status
sudo fail2ban-client status sshd

# Sblocca IP
sudo fail2ban-client set sshd unbanip 192.168.1.100
```

---

## ACL - Access Control Lists

ACL estende i permessi standard Unix (rwx per user/group/other) con controlli più granulari.

### Verifica supporto ACL

```bash
# Verifica se filesystem supporta ACL
tune2fs -l /dev/sda1 | grep "Default mount options"
# Cerca "acl" nell'output

# Se non supportato, abilita
sudo tune2fs -o acl /dev/sda1

# O monta con opzione acl
sudo mount -o remount,acl /
```

### Installazione tool ACL

```bash
# Installa pacchetti ACL
sudo apt install acl          # Debian/Ubuntu
sudo dnf install acl          # RHEL/Fedora
```

### Visualizzare ACL

```bash
# Mostra ACL di file/directory
getfacl file.txt

# Output esempio:
# file: file.txt
# owner: alice
# group: users
# user::rw-
# user:bob:r--
# group::r--
# mask::r--
# other::r--

# Mostra ACL ricorsivo
getfacl -R /path/directory

# Output senza header
getfacl -c file.txt
```

### Impostare ACL

```bash
# Sintassi: setfacl -m u:user:perms file
# Sintassi: setfacl -m g:group:perms file

# Dai permessi utente specifico
setfacl -m u:bob:rw file.txt

# Dai permessi gruppo specifico
setfacl -m g:developers:rx /var/www/html

# Permessi multipli
setfacl -m u:alice:rwx,u:bob:rx file.txt

# Ricorsivo
setfacl -R -m u:bob:rx /data/shared

# Default ACL (per nuovi file in directory)
setfacl -d -m u:bob:rx /data/shared
# Nuovi file in /data/shared erediteranno ACL
```

### Rimuovere ACL

```bash
# Rimuovi ACL specifico
setfacl -x u:bob file.txt

# Rimuovi tutte le ACL
setfacl -b file.txt

# Rimuovi ACL ricorsivo
setfacl -R -b /path/directory
```

### ACL Mask

La mask definisce i permessi massimi per utenti/gruppi (escluso owner).

```bash
# Imposta mask
setfacl -m m::rx file.txt
# Anche se un utente ha ACL "rwx", mask "rx" limita a "rx"

# Ricalcola mask automaticamente
setfacl -m m file.txt
```

### Backup e restore ACL

```bash
# Backup ACL
getfacl -R /data > acl_backup.txt

# Restore ACL
setfacl --restore=acl_backup.txt

# O con pipe
getfacl -R /data | setfacl --restore=-
```

### Esempi pratici ACL

```bash
# Scenario: Shared project directory

# 1. Crea directory
sudo mkdir /project
sudo chown alice:developers /project
sudo chmod 770 /project

# 2. Dai accesso lettura a bob (non in gruppo)
sudo setfacl -m u:bob:rx /project

# 3. Imposta default per nuovi file
sudo setfacl -d -m u:bob:rx /project
sudo setfacl -d -m g:developers:rwx /project

# 4. Verifica
getfacl /project

# 5. Test
su - alice
touch /project/newfile
getfacl /project/newfile  # bob dovrebbe avere rx
```

---

## Firewall con UFW

UFW (Uncomplicated Firewall) è un frontend semplice per iptables.

### Installazione e setup

```bash
# Installa UFW (di solito già installato)
sudo apt install ufw

# Verifica status
sudo ufw status
# Status: inactive

# Policy default (consigliata)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Abilita UFW
sudo ufw enable

# ⚠️ PRIMA di abilitare, consenti SSH o rimarrai bloccato!
sudo ufw allow 22/tcp
# POI
sudo ufw enable
```

### Regole base

```bash
# Consenti porta
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Consenti servizio per nome
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Consenti range porte
sudo ufw allow 6000:6007/tcp

# Nega porta
sudo ufw deny 23/tcp
```

### Regole avanzate

```bash
# Consenti da IP specifico
sudo ufw allow from 192.168.1.100

# Consenti da subnet
sudo ufw allow from 192.168.1.0/24

# Consenti IP specifico a porta specifica
sudo ufw allow from 192.168.1.100 to any port 22

# Consenti IP a interfaccia specifica
sudo ufw allow in on eth0 from 192.168.1.0/24

# Consenti con protocollo
sudo ufw allow proto tcp from 192.168.1.0/24 to any port 3306
```

### Gestione regole

```bash
# Status dettagliato
sudo ufw status verbose

# Status numerato
sudo ufw status numbered

# Elimina regola per numero
sudo ufw delete 3

# Elimina regola specifica
sudo ufw delete allow 80/tcp

# Inserisci regola in posizione specifica
sudo ufw insert 1 allow from 192.168.1.100
```

### Logging

```bash
# Abilita logging
sudo ufw logging on

# Livelli logging
sudo ufw logging low
sudo ufw logging medium
sudo ufw logging high
sudo ufw logging full

# Visualizza log
sudo tail -f /var/log/ufw.log
```

### Applicazioni predefinite

UFW include profili per applicazioni comuni:

```bash
# Lista applicazioni
sudo ufw app list

# Info applicazione
sudo ufw app info 'Apache Full'

# Consenti applicazione
sudo ufw allow 'Apache Full'
sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
```

### Reset firewall

```bash
# Reset tutte le regole
sudo ufw reset

# Disabilita
sudo ufw disable
```

### Esempio configurazione completa

```bash
# Web server con SSH

# 1. Reset (se necessario)
sudo ufw --force reset

# 2. Policy default
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 3. Consenti SSH (importante!)
sudo ufw allow 22/tcp

# 4. Consenti HTTP e HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# 5. Consenti ping (ICMP)
sudo ufw allow proto icmp

# 6. Limite connessioni SSH (rate limiting)
sudo ufw limit 22/tcp

# 7. Abilita
sudo ufw enable

# 8. Verifica
sudo ufw status verbose
```

### Rate limiting

Protegge da brute force:

```bash
# Limita connessioni SSH
sudo ufw limit 22/tcp
# Nega connessioni se >6 tentativi in 30 secondi

# Equivale a:
sudo ufw limit ssh
```

---

## Esercizi pratici

### Esercizio 1: Setup completo SSH con chiavi

```bash
# 1. Genera chiave SSH
ssh-keygen -t ed25519 -C "test@example.com"

# 2. Verifica chiavi generate
ls -la ~/.ssh/

# 3. Visualizza chiave pubblica
cat ~/.ssh/id_ed25519.pub

# 4. (Se hai server remoto) Copia chiave
ssh-copy-id user@server

# 5. Test login
ssh user@server  # non dovrebbe chiedere password

# 6. Configura ~/.ssh/config
nano ~/.ssh/config
# Aggiungi configurazione server

# 7. Test con nome alias
ssh myserver
```

### Esercizio 2: Hardening SSH server

```bash
# ⚠️ Esegui su VM test, non su server produzione!

# 1. Backup configurazione
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# 2. Edita configurazione
sudo nano /etc/ssh/sshd_config

# Modifica:
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222  # (opzionale)

# 3. Test configurazione
sudo sshd -t

# 4. Apri seconda sessione SSH (importante!)
# In altro terminale:
ssh user@server

# 5. Riavvia sshd
sudo systemctl restart sshd

# 6. Test connessione
ssh -p 2222 user@server  # se hai cambiato porta
```

### Esercizio 3: ACL practice

```bash
# 1. Crea ambiente test
mkdir -p ~/acl-test
cd ~/acl-test
touch file1.txt file2.txt
echo "content" > file1.txt

# 2. Imposta ACL
setfacl -m u:$USER:rw file1.txt
setfacl -m u:nobody:r file1.txt

# 3. Visualizza ACL
getfacl file1.txt

# 4. ACL su directory con default
mkdir shared
setfacl -m u:nobody:rx shared/
setfacl -d -m u:nobody:rx shared/

# 5. Crea file in directory e verifica eredità
touch shared/newfile
getfacl shared/newfile

# 6. Rimuovi ACL
setfacl -b file1.txt
getfacl file1.txt
```

### Esercizio 4: UFW configuration

```bash
# 1. Verifica status UFW
sudo ufw status

# 2. Se attivo, reset
sudo ufw --force reset

# 3. Imposta policy
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 4. Consenti SSH (importante!)
sudo ufw allow 22/tcp

# 5. Abilita UFW
sudo ufw enable

# 6. Aggiungi regole
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# 7. Verifica
sudo ufw status numbered

# 8. Test elimina/aggiungi regola
sudo ufw delete allow 443/tcp
sudo ufw status
sudo ufw allow 443/tcp

# 9. Consenti da IP specifico
sudo ufw allow from 192.168.1.100

# 10. Status finale
sudo ufw status verbose
```

### Esercizio 5: Scenario completo

Setup sicuro per web server:

```bash
# 1. Genera chiave SSH (se non già fatto)
ssh-keygen -t ed25519

# 2. (Server) Hardening SSH
sudo nano /etc/ssh/sshd_config
# PermitRootLogin no
# PasswordAuthentication no
sudo systemctl restart sshd

# 3. Setup firewall
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

# 4. Installa fail2ban
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# 5. ACL per directory condivisa
sudo mkdir -p /var/www/shared
sudo setfacl -R -m u:www-data:rwx /var/www/shared
sudo setfacl -R -d -m u:www-data:rwx /var/www/shared

# 6. Verifica tutto
sudo ufw status
sudo systemctl status sshd
sudo systemctl status fail2ban
getfacl /var/www/shared
```

---

## Troubleshooting

### SSH connection refused

```bash
# 1. Verifica servizio attivo
sudo systemctl status sshd

# 2. Verifica porta in ascolto
ss -ltn | grep :22

# 3. Verifica firewall
sudo ufw status
sudo ufw allow 22/tcp

# 4. Test connessione locale
ssh localhost

# 5. Debug
ssh -vvv user@server
```

### SSH key not working

```bash
# 1. Verifica permessi chiavi
ls -la ~/.ssh/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

# 2. Verifica authorized_keys su server
ssh user@server 'cat ~/.ssh/authorized_keys'
ssh user@server 'chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys'

# 3. Verifica configurazione sshd
sudo grep PubkeyAuthentication /etc/ssh/sshd_config

# 4. Check log server
sudo tail -f /var/log/auth.log
```

### UFW blocks legitimate traffic

```bash
# 1. Verifica regole
sudo ufw status numbered

# 2. Check log
sudo tail -f /var/log/ufw.log

# 3. Consenti temporaneamente tutto (debug)
sudo ufw disable

# 4. Riconfigura correttamente
sudo ufw allow from 192.168.1.0/24
sudo ufw enable
```

---

## Comandi da memorizzare

```bash
# === SSH ===
ssh user@host                # Connetti
ssh-keygen -t ed25519        # Genera chiave
ssh-copy-id user@host        # Copia chiave
ssh -i key.pem user@host     # Usa chiave specifica
nano ~/.ssh/config           # Config client

# === SSH server ===
sudo nano /etc/ssh/sshd_config  # Config server
sudo systemctl restart sshd     # Riavvia
sudo sshd -t                    # Test config

# === ACL ===
getfacl file                 # Mostra ACL
setfacl -m u:user:rwx file   # Imposta ACL utente
setfacl -m g:group:rx file   # Imposta ACL gruppo
setfacl -x u:user file       # Rimuovi ACL
setfacl -b file              # Rimuovi tutte ACL
setfacl -d -m u:user:rx dir  # Default ACL

# === UFW ===
sudo ufw status              # Status
sudo ufw enable              # Abilita
sudo ufw allow 22/tcp        # Consenti porta
sudo ufw deny 23/tcp         # Nega porta
sudo ufw delete allow 80     # Elimina regola
sudo ufw reset               # Reset tutte regole
sudo ufw limit 22/tcp        # Rate limit
```

---

## Checklist settimana 8

- [ ] So connettermi via SSH
- [ ] Ho generato e configurato chiavi SSH
- [ ] So usare ssh-agent per passphrase
- [ ] So configurare ~/.ssh/config
- [ ] So configurare server SSH sicuro
- [ ] Conosco le best practice SSH security
- [ ] So cos'è Fail2Ban e come configurarlo
- [ ] So usare getfacl e setfacl
- [ ] So impostare ACL default su directory
- [ ] So usare UFW per regole base
- [ ] So configurare UFW per web server
- [ ] So usare rate limiting con UFW
- [ ] Ho fatto tutti gli esercizi pratici

---

## Risorse aggiuntive

- Man pages: `man ssh`, `man ssh-keygen`, `man sshd_config`, `man setfacl`, `man ufw`
- SSH Academy: https://www.ssh.com/academy
- UFW documentation: https://help.ubuntu.com/community/UFW
- ACL Guide: https://wiki.archlinux.org/title/Access_Control_Lists

**Prossima settimana**: Automazione (Bash scripting, crontab, Docker basics)
