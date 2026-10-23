# Settimana 7 — Storage & Backup (LFCA)

**Tempo stimato**: 6-8 ore  
**Obiettivo**: Gestire filesystem, storage, mount points e strategie di backup con tar e rsync

---

## Introduzione

La gestione dello storage è cruciale per l'amministrazione di sistemi Linux. Comprende il monitoraggio dello spazio disco, la gestione dei mount points, e l'implementazione di strategie di backup efficaci.

### Concetti chiave

- **Filesystem**: struttura per organizzare dati sul disco (ext4, xfs, btrfs)
- **Mount**: processo di rendere un filesystem accessibile
- **Partition**: divisione logica di un disco
- **Backup**: copia di sicurezza dei dati

---

## Monitoraggio dello spazio disco

### df - Disk Free

```bash
# Mostra spazio disco in formato leggibile
df -h

# Output esempio:
# Filesystem      Size  Used Avail Use% Mounted on
# /dev/sda1        50G   20G   28G  42% /
# /dev/sdb1       100G   45G   50G  48% /data

# Mostra solo filesystem locali
df -hl

# Mostra inode invece di spazio
df -i

# Mostra tipo di filesystem
df -T

# Mostra filesystem specifico
df -h /home

# Esclude filesystem temporanei
df -h -x tmpfs -x devtmpfs
```

**Nota**: Se un filesystem raggiunge il 100%, il sistema può diventare instabile.

### du - Disk Usage

```bash
# Mostra dimensione directory
du -sh /var/log
# Output: 2.3G    /var/log

# Mostra sottodirectory primo livello
du -h --max-depth=1 /var

# Ordina per dimensione
du -h /var | sort -h

# Top 10 directory più grandi
du -h /var | sort -h | tail -10

# Esclude pattern
du -h --exclude="*.log" /var

# Mostra solo totale
du -s /var/log

# Con timestamp ultimo accesso
du -h --time /var/log
```

### Trova file grandi

```bash
# File più grandi di 100MB
find / -type f -size +100M 2>/dev/null

# File più grandi di 1GB con dettagli
find / -type f -size +1G -exec ls -lh {} \; 2>/dev/null

# Top 20 file più grandi
find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -20

# File non acceduti da 365 giorni
find /home -type f -atime +365
```

---

## Mount e filesystem

### Visualizza mount points

```bash
# Lista tutti i mount
mount

# Con formattazione più chiara
mount | column -t

# Solo filesystem specifici
mount | grep /dev/sd

# Con findmnt (più moderno)
findmnt

# Formato albero
findmnt --tree

# Solo un filesystem
findmnt /home
```

### lsblk - Lista block devices

```bash
# Mostra dispositivi a blocchi
lsblk

# Output esempio:
# NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
# sda      8:0    0  100G  0 disk
# ├─sda1   8:1    0   50G  0 part /
# └─sda2   8:2    0   50G  0 part /data

# Con filesystem type
lsblk -f

# Con UUID
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,UUID
```

### Mount manuale

```bash
# Crea mount point
sudo mkdir -p /mnt/usb

# Monta dispositivo
sudo mount /dev/sdb1 /mnt/usb

# Monta con opzioni specifiche
sudo mount -o ro /dev/sdb1 /mnt/usb  # read-only
sudo mount -o rw /dev/sdb1 /mnt/usb  # read-write

# Monta filesystem specifico
sudo mount -t ext4 /dev/sdb1 /mnt/usb

# Monta ISO
sudo mount -o loop image.iso /mnt/iso

# Smonta
sudo umount /mnt/usb

# Smonta forzato (sconsigliato)
sudo umount -f /mnt/usb

# Smonta lazy (quando possibile)
sudo umount -l /mnt/usb
```

### Verifica uso mount points

```bash
# Trova chi usa un mount point
lsof /mnt/usb

# O con fuser
fuser -m /mnt/usb

# Termina processi che usano mount point
sudo fuser -km /mnt/usb
```

---

