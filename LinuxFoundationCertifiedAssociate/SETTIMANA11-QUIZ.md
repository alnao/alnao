# Settimana 11 — Quiz LFCA: 20 Domande Tipiche dell'Esame

Questo documento contiene 20 domande che simulano il tipo e la difficoltà dell'esame LFCA. Ogni domanda include la risposta corretta e una spiegazione dettagliata.

---

## Domanda 1: Permessi File

**Domanda**: Quale comando imposta i permessi di un file in modo che il proprietario possa leggere e scrivere, il gruppo possa solo leggere, e gli altri non abbiano accesso?

A) `chmod 600 file.txt`  
B) `chmod 640 file.txt`  
C) `chmod 644 file.txt`  
D) `chmod 755 file.txt`

**Risposta**: B) `chmod 640 file.txt`

**Spiegazione**:
- 6 (rw-) per owner: 4(read) + 2(write)
- 4 (r--) per group: 4(read)
- 0 (---) per others: nessun permesso

Comando completo:
```bash
chmod 640 file.txt
# oppure in notazione simbolica:
chmod u=rw,g=r,o= file.txt
```

---

## Domanda 2: Redirezione Output

**Domanda**: Quale comando redirige sia lo standard output che lo standard error in un file chiamato `output.log`?

A) `comando > output.log 2>&1`  
B) `comando >> output.log`  
C) `comando 2> output.log`  
D) `comando | output.log`

**Risposta**: A) `comando > output.log 2>&1`

**Spiegazione**:
- `>` redirige stdout
- `2>&1` redirige stderr (2) a dove punta stdout (1)
- Alternativa moderna: `comando &> output.log`

Esempio:
```bash
find / -name "*.conf" > output.log 2>&1
# oppure:
find / -name "*.conf" &> output.log
```

---

## Domanda 3: Ricerca File

**Domanda**: Come trovi tutti i file modificati negli ultimi 7 giorni nella directory `/var/log`?

A) `find /var/log -type f -mtime -7`  
B) `find /var/log -type f -mtime +7`  
C) `find /var/log -modified 7`  
D) `locate /var/log -mtime 7`

**Risposta**: A) `find /var/log -type f -mtime -7`

**Spiegazione**:
- `-type f`: solo file regolari
- `-mtime -7`: modificati negli ultimi 7 giorni (- significa "meno di")
- `-mtime +7`: modificati più di 7 giorni fa
- `-mtime 7`: esattamente 7 giorni fa

Esempio completo:
```bash
find /var/log -type f -mtime -7 -ls
find /var/log -type f -mtime -1  # ultime 24 ore
```

---

## Domanda 4: Gestione Utenti

**Domanda**: Quale comando crea un nuovo utente chiamato "john" con una home directory e la shell `/bin/bash`?

A) `useradd john`  
B) `adduser john /home/john /bin/bash`  
C) `useradd -m -s /bin/bash john`  
D) `createuser john -h -s bash`

**Risposta**: C) `useradd -m -s /bin/bash john`

**Spiegazione**:
- `-m`: crea home directory
- `-s /bin/bash`: specifica shell
- Senza `-m`, la home non viene creata automaticamente

Esempio completo:
```bash
sudo useradd -m -s /bin/bash -c "John Doe" john
sudo passwd john
id john
ls -ld /home/john
```

---

## Domanda 5: Sudo Configuration

**Domanda**: Quale file devi modificare per dare a un utente i permessi di eseguire comandi come root?

A) `/etc/passwd`  
B) `/etc/group`  
C) `/etc/sudoers`  
D) `/etc/shadow`

**Risposta**: C) `/etc/sudoers`

**Spiegazione**:
- **MAI modificare direttamente** `/etc/sudoers`
- Usa sempre `sudo visudo` per sicurezza
- Oppure crea file in `/etc/sudoers.d/`

