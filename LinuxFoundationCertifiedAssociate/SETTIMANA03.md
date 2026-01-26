# Settimana 3 — Utenti, Gruppi e Autenticazione (LFCA)
Tempo stimato: 2–3 ore

Questa guida copre la gestione di utenti, gruppi e il sistema di autenticazione in Linux, elementi fondamentali per l'amministrazione del sistema e la sicurezza.

## Introduzione
In Linux, la gestione degli utenti è essenziale per:
- Controllare l'accesso al sistema
- Assegnare permessi appropriati
- Isolare ambienti e risorse
- Implementare il principio del minimo privilegio

## Concetti fondamentali

### File di sistema per utenti e gruppi

1. **`/etc/passwd`** — database degli utenti
   ```
   username:x:UID:GID:comment:home:shell
   ```
   Esempio:
   ```
   alice:x:1000:1000:Alice Smith:/home/alice:/bin/bash
   ```

2. **`/etc/shadow`** — password criptate (solo root)
   ```
   username:encrypted_password:lastchange:min:max:warn:inactive:expire
   ```

3. **`/etc/group`** — database dei gruppi
   ```
   groupname:x:GID:members
   ```
   Esempio:
   ```
   developers:x:1001:alice,bob
   ```

4. **`/etc/gshadow`** — password di gruppo (raramente usato)

### Tipi di utenti

- **root (UID 0)**: superutente con tutti i privilegi
- **Utenti di sistema (UID 1-999)**: per servizi e demoni
- **Utenti normali (UID ≥ 1000)**: utenti umani

## Comandi per la gestione utenti

### useradd — creare utenti

```bash
# Sintassi base
sudo useradd [opzioni] username

# Crea utente con home directory
sudo useradd -m alice

# Crea utente con shell specifica
sudo useradd -m -s /bin/bash bob

# Crea utente con UID e GID specifici
sudo useradd -m -u 1500 -g 1500 charlie

# Crea utente con commento
sudo useradd -m -c "Developer Account" -s /bin/bash dave

# Opzioni comuni:
# -m  : crea home directory
# -s  : specifica shell
# -u  : specifica UID
# -g  : specifica gruppo primario
# -G  : gruppi supplementari
# -d  : specifica home directory
# -c  : commento (nome completo)
# -e  : data scadenza account
```

### usermod — modificare utenti

```bash
# Cambia shell
sudo usermod -s /bin/zsh alice

# Aggiungi utente a gruppo supplementare
sudo usermod -aG sudo alice
sudo usermod -aG docker,www-data bob

# Cambia home directory
sudo usermod -d /new/home -m alice

# Blocca account
sudo usermod -L alice

# Sblocca account
sudo usermod -U alice

# Cambia UID
sudo usermod -u 1600 alice

# Opzioni comuni:
# -aG : append to groups (importante: non perdere gruppi esistenti!)
# -G  : set groups (SOSTITUISCE tutti i gruppi supplementari)
# -L  : lock account
# -U  : unlock account
# -l  : cambia username
```

### userdel — eliminare utenti

```bash
# Elimina utente (mantiene home)
sudo userdel alice

# Elimina utente e home directory
sudo userdel -r alice

# Elimina utente forzatamente (anche se loggato)
sudo userdel -f alice
```

### passwd — gestione password

```bash
# Imposta password (utente corrente)
passwd

# Imposta password per altro utente (root)
sudo passwd alice

# Forza cambio password al prossimo login
sudo passwd -e alice

# Blocca account
sudo passwd -l alice

# Sblocca account
sudo passwd -u alice

# Mostra stato password
sudo passwd -S alice

# Configura scadenza password
sudo passwd -x 90 alice  # scade dopo 90 giorni
sudo passwd -n 10 alice  # min 10 giorni tra cambi
sudo passwd -w 7 alice   # warning 7 giorni prima scadenza
```

## Gestione gruppi

### groupadd — creare gruppi

```bash
# Crea gruppo
sudo groupadd developers

# Crea gruppo con GID specifico
sudo groupadd -g 2000 admins

# Crea gruppo di sistema
sudo groupadd -r sysgroup
```

### groupmod — modificare gruppi

```bash
# Cambia nome gruppo
sudo groupmod -n newname oldname

# Cambia GID
sudo groupmod -g 2100 developers
```