## /etc/fstab - Mount automatico

Il file `/etc/fstab` definisce quali filesystem montare automaticamente all'avvio.

### Formato fstab

```
# <filesystem> <mount point> <type> <options> <dump> <pass>
UUID=xxx-xxx   /data         ext4   defaults  0      2
/dev/sdb1      /backup       ext4   defaults  0      2
```

**Campi**:
1. **filesystem**: dispositivo o UUID
2. **mount point**: dove montare
3. **type**: tipo filesystem (ext4, xfs, ntfs, vfat)
4. **options**: opzioni mount
5. **dump**: backup con dump (0=no, 1=sì)
6. **pass**: ordine fsck (0=skip, 1=root, 2=altri)

### Opzioni comuni

```
defaults    = rw, suid, dev, exec, auto, nouser, async
rw          = read-write
ro          = read-only
noexec      = non eseguire binari
nosuid      = ignora SUID/SGID bits
noauto      = non montare automaticamente
user        = utenti possono montare
nofail      = non bloccare boot se mount fallisce
```

### UUID vs /dev/sdX

Trova UUID dei dispositivi:

```bash
# Metodo 1: blkid
sudo blkid

# Output:
# /dev/sda1: UUID="a1b2c3d4-..." TYPE="ext4"

# Metodo 2: lsblk
lsblk -f

# Metodo 3: ls
ls -l /dev/disk/by-uuid/
```

**Perché usare UUID?**
- `/dev/sdX` può cambiare tra riavvii
- UUID è univoco e permanente
- Più affidabile per fstab

### Esempio configurazione fstab

```bash
# Edita fstab
sudo nano /etc/fstab

# Esempio entry:
UUID=a1b2c3d4-e5f6-7890  /data  ext4  defaults,nofail  0  2

# Per disco USB (non montare all'avvio)
UUID=xyz123  /mnt/usb  vfat  noauto,user,rw  0  0

# Per swap
UUID=swap-uuid  none  swap  sw  0  0

# Test configurazione (senza riavviare)
sudo mount -a

# Se errori, correggere fstab PRIMA di riavviare
```

⚠️ **ATTENZIONE**: Errori in fstab possono impedire il boot del sistema!

### Sicurezza fstab

```bash
# Backup prima di modificare
sudo cp /etc/fstab /etc/fstab.backup

# Test mount
sudo mount -a

# Se problemi al boot, usa recovery mode
# Edita fstab commentando righe problematiche con #
```

---

## tar - Archivi compressi

tar (Tape ARchive) è lo strumento standard per creare archivi di file.

### Creare archivi

```bash
# Crea archivio tar.gz (gzip)
tar -czf backup.tar.gz /home/user/documents

# Crea archivio tar.bz2 (bzip2 - più compresso)
tar -cjf backup.tar.bz2 /home/user/documents

# Crea archivio tar.xz (xz - massima compressione)
tar -cJf backup.tar.xz /home/user/documents

# Senza compressione
tar -cf backup.tar /home/user/documents

# Verbose (mostra file durante creazione)
tar -czvf backup.tar.gz /home/user/documents

# Con timestamp nel nome
tar -czf backup-$(date +%Y%m%d).tar.gz /home/user/documents
```

### Opzioni tar

```
c = create (crea)
x = extract (estrai)
t = list (elenca)
f = file (specifica nome file)
v = verbose (mostra dettagli)
z = gzip compression
j = bzip2 compression
J = xz compression
```

### Estrarre archivi

```bash
# Estrai tar.gz
tar -xzf backup.tar.gz

# Estrai in directory specifica
tar -xzf backup.tar.gz -C /tmp/restore

# Estrai solo un file
tar -xzf backup.tar.gz path/to/file.txt

# Estrai con pattern
tar -xzf backup.tar.gz --wildcards '*.pdf'

# Elenca contenuto senza estrarre
tar -tzf backup.tar.gz

# Estrai con verbose
tar -xzvf backup.tar.gz
```

### Append e update

