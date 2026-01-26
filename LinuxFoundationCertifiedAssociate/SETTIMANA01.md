# Settimana 1 — Fondamenta & ambiente (LFCA)
Tempo stimato per completare questa sessione: 2–3 ore (più se ripeti molto gli esercizi)

Questa guida è pensata per la prima settimana del piano LFCA: imparare a usare il terminale e conoscere la struttura del filesystem sono le basi essenziali. 

## Introduzione
Imparare a usare la shell e conoscere la struttura delle directory principali (/, /etc, /var, /home) è fondamentale per lavorare su Linux. In questa lezione vedremo come muoversi nella shell, come leggere la struttura delle directory principali e come usare i comandi di manipolazione file essenziali: `ls`, `cd`, `pwd`, `cp`, `mv`, `rm`, `mkdir`, `stat`. Alla fine creerai una gerarchia di directory, copierai e sposterai file e praticherai i permessi.


## Prima di iniziare — ambiente consigliato
- Lavora su una VM (VirtualBox/VMware) con una distribuzione comune (consiglio Ubuntu LTS).  
- Su Windows puoi usare WSL o una VM.
- Apri una shell/terminale.
- Prepara una directory per i laboratori: ad esempio `~/lab1`.
- Strumenti utili: `vim`/`nano`, `curl`/`wget`, `ssh`, `rsync`, `tar`.

## Concetti base della shell
- Prompt: la riga che vedi (es. `utente@host:~$`). Qui scrivi i comandi.
- Sintassi: `comando [opzioni] [argomenti]`
- Percorsi:
  - Assoluti: iniziano con `/` (es. `/etc/hosts`)
  - Relativi: rispetto alla directory corrente (es. `../file`, `./script`)
  - `~` indica la tua home (es. `~/lab1`)
- Tab completion: premi TAB per completare nomi di file/directory.
- Storico: usa le frecce ↑/↓ per scorrere i comandi precedenti.

## Struttura principale del filesystem (cenni utili)
- `/` (root): radice del sistema; tutto parte da qui.
- `/etc`: file di configurazione del sistema (es. `/etc/passwd`, `/etc/hosts`, `/etc/fstab`, `/etc/ssh/sshd_config`).
- `/var`: dati variabili e log (es. `/var/log`, `/var/spool`, `/var/lib`, `/var/www`).
- `/home`: directory home degli utenti (es. `/home/utente`).
- Altre directory importanti (breve):
  - `/bin`, `/sbin`, `/usr`, `/boot`, `/tmp`, `/dev`, `/proc`.

## Permessi Unix — concetti essenziali
- Ogni file/dir ha tre insiemi di permessi: owner (u), group (g), others (o).
- Tipi di permesso: `r` (read), `w` (write), `x` (execute). Per directory, `x` permette di entrare/listare.
- Visualizzazione con `ls -l`:
  - Esempio: `-rw-r--r-- 1 alice staff 1234 Jul 10 file.txt`
  - Significato: owner ha rw, group r, others r.
- Notazione numerica (octal): `r=4`, `w=2`, `x=1`.
  - `644` → owner rw (6), group r (4), others r (4)
  - `750` → owner rwx (7), group r-x (5), others none (0)
- Comandi principali:
  - `chmod` per cambiare permessi (es. `chmod 644 file.txt` o `chmod u+x script.sh`)
  - `chown` per cambiare proprietario (es. `sudo chown utente:staff file.txt`)
  - `getfacl` / `setfacl` per ACL avanzate (se supportate)
- Nota: modificare file in `/etc` o `/root` richiede privilegi di root (`sudo`).


## Comandi base — spiegazione e esempi
1. `ls` — lista file  
   - `ls` — elenco semplice  
   - `ls -l` — elenco dettagliato (permessi, owner, size, date)  
   - `ls -la` — mostra anche i file nascosti
2. `cd` — cambia directory  
   - `cd /etc`  
   - `cd ~` o `cd` — vai in home  
   - `cd -` — torna alla directory precedente
3. `pwd` — stampa la working directory  
   - `pwd`
4. `cp` — copia file/directory  
   - `cp file1.txt file2.txt`  
   - `cp -r dir1 dir2` — copia ricorsiva directory
5. `mv` — sposta o rinomina  
   - `mv file.txt /tmp/`  
   - `mv oldname newname`
6. `rm` — rimuovi file/directory  
   - `rm file.txt`  
   - `rm -r dir/` — cancella directory ricorsivamente  
   - Attenzione: `rm -rf` è distruttivo
7. `mkdir` — crea directory  
   - `mkdir mydir`  
   - `mkdir -p parent/child` — crea anche i genitori se mancanti
