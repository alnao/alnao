# Settimana 6 — Gestione Pacchetti (LFCA)

**Tempo stimato**: 6-8 ore  
**Obiettivo**: Comprendere e gestire pacchetti software in distribuzioni Debian/Ubuntu (apt/dpkg) e Red Hat/CentOS/Fedora (dnf/yum/rpm)

---

## Introduzione

La gestione dei pacchetti è fondamentale in Linux. I package manager permettono di installare, aggiornare e rimuovere software in modo sicuro, gestendo automaticamente le dipendenze.

### Concetti chiave

- **Repository**: server che contengono pacchetti software
- **Dipendenze**: pacchetti richiesti da altri pacchetti
- **Package manager**: strumento per gestire i pacchetti
  - Alto livello: apt, dnf (gestiscono dipendenze automaticamente)
  - Basso livello: dpkg, rpm (operazioni dirette sui pacchetti)

---

## apt/dpkg (Debian/Ubuntu)

### Aggiornamento sistema

```bash
# Aggiorna lista pacchetti dai repository
sudo apt update

# Aggiorna tutti i pacchetti installati
sudo apt upgrade

# Aggiorna con rimozione pacchetti obsoleti se necessario
sudo apt full-upgrade

# Alternativa più vecchia (ancora funzionante)
sudo apt-get update
sudo apt-get upgrade
```

**Nota**: Esegui sempre `apt update` prima di installare pacchetti per avere l'elenco aggiornato.

### Installazione pacchetti

```bash
# Installa un pacchetto
sudo apt install nginx

# Installa più pacchetti
sudo apt install nginx mysql-server php

# Installa versione specifica
sudo apt install nginx=1.18.0-0ubuntu1

# Simula installazione (dry-run)
sudo apt install --dry-run nginx

# Reinstalla pacchetto
sudo apt install --reinstall nginx
```

### Rimozione pacchetti

```bash
# Rimuovi pacchetto (mantiene file di configurazione)
sudo apt remove nginx

# Rimuovi pacchetto e file di configurazione
sudo apt purge nginx

# Rimuovi pacchetti non più necessari (dipendenze orfane)
sudo apt autoremove

# Rimuovi pacchetto con dipendenze non utilizzate
sudo apt autoremove nginx
```

### Ricerca pacchetti

```bash
# Cerca pacchetto per nome o descrizione
apt search nginx

# Cerca con apt-cache (più veloce)
apt-cache search nginx

# Cerca solo nei nomi dei pacchetti
apt-cache search --names-only nginx

# Cerca pacchetti con regex
apt-cache search "^nginx"
```

### Informazioni sui pacchetti

```bash
# Mostra informazioni dettagliate
apt show nginx

# Con apt-cache
apt-cache show nginx

# Mostra tutte le versioni disponibili
apt-cache policy nginx

# Mostra dipendenze
apt-cache depends nginx

# Mostra dipendenze inverse (chi dipende da questo)
apt-cache rdepends nginx
```

### Lista pacchetti

```bash
# Lista tutti i pacchetti installati
apt list --installed

# Lista pacchetti aggiornabili
apt list --upgradable

# Lista tutti i pacchetti disponibili
apt list

# Con dpkg (più veloce)
dpkg -l

# Lista formattata
dpkg -l | grep nginx
```

### Gestione cache

```bash
# Pulisci cache pacchetti scaricati
sudo apt clean

# Pulisci solo pacchetti obsoleti
sudo apt autoclean

# Verifica spazio occupato
du -sh /var/cache/apt/archives/
```

### dpkg - Operazioni di basso livello

```bash
# Installa pacchetto .deb locale
sudo dpkg -i package.deb

# Rimuovi pacchetto
sudo dpkg -r package

# Rimuovi con configurazioni
sudo dpkg -P package

# Lista file installati da un pacchetto
dpkg -L nginx

# Trova quale pacchetto ha installato un file
dpkg -S /usr/bin/nginx

# Mostra stato pacchetto
dpkg -s nginx

# Lista tutti i pacchetti
dpkg -l

# Riconfigura pacchetto
sudo dpkg-reconfigure package

# Fix dipendenze rotte
sudo apt install -f
```

### File di configurazione

```bash
# Repository in /etc/apt/sources.list
cat /etc/apt/sources.list

# Repository aggiuntivi in /etc/apt/sources.list.d/
ls /etc/apt/sources.list.d/

# Aggiungi repository (esempio)
sudo add-apt-repository ppa:user/repository
sudo apt update

# Rimuovi repository
sudo add-apt-repository --remove ppa:user/repository
```

---

## dnf/yum e rpm (RHEL/CentOS/Fedora)

### Aggiornamento sistema

