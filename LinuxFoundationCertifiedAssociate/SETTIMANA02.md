# Settimana 2 — I/O, Redirezioni e Ricerca Testi (LFCA)
Tempo stimato per completare questa sessione: 2–3 ore

Questa guida copre la seconda settimana del piano LFCA: padroneggiare redirezioni, pipe e ricerca di testo/file. Imparerai a manipolare l'input/output, concatenare comandi e cercare informazioni nei file e nel filesystem.

## Introduzione
Le redirezioni e le pipe sono strumenti potentissimi della shell Unix/Linux. Ti permettono di:
- Salvare l'output di un comando in un file
- Concatenare più comandi per trasformare dati
- Cercare testo in file o output di comandi
- Trovare file nel filesystem

Questi concetti sono fondamentali per lavorare efficacemente con Linux e per superare l'esame LFCA.

## Redirezioni I/O

### Standard streams
Ogni processo ha tre stream:
- **stdin** (0): input standard (tastiera)
- **stdout** (1): output standard (schermo)
- **stderr** (2): errori (schermo)

### Operatori di redirezione base

1. **`>`** — redirige stdout (sovrascrive)
   ```bash
   ls -l > file_list.txt
   echo "Hello" > greeting.txt
   ```

2. **`>>`** — redirige stdout (appende)
   ```bash
   echo "Line 1" > file.txt
   echo "Line 2" >> file.txt
   cat file.txt
   ```

3. **`<`** — redirige stdin
   ```bash
   wc -l < file.txt
   sort < unsorted.txt > sorted.txt
   ```

4. **`2>`** — redirige stderr
   ```bash
   ls /nonexistent 2> errors.txt
   find / -name "*.log" 2> /dev/null
   ```

5. **`&>`** — redirige sia stdout che stderr
   ```bash
   command &> output.txt
   # equivale a: command > output.txt 2>&1
   ```

6. **`|`** — pipe (passa stdout come stdin al comando successivo)
   ```bash
   ls -l | grep ".txt"
   cat file.txt | wc -l
   ps aux | grep nginx | wc -l
   ```

## Comandi per la ricerca di testo

### grep — cerca pattern in file o input

**Sintassi base:**
```bash
grep [opzioni] pattern [file...]
```

**Opzioni comuni:**
- `-i` — ignora maiuscole/minuscole
- `-r` o `-R` — ricerca ricorsiva nelle directory
- `-n` — mostra numero di riga
- `-v` — inverte la ricerca (righe che NON contengono il pattern)
- `-c` — conta le occorrenze
- `-l` — mostra solo nomi dei file che contengono il pattern
- `-A n` — mostra n righe dopo il match
- `-B n` — mostra n righe prima del match
- `-C n` — mostra n righe prima e dopo il match

**Esempi:**
```bash
# Cerca "error" in un file
grep "error" /var/log/syslog

# Cerca case-insensitive
grep -i "warning" /var/log/syslog

# Cerca ricorsivamente in una directory
grep -r "TODO" ~/projects/

# Conta occorrenze
grep -c "failed" /var/log/auth.log

# Mostra righe che NON contengono "success"
grep -v "success" logfile.txt

# Cerca con contesto (3 righe prima e dopo)
grep -C 3 "error" application.log
```

### find — cerca file nel filesystem

**Sintassi base:**
```bash
find [path] [expression]
```

**Opzioni comuni:**
- `-name pattern` — cerca per nome (case-sensitive)
- `-iname pattern` — cerca per nome (case-insensitive)
- `-type f` — solo file regolari
- `-type d` — solo directory
- `-size +10M` — file più grandi di 10MB
- `-mtime -7` — modificati negli ultimi 7 giorni
- `-user username` — appartiene all'utente
- `-perm 644` — con permessi specifici
- `-exec comando {} \;` — esegue comando su ogni risultato

**Esempi:**
```bash
# Trova tutti i file .txt nella home
find ~ -name "*.txt"

# Trova directory chiamate "config"
find / -type d -name config 2>/dev/null

# Trova file modificati nelle ultime 24 ore
find /var/log -type f -mtime -1

# Trova file più grandi di 100MB
find / -type f -size +100M 2>/dev/null

# Trova e cancella file .tmp
find /tmp -name "*.tmp" -type f -delete

# Trova file con permessi 777 (pericoloso!)
find / -type f -perm 0777 2>/dev/null

# Esegui comando su ogni file trovato
find ~/documents -name "*.pdf" -exec ls -lh {} \;
```

### locate — ricerca veloce nel database dei file

**Nota:** più veloce di `find` ma usa un database che va aggiornato.

```bash
# Installa se necessario
sudo apt install mlocate  # Debian/Ubuntu
sudo dnf install mlocate  # RHEL/Fedora

# Aggiorna database
sudo updatedb

# Cerca file
locate filename.txt
locate -i pattern  # case-insensitive
locate "*.conf" | grep nginx
```

