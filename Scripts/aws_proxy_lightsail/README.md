# AWS Lightsail VPN Proxy

Lo script `script.sh` crea **su richiesta** un piccolo server Debian su [AWS Lightsail](https://aws.amazon.com/lightsail/) in Irlanda (`eu-west-1`) e ci collega il PC con un tunnel **WireGuard**. Quando non serve più, lo script cancella il server: da quel momento non costa nulla.

È nato per aggirare una linea domestica che perde pacchetti solo su alcune combinazioni di indirizzi e porte. Dentro il tunnel tutto il traffico del PC viaggia in **un solo flusso UDP**: se quel flusso funziona, funziona tutto. Se la combinazione scelta è "rotta", lo script ne prova un'altra cambiando la porta locale.

---

## 🧭 Comandi

| Comando | Cosa fa |
|---|---|
| `up` | Crea l'istanza se non esiste, aspetta che WireGuard sia pronto e attiva il tunnel completo |
| `reconnect` | Istanza già attiva ma tunnel spento (riavvio del PC, cambio di rete...): riaccende solo il tunnel, senza toccare AWS |
| `status` | Stato dell'istanza e del tunnel, IP pubblico in uso. Avvisa se l'istanza è attiva ma il tunnel è spento |
| `diag` | Entra in SSH nel server e mostra WireGuard, regole `nft` e log di installazione |
| `test` | 50 richieste HTTPS e 150 query DNS da porte casuali, per misurare la qualità della linea |
| `down` | Spegne il tunnel e **cancella** l'istanza |

```bash
./script.sh up
./script.sh status
./script.sh down
```

---

## ⚙️ Requisiti

- **AWS CLI** configurata con credenziali che possano usare Lightsail in `eu-west-1`. Le azioni usate sono `CreateInstances`, `GetInstance`, `DeleteInstance`, `PutInstancePublicPorts`, `DownloadDefaultKeyPair`, `TagResource` e `GetStaticIps`.
- **NetworkManager** (`nmcli`): il tunnel è una connessione NetworkManager chiamata `wg-lightsail`.
- **wireguard-tools** per generare le chiavi, più `curl`, `ssh` e `dig` (solo per `test`):
  ```bash
  sudo apt install wireguard-tools curl openssh-client bind9-dnsutils
  chmod +x script.sh
  ```

---

## 🔧 Come funziona `up`

1. **Chiavi**: genera (una volta sola) la chiave WireGuard del client e scarica la chiave SSH predefinita di Lightsail della regione. A ogni creazione genera anche una nuova coppia di chiavi per il server.
2. **Istanza**: crea un'istanza `nano_3_0` con `debian_13`. Uno script di avvio (user-data) installa WireGuard e `nftables`, attiva l'inoltro dei pacchetti e il NAT verso internet.
3. **Firewall Lightsail**: apre la porta UDP `51820` a tutti. La porta SSH `22` resta aperta solo all'IP pubblico attuale e alla console web di Lightsail.
4. **Attesa**: si collega in SSH finché l'installazione non è finita e WireGuard è in ascolto (di solito 2-4 minuti).
5. **Tunnel di prova**: attiva un tunnel che porta solo l'indirizzo del server (`10.66.0.1`), quindi internet continua a passare dalla linea normale. Se il server non risponde, riprova fino a 10 volte, ogni volta con una porta locale diversa.
6. **Tunnel completo**: con la porta che ha funzionato, fa passare nel tunnel tutto il traffico e il DNS (`1.1.1.1`, `8.8.8.8`). Se il tunnel completo non risponde, lo spegne subito e internet torna sulla linea normale.

`reconnect` esegue solo i passi 5 e 6 sull'istanza che esiste già.

---

## 💶 Costi

- Il piano `nano_3_0` costa circa **5 $ al mese** e Lightsail lo conteggia a ore: un'istanza tenuta accesa poche ore costa pochi centesimi.
- **Un'istanza Lightsail spenta (stopped) si paga lo stesso.** Per questo lo script non ha un comando per spegnerla: `down` la cancella.
- Alla fine `down` controlla anche se nella regione ci sono IP statici, che si pagano quando non sono collegati a un'istanza. Lo script non ne crea, ma li segnala.
- Se `status` mostra "istanza attiva ma tunnel spento", stai pagando un server che non usi: lancia `reconnect` oppure `down`.

---

## 🏷️ Tag

L'istanza viene creata con gli stessi tag degli altri script AWS del repository (per esempio `aws_dev_server`). Si possono cambiare con variabili d'ambiente:

| Tag | Variabile | Default |
|---|---|---|
| `Name` | (nome dell'istanza) | `vpn-tim` |
| `Environment` | `TAG_ENVIRONMENT` | `dev` |
| `Project` | `TAG_PROJECT` | `Proxy` |
| `Owner` | `TAG_OWNER` | `AlNao` |
| `CostCenter` | `TAG_COST_CENTER` | `dev` |
| `ManagedBy` | `TAG_MANAGED_BY` | `Sh` |

```bash
TAG_ENVIRONMENT=test ./script.sh up
```

Se `up` trova un'istanza già attiva, le riapplica i tag. Il disco di sistema fa parte dell'istanza e Lightsail non permette di taggarlo a parte.

---

## 📁 File locali

Lo script salva tutto in `~/.config/vpn-lightsail/`, con permessi `700`:

| File | Contenuto |
|---|---|
| `client.key`, `client.pub` | Chiavi WireGuard del PC, generate una volta sola |
| `server.key`, `server.pub` | Chiavi WireGuard del server, rigenerate a ogni `up` e cancellate da `down` |
| `lightsail-default.pem` | Chiave SSH predefinita di Lightsail per la regione |
| `wg-lightsail.conf` | Ultima configurazione WireGuard importata in NetworkManager |

Se l'istanza esiste ma manca `server.pub` (per esempio dopo una pulizia della cartella), lo script non può collegarsi: lancia `down` e poi `up`.

---

## 🩺 Problemi comuni

- **"Nessun handshake in 10 tentativi"**: internet non è stato toccato. Lo script mostra la diagnosi del server: controlla che WireGuard sia attivo e che la porta UDP `51820` non sia bloccata dalla rete in cui ti trovi.
- **"Il server non risponde in SSH dopo ~7 minuti"**: lancia `./script.sh diag`. Se hai cambiato rete, `diag` aggiorna anche la regola SSH con il nuovo IP pubblico.
- **Internet non funziona con il tunnel acceso**: `nmcli con down wg-lightsail` riporta subito il traffico sulla linea normale. L'istanza però resta attiva: poi lancia `reconnect` oppure `down`.
- **Il comando `test`** usa un endpoint HTTPS personale (`api-test.paths.games`): per usarlo altrove cambia la variabile `url` in `test_tunnel`.


# &lt; AlNao /&gt;
Tutti i codici sorgente e le informazioni presenti in questo repository sono frutto di un attento e paziente lavoro di sviluppo da parte di AlNao, che si è impegnato a verificarne la correttezza nella massima misura possibile. Qualora parte del codice o dei contenuti sia stato tratto da fonti esterne, la relativa provenienza viene sempre citata, nel rispetto della trasparenza e della proprietà intellettuale. 


Alcuni contenuti e porzioni di codice presenti in questo repository sono stati realizzati anche grazie al supporto di strumenti di intelligenza artificiale, il cui contributo ha permesso di arricchire e velocizzare la produzione del materiale. Ogni informazione e frammento di codice è stato comunque attentamente verificato e validato, con l’obiettivo di garantire la massima qualità e affidabilità dei contenuti offerti. 


Per ulteriori dettagli, approfondimenti o richieste di chiarimento, si invita a consultare il sito [AlNao.it](https://www.alnao.it/).


## License
Made with ❤️ by <a href="https://www.alnao.it">AlNao</a>
&bull; 
Public projects 
<a href="https://www.gnu.org/licenses/gpl-3.0"  valign="middle"> <img src="https://img.shields.io/badge/License-GPL%20v3-blue?style=plastic" alt="GPL v3" valign="middle" /></a>
*Free Software!*


Il software è distribuito secondo i termini della GNU General Public License v3.0. L'uso, la modifica e la ridistribuzione sono consentiti, a condizione che ogni copia o lavoro derivato sia rilasciato con la stessa licenza. Il contenuto è fornito "così com'è", senza alcuna garanzia, esplicita o implicita.


The software is distributed under the terms of the GNU General Public License v3.0. Use, modification, and redistribution are permitted, provided that any copy or derivative work is released under the same license. The content is provided "as is", without any warranty, express or implied.