```bash
# Aggiungi file ad archivio esistente (solo .tar)
tar -rf backup.tar newfile.txt

# Update (sostituisce se più nuovo)
tar -uf backup.tar file.txt

# Nota: append/update NON funzionano con archivi compressi
```

### Esclusioni

```bash
# Escludi directory
tar -czf backup.tar.gz --exclude=/home/user/downloads /home/user

# Escludi pattern
tar -czf backup.tar.gz --exclude='*.tmp' --exclude='*.log' /var

# Escludi da file
echo "*.tmp" > exclude.txt
echo "*.log" >> exclude.txt
tar -czf backup.tar.gz -X exclude.txt /var
```

### Backup incrementale

```bash
# Backup completo con snapshot
tar -czf full-backup.tar.gz -g snapshot.snar /home/user

# Backup incrementale (solo file modificati)
tar -czf incremental-backup.tar.gz -g snapshot.snar /home/user

# Restore completo + incrementale
tar -xzf full-backup.tar.gz -g /dev/null
tar -xzf incremental-backup.tar.gz -g /dev/null
```

---

## rsync - Sincronizzazione file

rsync è potente per backup e sincronizzazione, trasferisce solo le differenze.

### Sintassi base

```bash
# Copia locale
rsync -av /source/ /destination/

# Nota: trailing slash (/) conta!
# /source/  = contenuto di source
# /source   = directory source stessa
```

### Opzioni principali

```
-a  = archive (mantiene permessi, timestamp, link)
-v  = verbose
-r  = recursive
-h  = human-readable
-z  = compress durante trasferimento
-P  = progress + partial (riprendi download interrotti)
--delete = cancella in dest se non in source
--dry-run = simula senza modificare
```

### Backup locale

```bash
# Backup directory
rsync -av /home/user/documents/ /backup/documents/

# Con progress bar
rsync -avP /home/user/documents/ /backup/documents/

# Cancella file in dest non presenti in source
rsync -av --delete /home/user/documents/ /backup/documents/

# Dry run (testa senza eseguire)
rsync -av --dry-run /home/user/documents/ /backup/documents/
```

### Backup remoto

```bash
# Backup su server remoto
rsync -avz /local/data/ user@remote:/backup/data/

# Pull da server remoto
rsync -avz user@remote:/remote/data/ /local/backup/

# Con porta SSH custom
rsync -avz -e "ssh -p 2222" /local/ user@remote:/backup/

# Con chiave SSH specifica
rsync -avz -e "ssh -i ~/.ssh/id_rsa" /local/ user@remote:/backup/
```

### Esclusioni

```bash
# Escludi pattern
rsync -av --exclude='*.tmp' --exclude='*.log' /source/ /dest/

# Escludi directory
rsync -av --exclude='cache' --exclude='temp' /source/ /dest/

# Escludi da file
rsync -av --exclude-from=exclude.txt /source/ /dest/
```

### Backup incrementale con hard links

```bash
# Primo backup completo
rsync -av /source/ /backup/full/

# Backup incrementale (usa hard link per file non modificati)
rsync -av --link-dest=/backup/full/ /source/ /backup/incremental-1/

# Altro incrementale
rsync -av --link-dest=/backup/incremental-1/ /source/ /backup/incremental-2/

# Risparmio enorme: file non modificati sono hard link (stesso inode)
```

### Opzioni utili

```bash
# Bandwidth limit (KB/s)
rsync -av --bwlimit=1000 /source/ /dest/

# Mostra progress totale
rsync -av --info=progress2 /source/ /dest/

# Solo file modificati dopo data
rsync -av --update /source/ /dest/

# Mantieni file parziali se interrotto
rsync -av --partial /source/ /dest/

# Comprimi durante trasferimento
rsync -avz /source/ user@remote:/dest/
```

---

## Strategie di backup

### 3-2-1 Rule

- **3** copie dei dati
- **2** media diversi (HDD + cloud)
- **1** copia off-site (remota)

### Script backup automatico

