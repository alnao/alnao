# Settimana 5 — Networking Base (LFCA)
Tempo stimato: 2-3 ore

## Introduzione
Comprendere i concetti di rete base e saper diagnosticare problemi di connettività è essenziale per qualsiasi amministratore di sistemi Linux.

## Concetti di rete fondamentali

### Modello TCP/IP
- **Livello Applicazione**: HTTP, DNS, SSH, FTP
- **Livello Trasporto**: TCP, UDP
- **Livello Internet**: IP, ICMP
- **Livello Accesso**: Ethernet, WiFi

### Indirizzi IP
- **IPv4**: 192.168.1.10 (32 bit, 4 ottetti)
- **IPv6**: 2001:0db8:85a3::8a2e:0370:7334 (128 bit)
- **Subnet mask**: 255.255.255.0 o /24
- **Gateway**: router predefinito
- **DNS**: risoluzione nomi → IP

### Porte comuni
- **22**: SSH
- **80**: HTTP
- **443**: HTTPS
- **53**: DNS
- **3306**: MySQL
- **5432**: PostgreSQL

## Comandi di configurazione rete

### ip — configurazione moderna

```bash
# Mostra tutte le interfacce
ip addr
ip a

# Mostra interfaccia specifica
ip addr show eth0

# Mostra solo IPv4
ip -4 addr

# Mostra routing table
ip route
ip r

# Mostra gateway predefinito
ip route show default

# Aggiungi IP temporaneo
sudo ip addr add 192.168.1.100/24 dev eth0

# Rimuovi IP
sudo ip addr del 192.168.1.100/24 dev eth0

# Attiva/disattiva interfaccia
sudo ip link set eth0 up
sudo ip link set eth0 down

# Mostra statistiche interfaccia
ip -s link

# Mostra neighbor cache (ARP)
ip neigh
ip neighbour show
```

### Configurazione permanente

#### Debian/Ubuntu — /etc/network/interfaces
```bash
sudo nano /etc/network/interfaces

# Configurazione statica
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4

# DHCP
auto eth0
iface eth0 inet dhcp

# Riavvia networking
sudo systemctl restart networking
```

#### Ubuntu con Netplan — /etc/netplan/*.yaml
```bash
sudo nano /etc/netplan/01-netcfg.yaml

network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
  # Oppure statico:
    eth0:
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]

# Applica configurazione
sudo netplan apply

# Test configurazione
sudo netplan try
```

#### RHEL/CentOS — /etc/sysconfig/network-scripts/
```bash
sudo nano /etc/sysconfig/network-scripts/ifcfg-eth0

TYPE=Ethernet
BOOTPROTO=static
NAME=eth0
DEVICE=eth0
ONBOOT=yes
IPADDR=192.168.1.100
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=8.8.8.8
DNS2=8.8.4.4

# Riavvia
sudo systemctl restart NetworkManager
```

## File di configurazione rete

### /etc/hosts
```bash
# Mappatura statica hostname → IP
sudo nano /etc/hosts

127.0.0.1       localhost
127.0.1.1       myhostname
192.168.1.10    server1.example.com server1
192.168.1.20    server2.example.com server2

# Test
ping server1
```

### /etc/resolv.conf
```bash
# Configurazione DNS
cat /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4
search example.com
options timeout:2 attempts:3

# Spesso gestito da systemd-resolved o NetworkManager
# Per modifiche permanenti, configurare in netplan o NetworkManager
```

### /etc/hostname
```bash
# Nome del sistema
cat /etc/hostname

# Cambia hostname
sudo hostnamectl set-hostname newhostname
hostnamectl status
```

## Comandi di diagnostica rete

### ping — test connettività

```bash
# Test raggiungibilità host
ping google.com
ping 8.8.8.8

# Limita numero pacchetti
ping -c 4 google.com

# Intervallo tra pacchetti
ping -i 0.5 google.com

# Pacchetti grandi
ping -s 1000 google.com

# IPv6
ping6 ipv6.google.com
```

### traceroute/tracepath — percorso pacchetti

```bash
# Installa se necessario
sudo apt install traceroute

# Traccia route verso host
traceroute google.com
tracepath google.com

# Usa ICMP invece di UDP
traceroute -I google.com

# IPv6
traceroute6 ipv6.google.com
```

### ss — socket statistics (sostituisce netstat)

```bash
# Tutte le connessioni
ss

# Socket in ascolto
ss -l
ss -lt   # TCP listening
ss -lu   # UDP listening

# Tutte le connessioni TCP
ss -t
ss -ta   # includi listening

# Mostra processi
ss -ltp

# Mostra statistiche
ss -s

# Filtra per porta
ss -tn sport = :22
ss -tn dport = :80

# Connessioni stabilite
ss -t state established
```

### netstat — statistiche rete (legacy)

```bash
# Socket in ascolto
netstat -l
netstat -lt   # TCP
netstat -lu   # UDP

# Mostra PID/programma
netstat -ltp

# Tutte le connessioni
netstat -a

# Routing table
netstat -r

# Statistiche interfacce
netstat -i
```

### dig — DNS query

