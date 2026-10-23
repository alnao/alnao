# AWS Paperclip AI Server

Questo set di script automatizza il provisioning, la gestione del ciclo di vita e il deployment di **[Paperclip AI](https://github.com/paperclipai/paperclip)** su un'istanza AWS EC2 (Amazon Linux 2023), con containerizzazione Docker e tagging completo conforme agli standard del progetto.

---

## 🏷️ Tagging delle Risorse (6 Tag)

Tutte le risorse create (Istanza EC2, Volume EBS radice, Network Interface ENI) vengono etichettate con i seguenti **6 tag**:

1. **`Name`**: valorizzato dinamicamente per risorsa:
   - Istanza: `EC2_INSTANCE_NAME` (es. `alnao-paperclip-ec2`)
   - Volume EBS: `EBS_VOLUME_NAME` (es. `alnao-paperclip-ebs`)
   - Interfaccia ENI: `ENI_NAME` (es. `alnao-paperclip-eni`)
2. **`Environment`**: `TAG_ENVIRONMENT` (default: `dev`)
3. **`Project`**: `TAG_PROJECT` (default: `Paperclip`)
4. **`Owner`**: `TAG_OWNER` (default: `AlNao`)
5. **`CostCenter`**: `TAG_COST_CENTER` (default: `dev`)
6. **`ManagedBy`**: `TAG_MANAGED_BY` (default: `Sh`)

I tag sono applicati al momento del lancio con `--tag-specifications` su tutti i tipi (`instance`, `volume`, `network-interface`), e verificati/riapplicati programmaticamente post-creazione.

---

## 📁 Struttura della Cartella

```text
Scripts/aws_paperclip/
├── .env.example                  # Template delle variabili di configurazione
├── .env                          # File locale con credenziali (ignorato da Git)
├── create_paperclip_server.sh   # Creazione istanza EC2, bootstrap Docker + Paperclip
├── start_paperclip_server.sh    # Avvio istanza + apertura tunnel SSH porta 3100
├── stop_paperclip_server.sh     # Chiusura tunnel SSH e arresto istanza
├── terminate_paperclip_server.sh# Terminazione definitiva dell'istanza
└── README.md                    # Questa documentazione
```

---

## 🚀 Setup e Utilizzo

### 1. Configurazione Iniziale
Copia il file di esempio e compila i tuoi parametri AWS:
```bash
cp Scripts/aws_paperclip/.env.example Scripts/aws_paperclip/.env
nano Scripts/aws_paperclip/.env
```

Parametri fondamentali da valorizzare:
* `AWS_REGION`: es. `"eu-central-1"`
* `SECURITY_GROUP_ID`: ID del tuo Security Group (deve consentire SSH sulla porta 22 dal tuo IP)
* `PEM_PATH`: percorso della tua chiave privata SSH (es. `~/.aws/key.pem`)
* `EC2_KEY_NAME`: nome della chiave registrata in AWS
* `ANTHROPIC_API_KEY` o `OPENAI_API_KEY`: chiavi API per consentire agli agenti Paperclip di funzionare.

### 2. Creazione dell'istanza EC2 e installazione automatica
Esegui:
```bash
./Scripts/aws_paperclip/create_paperclip_server.sh
```

Lo script effettua automaticamente:
1. Validazione prerequisiti e controlli di non duplicazione.
2. Risoluzione dinamica dell'AMI Amazon Linux 2023 tramite SSM.
3. Lancio dell'istanza EC2 (`t3.medium`, 30 GB gp3) con tutti i 6 tag applicati a istanza, EBS ed ENI.
4. Esecuzione dello script `user_data` al primo avvio:
   - Installazione di Docker, Git e Docker Compose plugin.
   - Generazione dei secret di autenticazione (`BETTER_AUTH_SECRET`, `PAPERCLIP_TOOL_ACTION_SIGNING_SECRET`).
   - Clonazione del repository Paperclip e configurazione dell'ambiente.
   - Creazione e avvio del servizio systemd `paperclip.service`.
5. Aggiornamento automatico del file `.env` con il nuovo `EC2_INSTANCE_ID`.

*(Nota: al primo boot il container richiede 2-4 minuti per la compilazione/avvio iniziale).*

---

## 🌐 Accesso alla Dashboard Web (Porta 3100)

Per motivi di sicurezza e per evitare di esporre la piattaforma di orchestrazione AI su Internet aperto, la modalità raccomandata è il **Tunnel SSH**:

```bash
# Esegui manualmente oppure usa lo script start:
ssh -i ~/.aws/key.pem -L 3100:localhost:3100 ec2-user@<IP_PUBBLICO_EC2>
```
Apri il browser su:
👉 **`http://localhost:3100`**

---

## ⚙️ Gestione del Ciclo di Vita

### Avvio (e apertura automatica del tunnel SSH)
```bash
./Scripts/aws_paperclip/start_paperclip_server.sh
```
Avvia l'istanza se è spenta, attende lo stato `running`, rileva l'IP pubblico e attiva il tunnel locale su `localhost:3100`.

### Spegnimento (per azzerare i costi orari di calcolo)
```bash
./Scripts/aws_paperclip/stop_paperclip_server.sh
```
Chiude il tunnel SSH e arresta l'istanza EC2. I dati rimangono persistiti sul volume EBS.

### Terminazione definitiva
```bash
./Scripts/aws_paperclip/terminate_paperclip_server.sh
```
Elimina l'istanza e i volumi associati, resettando `EC2_INSTANCE_ID` nel file `.env`.







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