### Altri comandi utili per elaborare testo

1. **head** — mostra prime righe
   ```bash
   head -n 10 file.txt
   head -20 /var/log/syslog
   ```

2. **tail** — mostra ultime righe
   ```bash
   tail -n 10 file.txt
   tail -f /var/log/syslog  # segue il file in tempo reale
   ```

3. **less** — visualizzatore paginato
   ```bash
   less file.txt
   # Tasti utili: Space (pagina successiva), b (pagina precedente), 
   # / (cerca), q (esci)
   ```

4. **wc** — conta righe/parole/caratteri
   ```bash
   wc -l file.txt      # conta righe
   wc -w file.txt      # conta parole
   wc -c file.txt      # conta byte
   ```

5. **sort** — ordina righe
   ```bash
   sort file.txt
   sort -r file.txt    # ordine inverso
   sort -n file.txt    # ordine numerico
   ```

6. **uniq** — rimuove duplicati (richiede input ordinato)
   ```bash
   sort file.txt | uniq
   sort file.txt | uniq -c  # conta occorrenze
   ```

7. **cut** — estrae colonne
   ```bash
   cut -d: -f1 /etc/passwd     # primo campo separato da :
   cut -c1-10 file.txt         # primi 10 caratteri
   ```

8. **tr** — traduce/sostituisce caratteri
   ```bash
   echo "hello" | tr 'a-z' 'A-Z'  # maiuscolo
   cat file.txt | tr -d ' '        # rimuove spazi
   ```

9. **xargs** — costruisce ed esegue comandi da input
   ```bash
   find . -name "*.txt" | xargs grep "pattern"
   ls *.txt | xargs rm
   ```

## Esercizi pratici step-by-step

### Esercizio 1: Redirezioni base

```bash
# Crea directory di lavoro
mkdir -p ~/lab2/logs
cd ~/lab2

# Crea file di log simulati
echo "2024-01-15 10:30 INFO Application started" > logs/app.log
echo "2024-01-15 10:31 DEBUG Loading configuration" >> logs/app.log
echo "2024-01-15 10:32 ERROR Failed to connect to database" >> logs/app.log
echo "2024-01-15 10:33 WARNING Retrying connection" >> logs/app.log
echo "2024-01-15 10:34 INFO Connection established" >> logs/app.log
echo "2024-01-15 10:35 ERROR Permission denied on /etc/config" >> logs/app.log

# Visualizza il file
cat logs/app.log

# Redirige output in un nuovo file
grep "ERROR" logs/app.log > errors_only.txt
cat errors_only.txt

# Appende al file esistente
grep "WARNING" logs/app.log >> errors_only.txt
cat errors_only.txt
```

### Esercizio 2: Pipe e concatenazione comandi

```bash
# Conta quante righe contengono "ERROR"
grep "ERROR" logs/app.log | wc -l

# Estrai solo l'orario degli errori
grep "ERROR" logs/app.log | cut -d' ' -f2

# Ordina e conta messaggi unici
cat logs/app.log | cut -d' ' -f4- | sort | uniq -c

# Pipeline complessa: trova, ordina, conta
cat logs/app.log | grep -v "DEBUG" | cut -d' ' -f3 | sort | uniq -c | sort -nr
```

### Esercizio 3: Ricerca con find

```bash
# Crea struttura file per test
mkdir -p ~/lab2/project/{src,docs,config}
touch ~/lab2/project/src/main.py
touch ~/lab2/project/src/utils.py
touch ~/lab2/project/docs/README.md
touch ~/lab2/project/config/settings.ini
touch ~/lab2/project/config/database.conf

# Trova tutti i file .py
find ~/lab2/project -name "*.py"

# Trova file modificati oggi
find ~/lab2/project -type f -mtime 0

# Trova e mostra dettagli
find ~/lab2/project -type f -exec ls -lh {} \;

# Trova file e cerca contenuto
find ~/lab2/project -name "*.py" -exec grep -H "import" {} \;
```

### Esercizio 4: Analisi log complessa

```bash
# Crea log più complesso
cat > ~/lab2/access.log << 'EOF'
192.168.1.100 GET /index.html 200
192.168.1.101 GET /about.html 200
192.168.1.100 POST /login 401
192.168.1.102 GET /api/data 200
192.168.1.100 POST /login 200
192.168.1.103 GET /admin 403
192.168.1.101 GET /index.html 200
192.168.1.104 GET /api/data 500
EOF

# Trova tutti gli errori (status 4xx e 5xx)
grep -E " [45][0-9]{2}$" access.log

# Conta accessi per IP
cut -d' ' -f1 access.log | sort | uniq -c | sort -nr

# Trova gli endpoint più richiesti
cut -d' ' -f2,3 access.log | sort | uniq -c | sort -nr

# Salva analisi in file
echo "=== Errori ===" > report.txt
grep -E " [45][0-9]{2}$" access.log >> report.txt
echo -e "\n=== Top IP ===" >> report.txt
cut -d' ' -f1 access.log | sort | uniq -c | sort -nr | head -3 >> report.txt

cat report.txt
```