### groupdel — eliminare gruppi

```bash
sudo groupdel developers
```

### gpasswd — gestione membri gruppo

```bash
# Aggiungi utente a gruppo
sudo gpasswd -a alice developers

# Rimuovi utente da gruppo
sudo gpasswd -d alice developers

# Imposta amministratori di gruppo
sudo gpasswd -A alice,bob developers
```

## Comandi di interrogazione

### id — mostra informazioni utente

```bash
# Info utente corrente
id

# Info utente specifico
id alice

# Output esempio:
# uid=1000(alice) gid=1000(alice) groups=1000(alice),27(sudo),999(docker)
```

### who/w — utenti loggati

```bash
# Utenti attualmente loggati
who
who -a  # informazioni dettagliate

# Info più dettagliate
w
```

### last — cronologia login

```bash
# Ultimi login
last

# Ultimi login di un utente
last alice

# Ultimi reboot
last reboot
```

### groups — mostra gruppi utente

```bash
# Gruppi utente corrente
groups

# Gruppi di un utente specifico
groups alice
```

## Il sistema sudo

### Concetti sudo

**sudo** (SuperUser DO) permette di eseguire comandi come root senza conoscere la password di root.

### File sudoers

Il file `/etc/sudoers` controlla i permessi sudo. **MAI MODIFICARE DIRETTAMENTE** — usa sempre `visudo`.

```bash
# Modifica sudoers in sicurezza
sudo visudo
```

### Sintassi sudoers

```
# Formato base
user    host=(runas) commands

# Esempi comuni:
alice   ALL=(ALL:ALL) ALL           # alice può fare tutto
bob     ALL=(ALL) /usr/bin/systemctl  # bob può solo systemctl
%sudo   ALL=(ALL:ALL) ALL           # gruppo sudo può fare tutto
charlie ALL=(ALL) NOPASSWD: ALL     # charlie senza password (PERICOLOSO!)
```

### Configurazioni sudo comuni

```bash
# Aggiungi utente a gruppo sudo (Debian/Ubuntu)
sudo usermod -aG sudo alice

# Aggiungi utente a gruppo wheel (RHEL/CentOS)
sudo usermod -aG wheel alice

# Verifica permessi sudo
sudo -l

# Esegui comando come altro utente
sudo -u alice comando

# Esegui shell come root
sudo -i
```

### File di configurazione sudo in /etc/sudoers.d/

```bash
# Crea file per utente specifico
sudo visudo -f /etc/sudoers.d/alice

# Contenuto:
# alice ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx
```

## Esercizi pratici

### Esercizio 1: Creare e gestire utenti

```bash
# 1. Crea tre utenti
sudo useradd -m -c "Developer 1" -s /bin/bash dev1
sudo useradd -m -c "Developer 2" -s /bin/bash dev2
sudo useradd -m -c "Admin User" -s /bin/bash admin1

# 2. Imposta password
sudo passwd dev1
sudo passwd dev2
sudo passwd admin1

# 3. Verifica creazione
id dev1
grep dev1 /etc/passwd
ls -ld /home/dev1

# 4. Visualizza info
cat /etc/passwd | grep -E "dev1|dev2|admin1"
```

### Esercizio 2: Gestire gruppi

```bash
# 1. Crea gruppi
sudo groupadd developers
sudo groupadd admins
sudo groupadd testers

# 2. Aggiungi utenti ai gruppi
sudo usermod -aG developers dev1
sudo usermod -aG developers dev2
sudo usermod -aG admins admin1
sudo usermod -aG testers,developers dev2

# 3. Verifica appartenenza
groups dev1
groups dev2
id -Gn admin1

# 4. Visualizza membri gruppo
getent group developers
```

### Esercizio 3: Configurare sudo

```bash
# 1. Aggiungi dev1 al gruppo sudo
sudo usermod -aG sudo dev1

# 2. Crea regola sudo personalizzata per dev2
sudo visudo -f /etc/sudoers.d/dev2

# Aggiungi:
# dev2 ALL=(ALL) NOPASSWD: /usr/bin/systemctl status *
# dev2 ALL=(ALL) /usr/bin/systemctl restart nginx

# 3. Testa permessi
sudo -u dev1 sudo whoami  # dovrebbe funzionare
sudo -l -U dev2           # mostra permessi dev2
```