Esempio:
```bash
# Metodo sicuro
sudo visudo

# Aggiungi utente a gruppo sudo (Debian/Ubuntu)
sudo usermod -aG sudo john

# Configurazione custom
sudo visudo -f /etc/sudoers.d/john
# Contenuto: john ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx
```

---

## Domanda 6: Gestione Processi

**Domanda**: Come termini forzatamente un processo con PID 1234?

A) `kill 1234`  
B) `kill -9 1234`  
C) `stop 1234`  
D) `terminate -f 1234`

**Risposta**: B) `kill -9 1234`

**Spiegazione**:
- `kill PID`: invia SIGTERM (terminazione pulita)
- `kill -9 PID`: invia SIGKILL (terminazione forzata, non può essere ignorato)
- `-9` è il numero del segnale SIGKILL

Esempio:
```bash
# Metodo preferito (terminazione pulita)
kill 1234

# Se non funziona, forza
kill -9 1234

# Per nome processo
killall process_name
pkill pattern
```

---

## Domanda 7: Systemd Services

**Domanda**: Quale comando abilita il servizio nginx ad avviarsi automaticamente al boot?

A) `systemctl start nginx`  
B) `systemctl enable nginx`  
C) `systemctl restart nginx`  
D) `service nginx enable`

**Risposta**: B) `systemctl enable nginx`

**Spiegazione**:
- `start`: avvia ora ma non al boot
- `enable`: configura per avvio automatico al boot
- `restart`: riavvia servizio
- Per avviare ora E abilitare al boot: `systemctl enable --now nginx`

Esempio completo:
```bash
sudo systemctl enable nginx    # abilita al boot
sudo systemctl start nginx     # avvia ora
sudo systemctl enable --now nginx  # entrambi
sudo systemctl status nginx    # verifica
```

---

## Domanda 8: Journalctl Log

**Domanda**: Come visualizzi i log del servizio ssh degli ultimi 30 minuti?

A) `journalctl -u ssh -since 30m`  
B) `journalctl --unit ssh --since "30 minutes ago"`  
C) `tail -f /var/log/ssh.log`  
D) `cat /var/log/auth.log | grep ssh`

**Risposta**: B) `journalctl --unit ssh --since "30 minutes ago"`

**Spiegazione**:
- `-u` o `--unit`: specifica servizio
- `--since`: filtra per data/ora
- Formato flessibile: "30 minutes ago", "1 hour ago", "today"

Esempi:
```bash
journalctl -u ssh --since "30 minutes ago"
journalctl -u ssh --since "2024-01-15 10:00:00"
journalctl -u ssh --since today
journalctl -u ssh -n 50  # ultime 50 righe
journalctl -u ssh -f     # follow (come tail -f)
```

---

## Domanda 9: Networking - IP Configuration

**Domanda**: Quale comando mostra la configurazione IP di tutte le interfacce di rete?

A) `ifconfig -a`  
B) `ip addr show`  
C) `netstat -i`  
D) `show ip`

**Risposta**: B) `ip addr show`

**Spiegazione**:
- `ip` è il comando moderno per networking
- `ifconfig` è deprecato (ma ancora funziona)
- `ip addr` o `ip a` sono abbreviazioni valide

Esempi:
```bash
ip addr show           # tutte le interfacce
ip a                   # forma breve
ip addr show eth0      # interfaccia specifica
ip -4 addr             # solo IPv4
ip -br addr            # formato compatto
```

---

## Domanda 10: DNS Resolution

**Domanda**: Quale comando utilizzi per verificare la risoluzione DNS di google.com?

A) `ping google.com`  
B) `dig google.com`  
C) `traceroute google.com`  
D) `netstat google.com`

**Risposta**: B) `dig google.com`

**Spiegazione**:
- `dig`: strumento specifico per query DNS
- `ping`: testa connettività (usa DNS ma non è specifico per DNS)
- `nslookup` e `host` sono alternative valide

