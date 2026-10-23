# Cloudflare WARP su cirilla: aggirare le perdite della linea dell'internet provider

**Data:** 23 ottobre 2026
**Contesto:** vedi `~/problema.md`. Sulla linea dell'internet provider circa il 10–15% delle nuove connessioni (UDP e TCP) non riceve risposta, in modo deterministico per combinazione porta di origine + destinazione. Il problema colpisce tutti i dispositivi di casa (3.48). WARP è una **soluzione tampone** in attesa di un router nuovo o di una riparazione da parte dell'internet provider.

---

## 1. Cos'è WARP

**Cloudflare WARP** è un servizio gratuito di Cloudflare, la stessa azienda del DNS `1.1.1.1`. Funziona come una VPN: il PC apre **un unico tunnel cifrato** verso il server Cloudflare più vicino, e da lì il traffico esce su internet.

| Caratteristica | Dettaglio |
|---|---|
| Costo | gratuito, senza limiti di traffico (esiste WARP+ a pagamento, più veloce) |
| Protocollo | MASQUE (QUIC su UDP 443, predefinito) oppure WireGuard |
| Server | il datacenter Cloudflare più vicino, di solito Milano (`MXP`) |
| IP pubblico visto dai siti | IP di Cloudflare, **localizzato in Italia** |
| Latenza in più | pochi millisecondi |
| Anonimato | **no**: Cloudflare vede a quali siti ti colleghi, e i siti vedono comunque che sei in Italia |
| Dispositivi | solo quelli su cui è installato (Linux, Windows, macOS, Android, iOS) |

### Perché è gratis

- Cloudflare ha una rete enorme già pagata (CDN, protezione dagli attacchi, DNS) e scambia traffico direttamente con i provider: un utente in più le costa pochissimo.
- WARP gratuito è una vetrina per i prodotti a pagamento: **WARP+** in abbonamento e **Cloudflare Zero Trust** per le aziende, che usa lo stesso client.
- I milioni di client le danno dati sul comportamento della rete (guasti, attacchi, prestazioni). La privacy policy dichiara che i dati non vengono venduti e che la cronologia di navigazione non viene conservata legata alla persona.

## 2. Perché risolve il problema

Sulla linea dell'internet provider a fallire sono i **nuovi flussi** che cadono su una combinazione porta + destinazione "rotta" (problema.md, 3.15 e 3.44). I flussi già aperti, come un ping continuo, non perdono nulla (3.1).

Con WARP tutto il traffico del PC viaggia dentro **un solo flusso UDP** verso Cloudflare. Le singole connessioni (DNS, HTTPS, SSH…) sono dentro il tunnel: la linea vede solo quel flusso e non può più far cadere le singole connessioni.

**Limite:** se il flusso del tunnel cade proprio su una combinazione rotta, WARP non si collega. Basta disconnettere e riconnettere, perché riparte da una porta nuova (sezione 6).

## 3. Confronto con le altre soluzioni

| Soluzione | Costo | Pro | Contro |
|---|---|---|---|
| **WARP** | gratis | IP italiano, quasi mai bloccato; latenza minima; si installa in 5 minuti | un servizio esterno vede il traffico; protegge solo i dispositivi su cui è installato |
| Lightsail Irlanda (`~/vpn-lightsail.sh`) | ~$0,007/h, $5 al mese se sempre accesa | sotto il tuo controllo | IP **irlandese** e **di datacenter AWS**: CAPTCHA, blocchi su RaiPlay/DAZN, controlli in più delle banche; +35–45 ms |
| Router nuovo (FRITZ!Box 7690) | ~200–300 € | soluzione definitiva per tutta la casa | **solo se il colpevole è il router dell'internet provider**: non ancora dimostrato (problema.md, sezione 7) |
| Guasto aperto con l'assistenza dell'internet provider | gratis | se la causa è nella rete dell'internet provider, è l'unica soluzione vera | tempi incerti |

## 4. Installazione su cirilla (Debian 13)

Comandi da lanciare a mano (richiedono `sudo`):

```bash
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
. /etc/os-release
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/cloudflare-client.list
apt update && apt install cloudflare-warp
```

Se `apt update` segnala che la distribuzione `trixie` non esiste nel repository, sostituisci `$VERSION_CODENAME` con `bookworm` nella riga `echo` e rilancia.

L'installazione aggiunge il servizio di sistema `warp-svc`, già attivo, e il comando `warp-cli`.

## 5. Attivazione

Senza `sudo`:

```bash
warp-cli registration new        # una volta sola: accetta i termini di servizio
warp-cli mode warp+doh           # tutto il traffico nel tunnel, DNS cifrato (DoH)
warp-cli connect
warp-cli status                  # deve dire "Connected"
```

Verifica che il traffico passi davvero da WARP:

```bash
curl -s https://www.cloudflare.com/cdn-cgi/trace | grep -E "^(warp|loc|colo)="
```

Risultato atteso: `warp=on`, `loc=IT`, `colo=MXP` (o un altro datacenter vicino).

### Test delle perdite

Lo script di test di Lightsail funziona con qualsiasi tunnel: fa 50 richieste HTTPS e 150 query DNS da porte casuali, e con WARP non tocca niente su AWS.

```bash
~/vpn-lightsail.sh test
```

| Risultato | Significato |
|---|---|
| HTTPS 0 lente / 0 in errore, DNS 0–1 su 150 | WARP aggira il guasto |
| Perdite come senza WARP (~6–7 HTTPS su 50, 12–19 DNS su 150) | WARP non è attivo davvero: controlla `warp-cli status` e la riga `warp=` |

Per confronto, il ciclo curl originale:

