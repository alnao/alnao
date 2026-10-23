# Paperclip AI - Ambiente Docker Locale

Questo set di script consente di eseguire **[Paperclip AI](https://github.com/paperclipai/paperclip)** in ambiente locale tramite Docker, salvando tutti i dati (database, task, memoria degli agenti e file) in un **volume/disco esterno** persistente.

---

## 💾 Persistenza su Disco / Volume Esterno

Tutti i dati dell'applicazione (database SQLite/PostgreSQL embedded, conversazioni, organigramma aziendale degli agenti e workspace di lavoro) sono mappati dal container `/paperclip` verso la cartella specificata nella variabile:

```bash
PAPERCLIP_DATA_DIR="/mnt/Dati4/paperclip_data"
```

* **Vantaggi del volume esterno:**
  * Puoi arrestare, aggiornare o distruggere il container Docker in qualsiasi momento senza perdere né configurazioni né storico.
  * Puoi impostare qualsiasi partizione o hard disk esterno montato sul sistema (es. `/mnt/Dati4/...`, `/media/...` o disco USB).
  * È facilissimo eseguire backup completi semplicemente copiando tale directory.

---

## 📁 Struttura della Cartella

```text
Scripts/docker_paperclip/
├── .env.example        # Template di configurazione (porte, percorsi, API keys)
├── .env                # File di configurazione locale attivo (ignorato da Git)
├── docker-compose.yml  # Configurazione del container con mapping del volume esterno
├── start_paperclip.sh  # Script di avvio automatico (crea .env e genera secret se assenti)
├── stop_paperclip.sh   # Script per fermare il container senza perdere dati
├── status_paperclip.sh # Script per verificare stato container, spazio occupato e log
└── README.md           # Questa documentazione
```

---

## 🚀 Utilizzo Rapido

### 1. Avvio (primo avvio e avvii successivi)
Dalla cartella principale del repository:
```bash
./Scripts/docker_paperclip/start_paperclip.sh
```

Lo script si occupa automaticamente di:
1. Verificare che Docker sia installato e attivo.
2. Generare il file `.env` a partire da `.env.example` (se non presente).
3. Generare in modo sicuro i token crittografici necessari (`BETTER_AUTH_SECRET`, `PAPERCLIP_TOOL_ACTION_SIGNING_SECRET`) preservandoli per i riavvii successivi.
4. Creare la directory del volume esterno se non ancora esistente.
5. Avviare il container in background (`ghcr.io/paperclipai/paperclip:latest`).

### 2. Accesso alla Dashboard Web
Una volta avviato, apri il browser su:
👉 **`http://localhost:3142`** *(o la porta configurata nel file `.env`)*

*(In ambiente Docker è attiva la modalità `authenticated` con account amministratore locale).*

### 3. Configurazione API Keys (Opzionale ma consigliato)
Per consentire agli agenti di interagire con i modelli linguistici:
1. Apri `Scripts/docker_paperclip/.env`:
   ```bash
   nano Scripts/docker_paperclip/.env
   ```
2. Valorizza la tua chiave (es. `ANTHROPIC_API_KEY="sk-ant-..."` o `OPENAI_API_KEY="sk-..."`).
3. Riavvia con `./Scripts/docker_paperclip/start_paperclip.sh`.

### 4. Collegamento Account Locale Claude Code (Per il futuro)
Quando colleghi un account Claude locale e Paperclip richiede l'autenticazione generando un comando del tipo:
```bash
export CLAUDE_CONFIG_DIR='/paperclip/instances/default/ai-local-logins/<SESSION_ID>' && mkdir -p "$CLAUDE_CONFIG_DIR" && claude auth login
```
Il percorso indicato `/paperclip/...` è quello interno al container. Sul tuo computer fisico corrisponde al percorso del volume esterno montato:

* **Se hai già Claude configurato sul tuo PC** (`~/.claude/.credentials.json`), puoi copiare direttamente le credenziali esistenti senza rifare il login:
  ```bash
  mkdir -p "/mnt/Dati4/paperclip_data/instances/default/ai-local-logins/<SESSION_ID>"
  cp ~/.claude/.credentials.json "/mnt/Dati4/paperclip_data/instances/default/ai-local-logins/<SESSION_ID>/.credentials.json"
  ```
* **Oppure esegui il login Claude sul PC** puntando alla cartella del volume esterno:
  ```bash
  export CLAUDE_CONFIG_DIR="/mnt/Dati4/paperclip_data/instances/default/ai-local-logins/<SESSION_ID>"
  mkdir -p "$CLAUDE_CONFIG_DIR"
  claude auth login
  ```
  Dopo aver fatto questo, premi il pulsante di verifica / conferma nella dashboard web di Paperclip.

### 5. Come passare (Switch) tra Claude Pro e ANTHROPIC_API_KEY

In Paperclip puoi scegliere liberamente se far lavorare gli agenti con il tuo **abbonamento Claude Pro** (senza costi extra, ma con i limiti orari di Claude) oppure con l'**API Key a consumo** (pay-per-token su console.anthropic.com, senza limiti orari):

| Caratteristica | Claude Pro (Subscription) | Anthropic API Key |
| :--- | :--- | :--- |
| **Adapter/Harness** | `claude_local` (Claude Code) | `anthropic` (Direct API) |
| **Autenticazione** | Token OAuth (`~/.claude/.credentials.json`) | `ANTHROPIC_API_KEY="sk-ant-api03-..."` o `"sk-ant-usr-..."` |
| **Fatturazione** | Inclusa nell'abbonamento mensile Pro | Credito prepagato su Anthropic Console |
| **Limiti** | Limite di messaggi/sessione ogni 5 ore | Limiti di token API molto più ampi |

#### 🔄 Come effettuare il cambio (Switch):

##### Opzione A: Dalla Dashboard Web (Consigliato per Agente)
1. Apri la Web UI su `http://localhost:3142`.
2. Vai su **Agents** e seleziona l'agente desiderato (es. *CEO*, *Coder*, ecc.) -> Clicca su **Settings** / **Edit**.
3. Nella sezione **Model & Connection**:
   - **Per usare Claude Pro:** imposta l'Adapter su **Claude Code (Local)** (`claude_local`) collegato alla connessione locale.
   - **Per usare l'API Key:** imposta l'Adapter su **Anthropic** e seleziona la tua API Key (o inseriscila nel campo apposito).
4. *(A livello globale per tutta l'azienda)*: Vai su **Company Settings** -> **AI Connections** e clicca su **"Set as Default"** sulla connessione che preferisci come predefinita.

##### Opzione B: Tramite file `.env`
1. Modifica il file `Scripts/docker_paperclip/.env`:
   ```bash
   # Inserisci una chiave valida da console.anthropic.com (prefisso sk-ant-usr-... o sk-ant-api03-...)
   ANTHROPIC_API_KEY="sk-ant-usr-..."
   ```
2. Riavvia Paperclip per applicare la nuova variabile d'ambiente:
   ```bash
   ./Scripts/docker_paperclip/start_paperclip.sh
   ```
Gli agenti configurati con l'adapter `anthropic` utilizzeranno immediatamente i crediti dell'API Key.


In alternativa
- connectors -> aggiungere la key
- per ogni agente -> agente -> "Harness / Runtime" e poi selezionare la key corretta



---

## ⚙️ Gestione del Ciclo di Vita

### Verifica dello Stato e dei Log
```bash
./Scripts/docker_paperclip/status_paperclip.sh
```
Mostra se il container è `Up`, quanto spazio disco occupa il volume esterno e gli ultimi log.

### Arresto del Container
```bash
./Scripts/docker_paperclip/stop_paperclip.sh
```
Arresta il container in modo pulito. **Tutti i dati rimangono intatti nel volume esterno.**

---

# < AlNao />
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