Esempi:
```bash
dig google.com
dig +short google.com             # solo IP
dig google.com A                  # record A (IPv4)
dig google.com AAAA              # record AAAA (IPv6)
dig @8.8.8.8 google.com          # usa DNS specifico
nslookup google.com              # alternativa
host google.com                  # alternativa semplice
```

---

## Domanda 11: Package Management (APT)

**Domanda**: Come aggiorni la lista dei pacchetti disponibili e poi aggiorni tutti i pacchetti installati su un sistema Debian/Ubuntu?

A) `apt upgrade && apt update`  
B) `apt-get update && apt-get upgrade`  
C) `apt update && apt upgrade`  
D) `apt install --upgrade-all`

**Risposta**: C) `apt update && apt upgrade`

**Spiegazione**:
- `apt update`: aggiorna lista pacchetti dai repository
- `apt upgrade`: aggiorna pacchetti installati
- Ordine importante: prima `update` poi `upgrade`
- `&&`: esegue secondo comando solo se primo ha successo

Esempio completo:
```bash
sudo apt update
sudo apt upgrade -y
# Oppure in un comando:
sudo apt update && sudo apt upgrade -y

# Full upgrade (può rimuovere pacchetti)
sudo apt full-upgrade
```

---

## Domanda 12: File System - df/du

**Domanda**: Come verifichi lo spazio disco utilizzato dalla directory `/var/log`?

A) `df -h /var/log`  
B) `du -sh /var/log`  
C) `free -h /var/log`  
D) `ls -lh /var/log`

**Risposta**: B) `du -sh /var/log`

**Spiegazione**:
- `du`: disk usage (utilizzo directory)
- `df`: disk free (spazio filesystem)
- `-s`: summary (totale)
- `-h`: human-readable

Esempi:
```bash
du -sh /var/log                    # totale directory
du -h --max-depth=1 /var/log      # subdirectory di primo livello
du -sh /var/log/*                  # tutti i file/subdir
df -h                              # spazio filesystem
df -h /var/log                     # filesystem che contiene /var/log
```

---

## Domanda 13: Tar Archives

**Domanda**: Quale comando crea un archivio tar compresso con gzip della directory `/home/user/documents` e lo salva come `backup.tar.gz`?

A) `tar -xzf backup.tar.gz /home/user/documents`  
B) `tar -czf backup.tar.gz /home/user/documents`  
C) `gzip /home/user/documents > backup.tar.gz`  
D) `tar -cf backup.tar.gz /home/user/documents`

**Risposta**: B) `tar -czf backup.tar.gz /home/user/documents`

**Spiegazione**:
- `c`: create
- `z`: gzip compression
- `f`: file (nome archivio)
- `x`: extract (per estrarre)

Esempi:
```bash
# Crea archivio compresso
tar -czf backup.tar.gz /home/user/documents

# Estrai archivio
tar -xzf backup.tar.gz

# Lista contenuto
tar -tzf backup.tar.gz

# Crea con verbose
tar -czvf backup.tar.gz /home/user/documents
```

---

## Domanda 14: SSH Key Generation

**Domanda**: Quale comando genera una coppia di chiavi SSH di tipo ed25519?

A) `ssh-keygen -t rsa`  
B) `ssh-keygen -t ed25519`  
C) `ssh-generate -type ed25519`  
D) `keygen -ssh ed25519`

**Risposta**: B) `ssh-keygen -t ed25519`

**Spiegazione**:
- `ssh-keygen`: comando per generare chiavi
- `-t ed25519`: tipo di chiave (moderno e sicuro)
- Alternative: `-t rsa -b 4096` (RSA 4096 bit)

Esempio completo:
```bash
# Genera chiave ed25519
ssh-keygen -t ed25519 -C "your@email.com"

# Genera chiave RSA
ssh-keygen -t rsa -b 4096

# Copia chiave su server
ssh-copy-id user@server

# Login con chiave
ssh user@server
```

---