```bash
# Query DNS base
dig google.com

# Solo risposta breve
dig +short google.com

# Query tipo specifico
dig google.com A     # IPv4
dig google.com AAAA  # IPv6
dig google.com MX    # Mail servers
dig google.com NS    # Name servers
dig google.com TXT   # TXT records

# Query a server DNS specifico
dig @8.8.8.8 google.com

# Reverse DNS lookup
dig -x 8.8.8.8

# Trace DNS resolution
dig +trace google.com
```

### nslookup — DNS lookup (legacy)

```bash
# Lookup base
nslookup google.com

# Usa server DNS specifico
nslookup google.com 8.8.8.8

# Reverse lookup
nslookup 8.8.8.8
```

### host — DNS lookup semplice

```bash
# Lookup hostname
host google.com

# Reverse lookup
host 8.8.8.8

# Tutti i record
host -a google.com
```

### curl/wget — test HTTP

```bash
# GET request
curl http://example.com
wget http://example.com

# Mostra solo headers
curl -I http://example.com

# Segui redirect
curl -L http://example.com

# Salva in file
curl -o output.html http://example.com
wget -O output.html http://example.com

# Test API
curl -X POST -H "Content-Type: application/json" \
     -d '{"key":"value"}' http://api.example.com/endpoint

# Test con timeout
curl --connect-timeout 5 http://example.com
```

## Esercizi pratici

### Esercizio 1: Configurazione e test base

```bash
# 1. Verifica configurazione attuale
ip addr show
ip route show
cat /etc/resolv.conf

# 2. Test connettività
ping -c 4 8.8.8.8
ping -c 4 google.com

# 3. Verifica DNS
dig google.com
nslookup google.com

# 4. Verifica gateway
ip route show default
ping -c 4 $(ip route show default | awk '{print $3}')
```

### Esercizio 2: Diagnostica connessione

```bash
# Scenario: non riesco a raggiungere google.com

# 1. Test connettività locale
ping -c 4 127.0.0.1

# 2. Test gateway
ping -c 4 $(ip route | grep default | awk '{print $3}')

# 3. Test DNS esterno
ping -c 4 8.8.8.8

# 4. Test risoluzione DNS
dig google.com
nslookup google.com

# 5. Test raggiungibilità finale
ping -c 4 google.com

# 6. Traccia percorso
traceroute google.com
```

### Esercizio 3: Analisi porte e servizi

```bash
# 1. Servizi in ascolto
sudo ss -ltnp

# 2. Verifica porta specifica (SSH)
ss -tn sport = :22

# 3. Test connessione a porta
curl -v telnet://localhost:22

# 4. Verifica connessioni stabilite
ss -t state established

# 5. Statistiche rete
ss -s
```

### Esercizio 4: Configurazione statica IP (VM di test)

```bash
# ATTENZIONE: fai questo su VM di test!

# 1. Backup configurazione
sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak

# 2. Configurazione statica
sudo nano /etc/netplan/01-netcfg.yaml
# [vedi esempio sopra]

# 3. Test (torna automaticamente indietro se fallisce)
sudo netplan try

# 4. Applica
sudo netplan apply

# 5. Verifica
ip addr show
ip route show
ping -c 4 8.8.8.8
```

### Esercizio 5: Troubleshooting DNS

```bash
# 1. Verifica file hosts
cat /etc/hosts

# 2. Verifica resolv.conf
cat /etc/resolv.conf

# 3. Test DNS multipli
dig @8.8.8.8 google.com
dig @1.1.1.1 google.com
dig @208.67.222.222 google.com

# 4. Test con host
host google.com

# 5. Flush DNS cache (se systemd-resolved)
sudo systemd-resolve --flush-caches
sudo systemd-resolve --statistics
```

## Comandi rapidi di riferimento

```bash
# Configurazione
ip addr show
ip route show
ip link set eth0 up/down

# DNS
dig domain.com
nslookup domain.com
host domain.com

# Connettività
ping host
traceroute host

# Porte e socket
ss -ltnp
ss -t state established
netstat -ltnp

# Test HTTP
curl http://example.com
wget http://example.com

# File config
/etc/hosts
/etc/resolv.conf
/etc/hostname
/etc/netplan/*.yaml
```

## Problemi comuni e soluzioni

1. **"Name or service not known"**
   - Problema DNS → controlla `/etc/resolv.conf`

2. **"Network is unreachable"**
   - Problema routing → verifica `ip route` e gateway

3. **"No route to host"**
   - Firewall o host spento → test con `ping`

4. **Connessione lenta**
   - Test latenza con `ping`, traccia con `traceroute`

5. **Porta non raggiungibile**
   - Verifica ascolto con `ss -ltnp`, firewall con `ufw status`

## Checklist competenze

- [ ] Configurare IP statico e DHCP
- [ ] Leggere e modificare /etc/hosts e /etc/resolv.conf
- [ ] Usare ip, ping, traceroute
- [ ] Diagnosticare problemi DNS
- [ ] Verificare porte aperte con ss
- [ ] Test connettività HTTP con curl
- [ ] Interpretare output di ip route

## Tempo suggerito
- 20 minuti: concetti teorici
- 90 minuti: esercizi pratici
- 20 minuti: troubleshooting scenari

## Risorse
- `man ip`, `man ss`, `man dig`
- RFC 1918 — indirizzi privati
- Subnet calculator online

Prossima settimana: Gestione Pacchetti