### Esercizio 5: Combinare grep, find e xargs

```bash
# Crea file di codice simulati
echo "import os" > ~/lab2/project/src/main.py
echo "import sys" >> ~/lab2/project/src/main.py
echo "from utils import helper" >> ~/lab2/project/src/main.py

echo "def helper():" > ~/lab2/project/src/utils.py
echo "    import json" >> ~/lab2/project/src/utils.py
echo "    return True" >> ~/lab2/project/src/utils.py

# Cerca "import" in tutti i file .py
find ~/lab2/project -name "*.py" -exec grep -H "import" {} \;

# Alternativa con xargs
find ~/lab2/project -name "*.py" | xargs grep "import"

# Conta quanti file contengono "import"
find ~/lab2/project -name "*.py" | xargs grep -l "import" | wc -l
```

## Esercizio pratico finale: Troubleshooting log

```bash
# Scenario: analizza log di sistema
# Crea log simulato
mkdir -p ~/lab2/system
cat > ~/lab2/system/syslog << 'EOF'
Jan 15 10:00:01 server systemd: Started Session 1.
Jan 15 10:00:05 server sshd: Failed password for invalid user admin
Jan 15 10:00:10 server kernel: Out of memory: Kill process 1234
Jan 15 10:00:15 server systemd: Started Session 2.
Jan 15 10:00:20 server sshd: Accepted publickey for user alice
Jan 15 10:00:25 server apache2: Segmentation fault
Jan 15 10:00:30 server systemd: Started Session 3.
Jan 15 10:00:35 server sshd: Failed password for invalid user root
Jan 15 10:00:40 server mysqld: Connection refused
EOF

# Task 1: Trova tutti gli errori SSH
grep "sshd.*Failed" ~/lab2/system/syslog

# Task 2: Conta tentativi di login falliti
grep "Failed password" ~/lab2/system/syslog | wc -l

# Task 3: Identifica problemi critici (kernel, segfault)
grep -E "kernel|Segmentation" ~/lab2/system/syslog

# Task 4: Genera report
{
    echo "=== System Log Analysis ==="
    echo "Date: $(date)"
    echo ""
    echo "Failed SSH attempts:"
    grep -c "Failed password" ~/lab2/system/syslog
    echo ""
    echo "Critical errors:"
    grep -E "kernel|Segmentation" ~/lab2/system/syslog
} > ~/lab2/system/report.txt

cat ~/lab2/system/report.txt
```

## Pattern comuni e best practices

### 1. Combinazione grep + tail per monitoraggio
```bash
tail -f /var/log/syslog | grep "error"
```

### 2. Ricerca case-insensitive
```bash
grep -i "pattern" file.txt
```

### 3. Escludere directory da find
```bash
find / -path /proc -prune -o -name "*.conf" -print 2>/dev/null
```

### 4. Contare file in una directory
```bash
find /var/log -type f | wc -l
```

### 5. Cercare in file compressi
```bash
zgrep "pattern" /var/log/syslog.1.gz
```

## Domande frequenti e trappole comuni

1. **`>`** sovrascrive il file — usa **`>>`** per appendere
2. **grep** è case-sensitive di default — usa `-i` per ignorare
3. **find** può produrre molti errori "Permission denied" — redirigili con `2>/dev/null`
4. **pipe** passa solo stdout — stderr va a schermo a meno che non lo redirigi
5. **xargs** è utile quando un comando non accetta input da pipe
6. **locate** è veloce ma il database va aggiornato con `updatedb`

## Checklist comandi da memorizzare

- **Redirezione**: `>`, `>>`, `<`, `2>`, `&>`, `|`
- **Ricerca testo**: `grep`, `grep -r`, `grep -i`, `grep -v`
- **Ricerca file**: `find`, `locate`
- **Elaborazione**: `head`, `tail`, `less`, `wc`, `sort`, `uniq`, `cut`, `tr`
- **Concatenazione**: `xargs`
- **Opzioni grep**: `-i`, `-r`, `-n`, `-v`, `-c`, `-l`, `-A`, `-B`, `-C`
- **Opzioni find**: `-name`, `-type`, `-size`, `-mtime`, `-exec`

## Tempo suggerito

- 15–20 minuti: leggere la guida
- 60–90 minuti: eseguire gli esercizi pratici
- 20–30 minuti: creare cheat-sheet personale con i comandi più utili

## Risorse aggiuntive

- `man grep`, `man find`, `man xargs`
- Libro: "The Linux Command Line" — cap. 6-7
- Regex101.com per testare espressioni regolari
- Esercizi: grep/find challenges su Exercism o HackerRank