```bash
# Verifica aggiornamenti disponibili (dnf)
dnf check-update

# Aggiorna tutti i pacchetti (dnf)
sudo dnf update

# Aggiorna tutto (yum - sistemi più vecchi)
sudo yum update

# Aggiorna solo pacchetto specifico
sudo dnf update nginx
```

### Installazione pacchetti

```bash
# Installa pacchetto
sudo dnf install nginx

# Installa più pacchetti
sudo dnf install nginx mysql php

# Installa file .rpm locale
sudo dnf install ./package.rpm

# Reinstalla
sudo dnf reinstall nginx

# Downgrade a versione precedente
sudo dnf downgrade nginx
```

### Rimozione pacchetti

```bash
# Rimuovi pacchetto
sudo dnf remove nginx

# Rimuovi con dipendenze non utilizzate
sudo dnf autoremove nginx

# Rimuovi pacchetti orfani
sudo dnf autoremove
```

### Ricerca pacchetti

```bash
# Cerca pacchetto
dnf search nginx

# Cerca solo nei nomi
dnf search --names nginx

# Cerca nei metadati
dnf search all nginx
```

### Informazioni sui pacchetti

```bash
# Mostra informazioni pacchetto
dnf info nginx

# Mostra dipendenze
dnf repoquery --requires nginx

# Mostra chi dipende da questo pacchetto
dnf repoquery --whatrequires nginx

# Trova quale pacchetto fornisce un file
dnf provides /usr/bin/nginx
```

### Lista pacchetti

```bash
# Lista pacchetti installati
dnf list installed

# Lista tutti i pacchetti disponibili
dnf list available

# Lista aggiornamenti
dnf list updates

# Con rpm
rpm -qa

# Cerca nei pacchetti installati
rpm -qa | grep nginx
```

### Gestione gruppi

```bash
# Lista gruppi disponibili
dnf grouplist

# Mostra info gruppo
dnf groupinfo "Development Tools"

# Installa gruppo
sudo dnf groupinstall "Development Tools"

# Rimuovi gruppo
sudo dnf groupremove "Development Tools"
```

### rpm - Operazioni di basso livello

```bash
# Installa pacchetto .rpm
sudo rpm -ivh package.rpm

# Aggiorna pacchetto
sudo rpm -Uvh package.rpm

# Rimuovi pacchetto
sudo rpm -e package

# Lista tutti i pacchetti
rpm -qa

# Verifica se pacchetto è installato
rpm -q nginx

# Mostra info pacchetto installato
rpm -qi nginx

# Lista file di un pacchetto
rpm -ql nginx

# Trova quale pacchetto contiene un file
rpm -qf /usr/bin/nginx

# Verifica integrità pacchetto
rpm -V nginx

# Importa chiave GPG
sudo rpm --import RPM-GPG-KEY
```

### Repository

```bash
# Lista repository abilitati
dnf repolist

# Lista tutti i repository
dnf repolist all

# Abilita repository
sudo dnf config-manager --enable repository-name

# Disabilita repository
sudo dnf config-manager --disable repository-name

# Aggiungi repository
sudo dnf config-manager --add-repo https://example.com/repo

# File configurazione in /etc/yum.repos.d/
ls /etc/yum.repos.d/
```

### Gestione cache

```bash
# Pulisci cache
sudo dnf clean all

# Pulisci solo metadata
sudo dnf clean metadata

# Crea cache
sudo dnf makecache
```

---

## Confronto apt vs dnf

| Operazione | Debian/Ubuntu (apt) | RHEL/Fedora (dnf) |
|------------|---------------------|-------------------|
| Aggiorna lista | `apt update` | `dnf check-update` |
| Aggiorna sistema | `apt upgrade` | `dnf update` |
| Installa | `apt install pkg` | `dnf install pkg` |
| Rimuovi | `apt remove pkg` | `dnf remove pkg` |
| Cerca | `apt search pkg` | `dnf search pkg` |
| Info | `apt show pkg` | `dnf info pkg` |
| Lista installati | `apt list --installed` | `dnf list installed` |
| Pulisci cache | `apt clean` | `dnf clean all` |
| Rimuovi orfani | `apt autoremove` | `dnf autoremove` |

---

## Esercizi pratici

### Esercizio 1: Installazione base

```bash
# Su Debian/Ubuntu:
sudo apt update
sudo apt install nginx -y
systemctl status nginx
sudo apt remove nginx
sudo apt purge nginx
sudo apt autoremove

# Su RHEL/Fedora:
sudo dnf check-update
sudo dnf install nginx -y
systemctl status nginx
sudo dnf remove nginx
sudo dnf autoremove
```

### Esercizio 2: Ricerca pacchetti

