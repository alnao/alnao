# Piano di Studio LFCA (Linux Foundation Certified IT Associate)

Piano di studio di 10 settimane mirato alla certificazione LFCA (Linux Foundation Certified IT Associate). Pensato per uno studio part-time; adattalo alle tue ore disponibili. 

## Preparazione Iniziale

- Impegno suggerito: 6–10 ore/settimana
- Ambiente di pratica: VirtualBox/VMware + almeno una VM Linux (consiglio Ubuntu LTS). Usare anche una distro RHEL-like (Alma/Rocky) è utile ma non obbligatorio
- Strumenti utili: terminale, editor (vim/nano), curl/wget, ssh, rsync, tar
- Risorse consigliate: 
  - Corso introduttivo Linux Foundation/edX
  - "The Linux Command Line" (Shotts)
  - Katacoda / Play with Linux per esercizi interattivi

## Piano Settimanale (Obiettivo e Attività Pratiche)

- Settimana 1 — Fondamenta & Ambiente
    - Obiettivo: conoscere terminale e struttura del filesystem
    - Studia: struttura `/`, `/etc`, `/var`, `/home`, permessi base
    - Pratica: comandi base (`ls`, `cd`, `pwd`, `cp`, `mv`, `rm`, `mkdir`, `stat`)
    - Esercizio: crea gerarchia di cartelle e file, prova `cp`/`mv`/permessi
- Settimana 2 — I/O, Redirezioni e Ricerca Testi
    - Obiettivo: padroneggiare redirezioni, pipe e ricerca testo/file
    - Studia: `>`, `>>`, `|`, `grep`, `find`, `locate`, `xargs`, `head`/`tail`, `less`
    - Esercizio: estrai righe da log, cerca file per estensione e per contenuto
- Settimana 3 — Utenti, Gruppi e Autenticazione
    - Obiettivo: gestione utenti e concetti sudo
    - Studia: `useradd`/`usermod`/`userdel`, `/etc/passwd`, `/etc/group`, `sudoers` (`visudo`)
    - Pratica: crea utenti, imposta password, configura sudo per un utente
- Settimana 4 — Processi, Servizi e Logging
    - Obiettivo: capire processi e systemd
    - Studia: `ps`/`top`, `nice`/`kill`, `systemctl` (`start`/`stop`/`enable`/`status`), `journalctl`, `/var/log`
    - Esercizio: creare un servizio systemd minimo, leggere log con `journalctl`
- Settimana 5 — Networking Base
    - Obiettivo: concetti IP/DNS e diagnostica rete
    - Studia: `ip addr`/`route`, `ss`, `ping`, `traceroute`, `/etc/hosts`, `resolv.conf`, `dig`/`nslookup`, `curl`
    - Esercizio: impostare IP statico sulla VM, risolvere un problema DNS locale
- Settimana 6 — Gestione Pacchetti
    - Obiettivo: installare e aggiornare software
    - Studia: `apt`/`dpkg` (Debian/Ubuntu) e `dnf`/`rpm` (RHEL-like) concetti base
    - Pratica: installa nginx, disinstallalo, aggiorna il sistema, verifica versioni
- Settimana 7 — Storage & Backup
    - Obiettivo: gestione file system e backup semplici
    - Studia: `df`/`du`, `mount`/`umount`, `/etc/fstab`, `tar`, `gzip`, `rsync`, concetti base LVM (solo concetti se poco tempo)
    - Esercizio: crea archivio tar, sincronizza cartella con rsync, aggiungi mount in fstab
- Settimana 8 — Sicurezza di Base
    - Obiettivo: SSH, permessi avanzati e firewall semplice
    - Studia: `ssh-keygen`/`ssh-copy-id`, configurazione sshd, `chmod`/`chown`, ACLs (`getfacl`/`setfacl`), `ufw`/`firewalld` concetti base
    - Esercizio: disabilita accesso password via SSH e abilita accesso con chiave
- Settimana 9 — Automazione Minima & Concetti Cloud/Container
    - Obiettivo: scripting semplice e automatizzazione
    - Studia: bash basics (variabili, argomenti, exit codes), `crontab`, concetti Docker/Kubernetes/VM in modo introduttivo
    - Esercizio: script che esegue backup giornaliero e registra log; schedula con cron
- Settimana 10 — Ripasso, Mock Test e Preparazione Esame
    - Obiettivo: consolidare e simulare l'esame
    - Attività: riepilogo checklist, 2–3 serie di quiz/mocks (tempo reale), rivedi errori
    - Prepara check-list esame: webcam/mic, ID, ambiente pulito, orari

## Esercizi Pratici Consigliati (da ripetere)
1. Configura un utente con accesso ssh key-only
2. Trova e correggi un file con permessi errati impedendo l'avvio di un servizio (simula troubleshooting)
3. Installa web server e verifica con curl dalla rete locale
4. Crea script di backup + rotazione e ripristino di un file


## Checklist Rapida di Comandi/Concetti da Saper Usare
- File & Shell
    - `ls`, `cd`, `cp`, `mv`, `rm`, `mkdir`, `cat`, `less`
- Ricerca/Testo
    - `grep`, `find`, `head`/`tail`, `awk` (basi)
- Utenti/Permessi
    - `useradd`, `passwd`, `chmod`, `chown`, `getfacl`
- Processi/Servizi
    - `ps`, `top`, `systemctl`, `journalctl`
- Rete
    - `ip`, `ss`, `ping`, `traceroute`, `dig`, `curl`
- Pacchetti
    - `apt`/`dnf`/`rpm`, `dpkg`, `rpm`
- Backup/Storage
    - `tar`, `rsync`, `mount`, `/etc/fstab`
- Scripting
    - bash basics, `crontab`
- Sicurezza
    `ssh-keygen`, firewall con `ufw`/`firewalld`

## Risorse Pratiche
- Corso introduttivo: Linux Foundation / edX "Introduction to Linux"
- Libro: "The Linux Command Line" (William Shotts)
- Piattaforme interattive: Katacoda / Play with Linux per scenari interattivi
- Ripasso: Quiz e flashcard (Anki) per ripasso veloce

## Consigli Finali per l'Esame
1. Pratica molto la CLI: scorrere manualmente le pagine man rallenta, meglio ricordare i comandi principali
2. Simula condizioni d'esame: timer, niente internet se non consentito dalle regole
3. Gestisci il tempo: se una domanda blocca, passa alla successiva e torna dopo
4. Riposa bene la sera prima e verifica microfono/webcam