## Domanda 15: Firewall - UFW

**Domanda**: Come consenti il traffico in ingresso sulla porta 443 (HTTPS) usando UFW?

A) `ufw enable 443`  
B) `ufw allow 443`  
C) `ufw open 443/tcp`  
D) `ufw permit https`

**Risposta**: B) `ufw allow 443`

**Spiegazione**:
- `allow`: consente traffico
- Può specificare porta e protocollo: `443/tcp`
- Può usare nome servizio: `https`

Esempi:
```bash
# Vari modi equivalenti
sudo ufw allow 443
sudo ufw allow 443/tcp
sudo ufw allow https

# Altri esempi
sudo ufw allow 22/tcp      # SSH
sudo ufw allow 80/tcp      # HTTP
sudo ufw deny 23/tcp       # blocca telnet

# Status
sudo ufw status
sudo ufw status numbered

# Abilita firewall
sudo ufw enable
```

---

## Domanda 16: Grep Pattern Matching

**Domanda**: Come cerchi la parola "error" (case-insensitive) nel file `/var/log/syslog` e mostri anche il numero di riga?

A) `grep error /var/log/syslog`  
B) `grep -i error /var/log/syslog`  
C) `grep -in error /var/log/syslog`  
D) `grep -r error /var/log/syslog`

**Risposta**: C) `grep -in error /var/log/syslog`

**Spiegazione**:
- `-i`: case-insensitive (ignora maiuscole/minuscole)
- `-n`: mostra numero riga
- `-r`: ricorsivo (non necessario per singolo file)

Esempi:
```bash
grep -in error /var/log/syslog
grep -in "error" /var/log/syslog | less
grep -in "error" /var/log/syslog | wc -l     # conta occorrenze
grep -in "error" /var/log/syslog | head -20  # prime 20

# Con contesto
grep -in -C 3 "error" /var/log/syslog  # 3 righe prima e dopo
```

---

## Domanda 17: Process Priority

**Domanda**: Quale comando avvia un processo con priorità bassa (nice value 10)?

A) `priority 10 comando`  
B) `nice -n 10 comando`  
C) `renice 10 comando`  
D) `comando --priority=10`

**Risposta**: B) `nice -n 10 comando`

**Spiegazione**:
- `nice`: avvia comando con priorità specifica
- `-n 10`: nice value (più alto = meno priorità)
- Range: -20 (max) a 19 (min)
- `renice`: cambia priorità processo esistente

Esempi:
```bash
# Avvia con bassa priorità
nice -n 10 ./long-running-script.sh

# Avvia con alta priorità (solo root)
sudo nice -n -10 importante-comando

# Cambia priorità esistente
renice 5 -p PID
renice -n 5 -p PID
```

---

## Domanda 18: Crontab Scheduling

**Domanda**: Quale entry crontab esegue uno script ogni giorno alle 3:30 AM?

A) `30 3 * * * /path/to/script.sh`  
B) `3 30 * * * /path/to/script.sh`  
C) `* * 3 30 * /path/to/script.sh`  
D) `@daily /path/to/script.sh`

**Risposta**: A) `30 3 * * * /path/to/script.sh`

**Spiegazione**:
- Formato: `MIN HOUR DOM MON DOW COMMAND`
- 30 = minuto 30
- 3 = ora 3 (3 AM)
- `* * *` = ogni giorno, ogni mese, ogni giorno settimana

Esempi:
```bash
# Edita crontab
crontab -e

# Vari esempi
30 3 * * * /path/script.sh              # 3:30 AM ogni giorno
0 */4 * * * /path/script.sh             # ogni 4 ore
*/15 * * * * /path/script.sh            # ogni 15 minuti
0 9 * * 1 /path/script.sh               # Lunedì alle 9:00
@daily /path/script.sh                  # mezzanotte ogni giorno
@reboot /path/startup.sh                # al riavvio

# Lista crontab
crontab -l
```

---