8. `stat` — informazioni dettagliate su file  
   - `stat file` — mostra inode, permessi numerici, owner, timestamps (Access, Modify, Change)
Comandi utili aggiuntivi:
- `cat`, `less`, `head`, `tail` — leggere file
- `file nomefile` — determina il tipo di file
- `touch nomefile` — crea file vuoto o aggiorna timestamp
- `wc -l` — conta righe
- `tree` (se disponibile) — mostra struttura ad albero (`ls -R` come alternativa)

## Esercizio pratico: crea gerarchia, gioca con cp/mv/permessi (step‑by‑step)
Esegui i comandi nella tua VM. Ogni blocco è autonomo.

1) Prepara ambiente lab
    ```bash
    mkdir -p ~/lab1/project/{config,logs,data}
    cd ~/lab1
    # Se 'tree' è installato:
    tree -a .
    # In alternativa:
    ls -R
    ```
2) Crea file di esempio
    ```bash
    touch project/config/app.conf
    echo "port=8080" > project/config/app.conf
    echo "Hello from /home" > project/data/welcome.txt
    ls -lR project
    ```
3) Usa cp e mv
    ```bash
    # Copia welcome.txt in config
    cp project/data/welcome.txt project/config/
    ls -l project/config

    # Rinomina il file
    mv project/config/welcome.txt project/config/greeting.txt
    cat project/config/greeting.txt
    ```
4) Prova i permessi
    ```bash
    # Controlla i permessi iniziali
    ls -l project/config/greeting.txt

    # Imposta permessi a 640 (rw per owner, r per group, nessuno per others)
    chmod 640 project/config/greeting.txt
    ls -l project/config/greeting.txt

    # Toglimi i permessi di lettura agli others (esempio con notazione simbolica)
    chmod o-r project/config/greeting.txt
    ls -l project/config/greeting.txt

    # Imposta owner e group (richiede sudo se cambi owner ad altro utente)
    sudo chown $USER:$USER project/config/greeting.txt
    ls -l project/config/greeting.txt
    ```
5) Usa `stat` per informazioni avanzate
    ```bash
    stat project/config/greeting.txt
    # Nota i timestamp: Access, Modify, Change (mtime = modifica contenuto, ctime = modifica metadata)
    ```
6) Simula un problema (troubleshooting base)
    ```bash
    # Rendi il file illeggibile
    chmod 000 project/config/greeting.txt

    # Prova a leggere (dovresti ottenere "Permission denied")
    cat project/config/greeting.txt

    # Ripara
    chmod 644 project/config/greeting.txt
    cat project/config/greeting.txt
    ```

7) Esercizio extra: crea un piccolo script di verifica
    ```bash
    # Crea lo script
    echo '#!/bin/bash' > ~/lab1/check.sh
    echo 'echo "Current dir: $(pwd)"' >> ~/lab1/check.sh
    echo 'ls -l' >> ~/lab1/check.sh

    # Rendi eseguibile e lancia
    chmod +x ~/lab1/check.sh
    ~/lab1/check.sh
    ```
    Scopo: esercitarti a rendere eseguibile e lanciare script semplici.


## Domande frequenti e trappole comuni
- Perché `cd ..` non funziona? Assicurati di digitare correttamente; `..` è la directory padre.
- Attenzione a `rm -rf /some/path` — non usarlo con privilegi di root se non sai esattamente cosa fai.
- `sudo` è necessario per operazioni su `/etc` o per cambiare owner di file non tuo.
- File nascosti (che iniziano con `.`) non appaiono con `ls` semplice — usa `ls -la`.
- `chmod` cambia i permessi, non il proprietario; per il proprietario usa `chown`.

## Checklist rapida da imparare a memoria
- Navigazione: `ls`, `cd`, `pwd`
- Visualizzazione: `cat`, `less`, `head`, `tail`
- File ops: `cp`, `mv`, `rm`, `mkdir`, `touch`
- Info file: `stat`, `file`, `wc -l`
- Permessi: `chmod`, `chown`, leggere `ls -l`
- Ricerca: `find`, `grep`
- Aiuto: `man comando` o `comando --help`

## Materiali di supporto e approfondimenti
- Libro: *The Linux Command Line* — William Shotts
- Corso: *Introduction to Linux* (Linux Foundation / edX)
- Esercizi interattivi: Katacoda, Play with Linux
- Ripassa su due distro (Ubuntu e una RHEL‑like) per vedere lievi differenze nei tool/path
- Nella sessione successiva copriremo redirezioni, pipe, `grep` e ricerca testi nei log.
