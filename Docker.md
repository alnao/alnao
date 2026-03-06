# Docker annotations by AlNao

Docker è una piattaforma open source che permette di creare, distribuire ed eseguire applicazioni all'interno di container. I container sono ambienti isolati che contengono tutto il necessario per eseguire un'applicazione, inclusi il codice, le librerie, le dipendenze e gli strumenti di sistema. 

Per la documentazione completa e approfondita si rimanda al [sito ufficiale di Docker](https://docs.docker.com/).


- **Avvio immagini**
    ```bash
    # Per avviare un container da un'immagine Docker:
    docker run -d -p 8080:80 --name my-container my-image
    # Per avviare un container da un'immagine Docker in modalità interattiva:
    docker run -it --name my-container my-image
    # Per avviare un container da un'immagine Docker in modalità batch:
    docker run -d --name my-container my-image
    ```

- **Esempio applicativi via docker**
    - openproject:
    	```bash
		docker volume create openproject-data
		docker run -d \
		  -p 8050:80 \
		  -v openproject-data:/var/openproject/assets \
		  -e SECRET_KEY_BASE=supersegreta \
		  -e OPENPROJECT_HOST__NAME=IP_PUBBLICO \
		  -e OPENPROJECT_HTTPS=false \
		  openproject/openproject:17
		```
        - per poi accedere a `http://IP_PUBBLICO:8050/login` con credenziali `admin admin` 



- **Dockerfile**: Un Dockerfile è un file di testo che contiene una serie di istruzioni per creare un'immagine Docker. Le istruzioni sono eseguite in ordine, dall'alto verso il basso, e ogni istruzione crea un nuovo layer nell'immagine. 
    - Esempio di Dockerfile per una applicazione Node.js
        ```dockerfile
        FROM node:18
        WORKDIR /app
        COPY package*.json .
        RUN npm install
        COPY . .
        EXPOSE 3000
        CMD ["npm", "start"]
        ```


- **Pulizia ambiente**
    ```bash
    # Per rimuovere tutti i container fermi:
    docker container prune
    # Per rimuovere tutti i volumi non utilizzati:
    docker volume prune
    # Per rimuovere tutte le immagini non utilizzate:
    docker image prune
    # Per rimuovere tutte le reti non utilizzate:
    docker network prune
    # Per rimuovere tutti i container fermi, volumi non utilizzati, immagini non utilizzate e reti non utilizzate:
    docker system prune
    ```

- **Postgresql**
    ```bash
    docker run --name postgres-local \
    -e POSTGRES_DB=pathsgames \
    -e POSTGRES_USER=dbuser \
    -e POSTGRES_PASSWORD=dbpassword \
    -p 5432:5432 \
    -d postgres:latest
    ```
    Spiegazione parametri:
    - `--name postgres-local`: nome del container
    - `e POSTGRES_DB=pathsgames`: crea il database pathsgames
    - `e POSTGRES_USER=dbuser`: utente personalizzato (default: postgres)
    - `e POSTGRES_PASSWORD=dbpassword`: password dell'utente
    - `p 5432:5432`: mappa la porta 5432 del container su localhost:5432
    - `d`: esegue in background
    - `postgres:latest`: immagine ufficiale PostgreSQL




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