## Domanda 19: Rsync Synchronization

**Domanda**: Quale comando sincronizza la directory locale `/source` con `/destination` e cancella i file in destinazione che non esistono più in source?

A) `rsync -av /source/ /destination/`  
B) `rsync -av --delete /source/ /destination/`  
C) `rsync -av --remove /source/ /destination/`  
D) `cp -r /source/ /destination/`

**Risposta**: B) `rsync -av --delete /source/ /destination/`

**Spiegazione**:
- `-a`: archive mode (preserva permessi, timestamp, etc.)
- `-v`: verbose
- `--delete`: rimuove file extra in destinazione
- **Importante**: trailing slash in `/source/` (senza slash si comporta diversamente)

Esempi:
```bash
# Sincronizzazione base
rsync -av /source/ /destination/

# Con delete
rsync -av --delete /source/ /destination/

# Dry run (test senza modificare)
rsync -av --delete --dry-run /source/ /destination/

# Con esclusioni
rsync -av --delete --exclude='*.tmp' /source/ /destination/

# Remoto
rsync -av /local/ user@server:/remote/
```

---

## Domanda 20: Finding Open Ports

**Domanda**: Quale comando mostra tutte le porte TCP in ascolto sul sistema con i processi associati?

A) `netstat -tulpn`  
B) `ss -ltnp`  
C) `lsof -i TCP`  
D) Tutte le precedenti

**Risposta**: D) Tutte le precedenti (ma B è il metodo moderno preferito)

**Spiegazione**:
- `ss`: comando moderno (sostituisce netstat)
- `-l`: listening
- `-t`: TCP
- `-n`: numerico (non risolve nomi)
- `-p`: mostra processo

Esempi:
```bash
# Metodo moderno (preferito)
sudo ss -ltnp

# Alternative valide
sudo netstat -tulpn
sudo lsof -i TCP -sTCP:LISTEN

# Altri esempi utili
ss -ltn                          # TCP listening (no processi)
ss -lun                          # UDP listening
ss -t state established          # connessioni TCP stabilite
ss -tn sport = :22               # chi usa porta 22
```

---

## Riepilogo Risposte Rapide

1. B - `chmod 640`
2. A - `comando > file 2>&1`
3. A - `find -mtime -7`
4. C - `useradd -m -s /bin/bash`
5. C - `/etc/sudoers` (con visudo)
6. B - `kill -9 PID`
7. B - `systemctl enable`
8. B - `journalctl --unit ssh --since "30 minutes ago"`
9. B - `ip addr show`
10. B - `dig google.com`
11. C - `apt update && apt upgrade`
12. B - `du -sh /var/log`
13. B - `tar -czf`
14. B - `ssh-keygen -t ed25519`
15. B - `ufw allow 443`
16. C - `grep -in`
17. B - `nice -n 10`
18. A - `30 3 * * *`
19. B - `rsync --delete`
20. D - Tutte (preferito: `ss -ltnp`)

---

## Consigli per l'esame

1. **Leggi attentamente**: molte domande hanno dettagli sottili
2. **Pratica i comandi**: non basta conoscere la teoria
3. **Gestisci il tempo**: non bloccarti su domande difficili
4. **Usa process of elimination**: escludi risposte palesemente sbagliate
5. **Attenzione all'ordine**: `apt update && apt upgrade` NON è uguale a `apt upgrade && apt update`
6. **Memorizza opzioni comuni**: `-a`, `-v`, `-r`, `-n`, `-i`, `-f`
7. **Pratica scenari reali**: non solo comandi singoli
8. **Rivedi errori**: analizza perché hai sbagliato

## Prossimi passi

- Ripeti questi quiz finché non ottieni 18/20+
- Pratica ogni comando su VM
- Fai simulazioni con timer (simula pressione esame)
- Crea cheat-sheet personale
- Ripassa le settimane 1-10

**Buona fortuna con l'esame LFCA!** 🚀