```bash
#!/bin/bash
# backup-script.sh

# Configurazione
SOURCE="/home/user/documents"
DEST="/backup"
DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="$DEST/backup-$DATE"

# Log
LOG="/var/log/backup.log"

echo "=== Backup started at $(date) ===" >> $LOG

# Crea backup con rsync
rsync -av --delete $SOURCE/ $BACKUP_DIR/ >> $LOG 2>&1

# Verifica successo
if [ $? -eq 0 ]; then
    echo "Backup completed successfully" >> $LOG
    
    # Crea archivio compresso
    tar -czf $BACKUP_DIR.tar.gz $BACKUP_DIR
    rm -rf $BACKUP_DIR
    
    # Cancella backup vecchi (più di 30 giorni)
    find $DEST -name "backup-*.tar.gz" -mtime +30 -delete
else
    echo "Backup FAILED" >> $LOG
    exit 1
fi

echo "=== Backup ended at $(date) ===" >> $LOG
```

### Automatizza con cron

```bash
# Edita crontab
crontab -e

# Backup giornaliero alle 2:00 AM
0 2 * * * /home/user/scripts/backup-script.sh

# Backup settimanale domenica alle 3:00 AM
0 3 * * 0 /home/user/scripts/weekly-backup.sh
```

---

## Esercizi pratici

### Esercizio 1: Monitoraggio spazio

```bash
# 1. Verifica spazio disponibile
df -h

# 2. Trova directory più grandi in /var
sudo du -h --max-depth=1 /var | sort -h

# 3. Trova file più grandi di 100MB
sudo find /var -type f -size +100M -exec ls -lh {} \;

# 4. Pulisci cache apt (se Debian/Ubuntu)
sudo apt clean
df -h  # verifica spazio liberato
```

### Esercizio 2: Mount USB

```bash
# 1. Identifica dispositivo USB
lsblk

# 2. Crea mount point
sudo mkdir -p /mnt/usb

# 3. Monta
sudo mount /dev/sdb1 /mnt/usb

# 4. Verifica
df -h | grep usb
ls /mnt/usb

# 5. Smonta
sudo umount /mnt/usb
```

### Esercizio 3: Configurazione fstab

```bash
# 1. Backup fstab
sudo cp /etc/fstab /etc/fstab.backup

# 2. Trova UUID
sudo blkid /dev/sdb1

# 3. Edita fstab (esempio USB)
sudo nano /etc/fstab
# Aggiungi: UUID=xxx-xxx  /mnt/usb  vfat  noauto,user,rw  0  0

# 4. Test
sudo mount -a
df -h
```

### Esercizio 4: Backup con tar

```bash
# 1. Crea directory test
mkdir -p ~/test-backup/docs
echo "test file" > ~/test-backup/docs/file1.txt
echo "another file" > ~/test-backup/docs/file2.txt

# 2. Crea backup tar.gz
tar -czf ~/backup-$(date +%Y%m%d).tar.gz ~/test-backup/

# 3. Verifica contenuto
tar -tzf ~/backup-*.tar.gz

# 4. Estrai in /tmp
tar -xzf ~/backup-*.tar.gz -C /tmp/

# 5. Verifica
ls -R /tmp/home/*/test-backup/
```

### Esercizio 5: Sincronizzazione con rsync

```bash
# 1. Crea directory source e dest
mkdir -p ~/rsync-test/source ~/rsync-test/dest
echo "file1" > ~/rsync-test/source/file1.txt
echo "file2" > ~/rsync-test/source/file2.txt

# 2. Prima sincronizzazione
rsync -av ~/rsync-test/source/ ~/rsync-test/dest/

# 3. Verifica
ls ~/rsync-test/dest/

# 4. Modifica source
echo "modified" >> ~/rsync-test/source/file1.txt
echo "new file" > ~/rsync-test/source/file3.txt

# 5. Sincronizza di nuovo
rsync -av --dry-run ~/rsync-test/source/ ~/rsync-test/dest/
rsync -av ~/rsync-test/source/ ~/rsync-test/dest/

# 6. Verifica solo differenze trasferite
```