```bash
for i in {1..50}; do
  curl -w "Req $i - Conn: %{time_connect}s | Totale: %{time_total}s\n" \
    -o /dev/null -s --max-time 30 https://api-test.paths.games/api/echo/status || echo "Req $i - ERRORE"
done
```

## 6. Uso quotidiano

| Cosa | Comando |
|---|---|
| Stato | `warp-cli status` |
| Spegnere / riaccendere | `warp-cli disconnect` / `warp-cli connect` |
| **Non si collega** | `warp-cli disconnect && warp-cli connect`: riparte da una porta nuova, utile se il tunnel è caduto su una combinazione rotta |
| Cambiare protocollo | `warp-cli tunnel protocol set WireGuard`, oppure `MASQUE` (predefinito) |
| Solo DNS cifrato, senza tunnel | `warp-cli mode doh` (non aggira il guasto: serve solo per confronto) |
| Tornare al tunnel completo | `warp-cli mode warp+doh` |

WARP si ricollega da solo all'avvio se era connesso allo spegnimento.

### Escludere siti o reti dal tunnel (split tunneling)

Per impostazione predefinita WARP usa una lista di esclusioni: tutto passa dal tunnel **tranne** quello che è escluso. Le reti locali (192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12) sono già escluse, quindi stampanti, NAS, il router di casa e Docker restano raggiungibili.

```bash
warp-cli tunnel host add nomebanca.it        # esclude un dominio
warp-cli tunnel ip add 203.0.113.0/24        # esclude un intervallo di IP
warp-cli tunnel host list                    # elenca le esclusioni
warp-cli tunnel host remove nomebanca.it     # toglie un'esclusione
```

Il traffico escluso passa direttamente dalla linea dell'internet provider, quindi **con il guasto**. Conviene escludere solo i siti che con WARP danno problemi.

### Streaming e gioco online

| Uso | Con WARP |
|---|---|
| Netflix, YouTube, Spotify, RaiPlay | di solito funzionano: IP italiano, raramente bloccato |
| Cloud gaming (GeForce NOW) | latenza in più minima, banda di solito sufficiente (servono 25–75 Mbit/s); il jitter può peggiorare un po' |
| Giochi multiplayer con connessioni dirette tra giocatori (P2P) | possibili problemi di "NAT strict" e di matchmaking: WARP non accetta connessioni in arrivo |

Se il gioco scatta o ha latenza alta, disattiva WARP solo mentre giochi (`warp-cli disconnect`) e riattivalo dopo. Senza WARP il guasto colpisce soprattutto l'**avvio** della sessione, perché una sessione già partita è un flusso stabile: se non parte, riprova.

## 7. Altri dispositivi

| Dispositivo | Come |
|---|---|
| Windows (DESKTOP-8AJICSU) | installa "Cloudflare WARP" da `https://one.one.one.one`, apri l'app e attiva l'interruttore; poi rilancia lo script di test per Windows (problema.md, 3.48) per il confronto |
| Android / iPhone | app **"1.1.1.1 + WARP"** dallo store, interruttore su "WARP" |
| Libretto MX Linux 23 (Debian 12) | stessa procedura della sezione 4, con `bookworm` |

Sui PC aziendali non installare WARP: può essere in conflitto con gli agenti di sicurezza (problema.md, 3.43) e con le regole dell'azienda.

## 8. Problemi noti e soluzioni

| Problema | Causa probabile | Soluzione |
|---|---|---|
| `warp-cli status` resta su "Connecting" | il flusso del tunnel è caduto su una combinazione rotta, oppure UDP 443 bloccato | `warp-cli disconnect && warp-cli connect`; se non basta, `warp-cli tunnel protocol set WireGuard` |
| Un sito non funziona o chiede verifiche | blocco degli IP Cloudflare (raro) | escluderlo con `warp-cli tunnel host add` |
| I nomi dei dispositivi di casa (dominio locale del router) non si risolvono | il DNS passa da Cloudflare, non dal router di casa | usare gli IP locali, oppure `warp-cli mode warp` (DNS non cifrato) |
| Container Docker senza rete | conflitto tra le regole di rete di WARP e i bridge Docker (raro) | `warp-cli disconnect`, riavviare Docker, `warp-cli connect` |
| Velocità più bassa del solito | la versione gratuita non è la più veloce | per il download pieno: `warp-cli disconnect` durante il download |
| `vpn-lightsail.sh` e WARP insieme | due tunnel completi in conflitto | usarne **uno solo alla volta** |

## 9. Disinstallazione

```bash
warp-cli disconnect
warp-cli registration delete
sudo apt remove --purge cloudflare-warp
sudo rm /etc/apt/sources.list.d/cloudflare-client.list /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
sudo apt update
```

## 10. Note

- **Provato su cirilla il 23/10/2026: funziona** (problema.md, 3.49). I numeri del test della sezione 5 sono ancora da aggiungere.
- **Lightsail:** con WARP l'istanza AWS non serve più. Per sicurezza lancia `~/vpn-lightsail.sh down`, che cancella l'istanza se esiste e controlla che non restino IP statici a pagamento.
- **WARP non ripara la linea:** il guasto resta e colpisce tutti i dispositivi senza WARP. Per la soluzione vera vedi `problema.md`, sezione 7: router nuovo se il colpevole è il router dell'internet provider, guasto aperto con l'assistenza se è la sua rete.




# &lt; AlNao /&gt;
Tutti i codici sorgente e le informazioni presenti in questo repository sono frutto di un attento e paziente lavoro di sviluppo da parte di AlNao, che si è impegnato a verificarne la correttezza nella misura massima possibile. Qualora parte del codice o dei contenuti sia stato tratto da fonti esterne, la relativa provenienza viene sempre citata, nel rispetto della trasparenza e della proprietà intellettuale. 


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