### Esercizio 4: Scenari reali

```bash
# Scenario 1: Nuovo sviluppatore nel team
sudo useradd -m -s /bin/bash -c "John Doe" jdoe
sudo passwd jdoe
sudo usermod -aG developers,docker jdoe
sudo mkdir -p /projects/teamproject
sudo chgrp developers /projects/teamproject
sudo chmod 770 /projects/teamproject

# Scenario 2: Utente temporaneo (scade tra 30 giorni)
sudo useradd -m -e $(date -d "+30 days" +%Y-%m-%d) tempuser
sudo passwd tempuser

# Scenario 3: Blocca utente sospetto
sudo usermod -L suspicious_user
sudo passwd -l suspicious_user

# Scenario 4: Audit utenti
echo "=== User Audit ===" > user_audit.txt
echo "Active users:" >> user_audit.txt
awk -F: '$3 >= 1000 {print $1}' /etc/passwd >> user_audit.txt
echo -e "\nSudo users:" >> user_audit.txt
getent group sudo | cut -d: -f4 >> user_audit.txt
cat user_audit.txt
```

### Esercizio 5: Troubleshooting permessi

```bash
# 1. Crea scenario problema
sudo useradd -m testuser
sudo passwd testuser
echo "#!/bin/bash" > /home/testuser/script.sh
echo "echo 'Hello World'" >> /home/testuser/script.sh

# 2. Prova a eseguire (fallirà)
sudo -u testuser /home/testuser/script.sh

# 3. Diagnostica
ls -l /home/testuser/script.sh

# 4. Risolvi
sudo chmod +x /home/testuser/script.sh
sudo -u testuser /home/testuser/script.sh

# 5. Verifica owner
sudo chown testuser:testuser /home/testuser/script.sh
ls -l /home/testuser/script.sh
```

## Best practices

1. **Usa sudo invece di root diretto**
   - Mai loggare come root
   - Usa `sudo` per comandi privilegiati

2. **Principio del minimo privilegio**
   - Dai solo i permessi necessari
   - Usa sudoers per limitare comandi specifici

3. **Gruppi per gestire permessi**
   - Crea gruppi per ruoli (developers, admins, etc.)
   - Assegna permessi a gruppi, non singoli utenti

4. **Password forti e scadenze**
   - Imponi policy password forti
   - Configura scadenza password

5. **Audit regolare**
   - Revisiona utenti periodicamente
   - Rimuovi account non più necessari

6. **Usa visudo**
   - Mai modificare `/etc/sudoers` direttamente
   - Usa file in `/etc/sudoers.d/` per organizzazione

## Comandi rapidi di riferimento

```bash
# Utenti
sudo useradd -m username
sudo usermod -aG group username
sudo userdel -r username
sudo passwd username

# Gruppi
sudo groupadd groupname
sudo gpasswd -a username groupname
sudo groupdel groupname

# Info
id username
groups username
sudo -l
who
last

# Sudo
sudo visudo
sudo -u user command
sudo -i
```

## Domande comuni

**Q: Differenza tra `useradd` e `adduser`?**  
A: `adduser` è uno script interattivo (Debian/Ubuntu), `useradd` è il comando low-level universale.

**Q: Come vedere tutti i membri di un gruppo?**  
A: `getent group groupname` o `grep groupname /etc/group`

**Q: Come rimuovere utente da un gruppo?**  
A: `sudo gpasswd -d username groupname`

**Q: Differenza tra `-aG` e `-G` in usermod?**  
A: `-aG` appende ai gruppi esistenti, `-G` SOSTITUISCE tutti i gruppi supplementari.

**Q: Come vedere chi ha permessi sudo?**  
A: `getent group sudo` (Debian) o `getent group wheel` (RHEL)

## Tempo suggerito

- 20 minuti: leggere concetti
- 90 minuti: esercizi pratici
- 20 minuti: creare cheat-sheet e testare scenari

## Risorse

- `man useradd`, `man usermod`, `man sudo`, `man visudo`
- `/etc/login.defs` — configurazioni default per creazione utenti
- `/etc/pam.d/` — Pluggable Authentication Modules
- Prossima settimana: Processi, Servizi e Logging con systemd.