```bash
# Cerca pacchetti Python
apt search python3 | grep -i flask
# oppure
dnf search python3 | grep -i flask

# Mostra informazioni
apt show python3-flask
# oppure
dnf info python3-flask

# Verifica versioni disponibili
apt-cache policy python3-flask
# oppure
dnf list python3-flask --showduplicates
```

### Esercizio 3: Gestione dipendenze

```bash
# Installa pacchetto e osserva dipendenze
sudo apt install nginx
# o
sudo dnf install nginx

# Verifica dipendenze (Debian)
apt-cache depends nginx

# Verifica dipendenze (RHEL)
dnf repoquery --requires nginx

# Trova chi dipende da nginx
apt-cache rdepends nginx
# o
dnf repoquery --whatrequires nginx
```

### Esercizio 4: File da pacchetti

```bash
# Lista file installati da nginx (Debian)
dpkg -L nginx | head -20

# Lista file installati da nginx (RHEL)
rpm -ql nginx | head -20

# Trova quale pacchetto ha installato un file
dpkg -S /usr/sbin/nginx
# o
rpm -qf /usr/sbin/nginx
```

### Esercizio 5: Aggiornamento sistema completo

```bash
# Debian/Ubuntu
sudo apt update
sudo apt list --upgradable
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt clean

# RHEL/Fedora
sudo dnf check-update
sudo dnf list updates
sudo dnf update -y
sudo dnf autoremove -y
sudo dnf clean all
```

### Esercizio 6: Pacchetti locali

```bash
# Scarica pacchetto senza installare (Debian)
apt download curl

# Installa pacchetto locale
sudo dpkg -i curl*.deb
sudo apt install -f  # fix dipendenze se necessario

# Su RHEL
dnf download curl
sudo rpm -ivh curl*.rpm
```

---

## Troubleshooting comune

### Problema: Dipendenze rotte (Debian)

```bash
# Fix automatico
sudo apt install -f

# O con dpkg
sudo dpkg --configure -a
sudo apt install -f
```

### Problema: Lock file occupato

```bash
# Errore: "Could not get lock /var/lib/apt/lists/lock"

# Verifica processi apt/dpkg
ps aux | grep -i apt
ps aux | grep -i dpkg

# Se non ci sono processi, rimuovi lock
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*

# Riconfigura
sudo dpkg --configure -a
```

### Problema: Repository non raggiungibile

```bash
# Verifica connessione
ping archive.ubuntu.com

# Cambia server mirror
sudo nano /etc/apt/sources.list
# Modifica URL repository

sudo apt update
```

### Problema: Versione pacchetto non trovata

```bash
# Verifica versioni disponibili
apt-cache policy package-name

# Se non disponibile, aggiungi repository o usa backports
```

---

## Comandi da memorizzare

```bash
# === APT (Debian/Ubuntu) ===
sudo apt update              # Aggiorna lista
sudo apt upgrade             # Aggiorna pacchetti
sudo apt install pkg         # Installa
sudo apt remove pkg          # Rimuovi
sudo apt purge pkg           # Rimuovi + config
sudo apt autoremove          # Rimuovi orfani
apt search pkg               # Cerca
apt show pkg                 # Info
apt list --installed         # Lista installati
dpkg -L pkg                  # File da pacchetto
dpkg -S /path/file          # Trova pacchetto da file

# === DNF/YUM (RHEL/Fedora) ===
sudo dnf update              # Aggiorna
sudo dnf install pkg         # Installa
sudo dnf remove pkg          # Rimuovi
sudo dnf autoremove          # Rimuovi orfani
dnf search pkg               # Cerca
dnf info pkg                 # Info
dnf list installed           # Lista installati
rpm -ql pkg                  # File da pacchetto
rpm -qf /path/file          # Trova pacchetto da file
```

---

## Checklist settimana 6

- [ ] Ho capito la differenza tra apt e dpkg
- [ ] So aggiornare il sistema con apt/dnf
- [ ] So installare e rimuovere pacchetti
- [ ] So cercare pacchetti nei repository
- [ ] So visualizzare informazioni sui pacchetti
- [ ] So gestire le dipendenze
- [ ] So usare dpkg per operazioni di basso livello
- [ ] So usare rpm su sistemi RHEL
- [ ] So pulire la cache dei pacchetti
- [ ] Ho fatto tutti gli esercizi pratici

---

## Risorse aggiuntive

- Man pages: `man apt`, `man dpkg`, `man dnf`, `man rpm`
- Debian Package Management: https://www.debian.org/doc/manuals/debian-reference/ch02.en.html
- DNF Command Reference: https://dnf.readthedocs.io/
- Ubuntu Package Management: https://ubuntu.com/server/docs/package-management

**Prossima settimana**: Storage & Backup (tar, rsync, filesystem)