### Esercizio 6: Script backup completo

```bash
# 1. Crea script
nano ~/backup.sh

#!/bin/bash
SOURCE="$HOME/documents"
DEST="$HOME/backups"
DATE=$(date +%Y%m%d)

mkdir -p $DEST
rsync -av --delete $SOURCE/ $DEST/backup-$DATE/
tar -czf $DEST/backup-$DATE.tar.gz $DEST/backup-$DATE/
rm -rf $DEST/backup-$DATE/
echo "Backup completed: $DEST/backup-$DATE.tar.gz"

# 2. Rendi eseguibile
chmod +x ~/backup.sh

# 3. Esegui
~/backup.sh

# 4. Verifica
ls -lh ~/backups/
```

---

## Troubleshooting

### Filesystem pieno (100%)

```bash
# 1. Identifica filesystem pieno
df -h

# 2. Trova cosa occupa spazio
sudo du -h / | sort -h | tail -20

# 3. Pulisci:
# - Log vecchi
sudo find /var/log -type f -name "*.log" -mtime +30 -delete

# - Cache apt/dnf
sudo apt clean  # o sudo dnf clean all

# - File temp
sudo rm -rf /tmp/*

# - Vecchi kernel (Ubuntu/Debian)
sudo apt autoremove
```

### Device busy (non smonta)

```bash
# 1. Trova chi usa il device
lsof /mnt/usb
# o
fuser -m /mnt/usb

# 2. Termina processi
sudo fuser -km /mnt/usb

# 3. Smonta
sudo umount /mnt/usb
```

### Fstab broken (boot fallito)

```bash
# 1. Avvia in recovery mode (GRUB menu)

# 2. Rimonta root in read-write
mount -o remount,rw /

# 3. Edita fstab
nano /etc/fstab
# Commenta riga problematica con #

# 4. Riavvia
reboot
```

---

## Comandi da memorizzare

```bash
# === Spazio disco ===
df -h                        # Spazio filesystems
du -sh /path                 # Dimensione directory
du -h --max-depth=1 /path    # Sottodirectory
find / -size +100M           # File grandi

# === Mount ===
mount                        # Lista mount
lsblk                        # Block devices
sudo mount /dev/sdb1 /mnt    # Monta
sudo umount /mnt             # Smonta
sudo blkid                   # UUID dispositivi
sudo mount -a                # Monta tutto da fstab

# === tar ===
tar -czf file.tar.gz /path   # Crea archivio
tar -xzf file.tar.gz         # Estrai
tar -tzf file.tar.gz         # Lista contenuto
tar -xzf file.tar.gz -C /tmp # Estrai in /tmp

# === rsync ===
rsync -av /src/ /dest/       # Sincronizza locale
rsync -avz user@host:/src/ /dest/  # Da remoto
rsync -av --delete /src/ /dest/    # Con cancellazione
rsync -av --dry-run /src/ /dest/   # Test
```

---

## Checklist settimana 7

- [ ] So monitorare lo spazio disco con df e du
- [ ] So trovare file e directory grandi
- [ ] So montare e smontare filesystem
- [ ] Conosco la differenza tra /dev/sdX e UUID
- [ ] So configurare /etc/fstab
- [ ] So creare archivi tar compressi
- [ ] So estrarre archivi tar
- [ ] So usare rsync per backup locali
- [ ] So usare rsync per backup remoti
- [ ] Ho creato uno script di backup automatico
- [ ] Ho fatto tutti gli esercizi pratici

---

## Risorse aggiuntive

- Man pages: `man df`, `man du`, `man mount`, `man fstab`, `man tar`, `man rsync`
- Linux Storage Guide: https://www.kernel.org/doc/html/latest/filesystems/
- rsync documentation: https://rsync.samba.org/documentation.html

**Prossima settimana**: Sicurezza (SSH, firewall, ACL)
