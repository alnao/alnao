# GitHub Copilot

In questo documento sono elencati e descritti esempi di utilizzo di GitHubCopilot

## Cos'è GitHub Copilot
GitHub Copilot è un assistente di programmazione basato su intelligenza artificiale che aiuta a scrivere codice e documentazione direttamente nell'editor. Analizza il contesto dei file aperti e propone suggerimenti completi o parziali, accelerando lo sviluppo e riducendo il lavoro ripetitivo.


Necessario avere un profilo GitHub e un abbonamento al servizio [GitHub Copilot Pro](https://github.com/copilot/).




## Elenco esempi

**GitHub Copilot Cli**
- `copilot -h` per il dettaglio di tutti i parametri della cli di copilot!
- Creazione di un semplice file
  ```bash
  copilot -i "genera un file prova.py con dentro un metodo python per generare un numero casuale da 1 a 100" --model gpt-5 --allow-all-tools --add-dir ~
  ```

**Python**
- Esempio base di SDK *- coming soon*
- Esembio di esecuzione in una immagine docker *- coming soon*
- Esempio di Ralph-AI system eseguito in una immagine per eseguire  *- coming soon*

**Node.Js**
- **☁️ GitHub Copilot SDK - esempio** [`📁`](./GitHubCopilotSDK_1Simple/) - esempio di utilizzo di GitHub Copilot SDK per la chiamata agli engine di Copilot
  - Tecnologie: Copilot SDK, Node.js - sviluppato a gennaio 2026
  - Fonte: [Copilot SDK - Getting Started](https://github.com/github/copilot-sdk/blob/main/docs/getting-started.md)
- **☁️ GitHub Copilot SDK - tools** [`📁`](./GitHubCopilotSDK_2Tools/) - esempio di utilizzo di GitHub Copilot SDK per la chiamata agli engine di Copilot e sviluppo di tools specifici che iteragiscono con gli engine
  - Tecnologie: Copilot SDK, Node.js - sviluppato a gennaio 2026
  - Fonte: [Copilot SDK - Add a custom tool](https://github.com/github/copilot-sdk/blob/main/docs/getting-started.md#step-4-add-a-custom-tool)



## Reference
- GitHub Cli
  - installabile su Debian 13 con il comando `apt install gh` e poi `gh auth status`
- [GitHub Copilot Pro](https://github.com/copilot/), necessario per l'esecuzione di questi esempi!
- [Copilot SDK - getting started](https://github.com/github/copilot-sdk/blob/main/docs/getting-started.md)
- [Copilot CLI](https://github.com/features/copilot/cli)
  - installabile su Debian 13 con il comando `npm install -g @github/copilot`
  - oppure `curl -fsSL https://gh.io/copilot-install | bash`



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
