# Git annotations by AlNao

**Git** è il sistema di controllo versione distribuito più utilizzato al mondo. Questo README serve come promemoria per l'uso di Git.   

Per la documentazione completa e approfondita si rimanda al [sito ufficiale di Git](https://git-scm.com/doc) e al libro gratuito [Pro Git](https://git-scm.com/book/it/v2) disponibile anche in lingua italiana.


- Installazione e configurazione
    - configurazione utente
        ```bash
            $ git config --global user.name "Il Tuo Nome"
            $ git config --global user.email "[EMAIL_ADDRESS]"
        ```
    - altre configurazioni utili da eseguire una sola volta:
        ```bash
            # Impostare l'editor di testo preferito per i messaggi di commit
            $ git config --global core.editor "nano"
            # Abilitare la colorazione dell'output per migliorare la leggibilità
            $ git config --global color.ui auto
            # Impostare il nome del ramo predefinito a "main" (standard moderno)
            $ git config --global init.defaultBranch main
        ```
    - Per verificare la configurazione corrente:
        ```bash
            $ git config --list
        ```
    - Per clonare un repository esistente da un server remoto:
        ```bash
            $ git clone https://github.com/utente/repository.git
        ```
        Il comando `clone` scarica l'intero repository, inclusa tutta la cronologia, e configura automaticamente il collegamento con il server remoto.
- Gestione dei file e Commit
    - Per controllare lo stato corrente del repository, cioè quali file sono stati modificati, aggiunti o rimossi:
        ```bash
            $ git status
        ```
    - Per aggiungere file alla staging area (prepararli per il commit):
        ```bash
            # Aggiungere un singolo file
            $ git add nomefile.txt
            # Aggiungere tutti i file modificati e nuovi
            $ git add .
            # Aggiungere tutti i file con una certa estensione
            $ git add *.py
        ```
    - Il commit è l'operazione fondamentale di Git: salva permanentemente nel repository lo stato corrente della staging area, creando un punto nella cronologia a cui è sempre possibile tornare. Ogni commit è identificato da un hash univoco (una stringa esadecimale di 40 caratteri) e contiene le informazioni sull'autore, la data e un messaggio descrittivo.
        ```bash
            # Commit con messaggio inline
            $ git commit -m "Descrizione delle modifiche effettuate"
            # Commit aggiungendo automaticamente tutti i file modificati (ma non quelli nuovi)
            $ git commit -a -m "Aggiornamento file esistenti"
            # Modificare l'ultimo commit (utile per correggere il messaggio o aggiungere file dimenticati)
            $ git commit --amend -m "Messaggio corretto"
        ```
- Visualizzare la cronologia
    ```bash
        # Log completo
        $ git log
        # Log compatto (una riga per commit)
        $ git log --oneline
        # Log con grafico dei branch
        $ git log --oneline --graph --all
        # Log degli ultimi N commit
        $ git log -n 5
        # Differenze tra working directory e staging area
        $ git diff
        # Differenze tra staging area e ultimo commit
        $ git diff --staged
        # Differenze tra due commit specifici
        $ git diff abc1234 def5678
    ```
- Branch (rami) sono una delle funzionalità più potenti di Git. Il branch predefinito si chiama `main` (o `master` nei repository più vecchi). 
    ```bash
        # Elencare tutti i branch locali
        $ git branch
        # Elencare tutti i branch (locali e remoti)
        $ git branch -a
        # Creare un nuovo branch
        $ git branch nome-branch    
        # Spostarsi su un branch esistente
        $ git checkout nome-branch
        # Creare un nuovo branch e spostarsi immediatamente su di esso
        $ git checkout -b nome-branch
        # Rinominare il branch corrente
        $ git branch -m nuovo-nome
        # Eliminare un branch (solo se già unito al branch corrente)
        $ git branch -d nome-branch
        # Eliminare un branch forzatamente (anche se non unito)
        $ git branch -D nome-branch
    ```
- Merge e risoluzione dei conflitti
    - Il **merge** è l'operazione che unisce le modifiche di un branch in un altro. Per unire un branch nel branch corrente:
        ```bash
            # Spostarsi sul branch di destinazione (es: main)
            $ git checkout main
            # Unire il branch di sviluppo
            $ git merge nome-branch
        ```
    - Se Git non riesce a unire automaticamente le modifiche (perché lo stesso file è stato modificato in entrambi i branch nella stessa zona), si verifica un **conflitto**. In questo caso Git segna i file in conflitto con dei marcatori speciali:
        ```
            <<<<<<< HEAD
            Codice presente nel branch corrente
            =======
            Codice presente nel branch da unire
            >>>>>>> nome-branch
        ```
    - Per risolvere il conflitto bisogna modificare manualmente il file, scegliendo quale versione mantenere (o combinando entrambe), rimuovere i marcatori e poi completare il merge:
        ```bash
            $ git add file-risolto.txt
            $ git commit -m "Risolto conflitto nel file file-risolto.txt"
            ```
- Repository remoti sono versioni del progetto ospitate su un server (come GitHub, GitLab o Bitbucket) che permettono la collaborazione tra più sviluppatori.
    ```bash
        # Visualizzare i remote configurati
        $ git remote -v
        # Aggiungere un remote
        $ git remote add origin https://github.com/utente/repository.git
        # Rinominare un remote
        $ git remote rename origin upstream
        # Rimuovere un remote
        $ git remote remove origin
    ```
- Per sincronizzare il lavoro con il server remoto:
    ```bash
        # Scaricare le modifiche dal server remoto e unirle al branch corrente
        $ git pull origin main
        # Caricare i propri commit sul server remoto
        $ git push origin main
        # Caricare un nuovo branch sul server remoto
        $ git push -u origin nome-branch
        # Scaricare le informazioni dal remoto senza unire (solo aggiornamento dei riferimenti)
        $ git fetch origin
    ```
- Tag: etichettare le versioni
    - I **tag** servono per contrassegnare punti specifici nella cronologia, tipicamente usati per le release:
        ```bash
            # Creare un tag leggero
            $ git tag v1.0.0
            # Creare un tag annotato (consigliato, include messaggio e metadati)
            $ git tag -a v1.0.0 -m "Rilascio versione 1.0.0"
            # Elencare tutti i tag
            $ git tag
            # Caricare i tag sul server remoto
            $ git push origin --tags
            # Eliminare un tag locale
            $ git tag -d v1.0.0
            # Eliminare un tag remoto
            $ git push origin --delete v1.0.0
        ```
- Annullare le modifiche
    ```bash
        # Scartare le modifiche di un file nella working directory (ripristinare l'ultima versione committata)
        $ git checkout -- nomefile.txt
        # Rimuovere un file dalla staging area (annullare git add) mantenendo le modifiche
        $ git reset HEAD nomefile.txt

        # Annullare l'ultimo commit mantenendo le modifiche nella working directory
        $ git reset --soft HEAD~1

        # Annullare l'ultimo commit e rimuovere le modifiche dalla staging area
        $ git reset --mixed HEAD~1

        # Annullare l'ultimo commit e scartare completamente le modifiche (ATTENZIONE: irreversibile!)
        $ git reset --hard HEAD~1

        # Creare un nuovo commit che annulla le modifiche di un commit specifico (sicuro per repository condivisi)
        $ git revert abc1234
    ```
    - ⚠️🔶 $\textcolor{orange}{\textsf{Nota importante}}$: il comando `git reset --hard` è **irreversibile** e cancella definitivamente le modifiche non committate, usarlo con estrema cautela soprattutto su branch condivisi con altri sviluppatori 🔶⚠️

- Cambio label commit passate
    - eseguire il comandi log per avere l'elenco completo 
        ```bash
        git log --oneline -10
        ```
        ritorna elenco dellec ommit
        ```
		1 a4d2990 (HEAD -> master, origin/master, origin/HEAD) Paths Games V1 - Step 06: Naming Conventions
		2 4129c63 Paths Games V1 - Website creation
		3 095101c Paths Games V1 - Step 05: Define backend module structure
		4 a690ad2 AlNao Paths Game V1 - Step04: Tecnology stack definition
		5 74c6be0 AlNao Paths Game V1 - Step 03: Scope Definition
		6 5e1e44a AlNao Paths Game V1 - Step 02: Create the repository
		7 05eddf2 AlNao Paths Game creating project and step1
		8 2ad608e Initial commit
        ```
    - eseguire il comando rebase in interattivo (dove 8 è il numero di commit da andare indietro)
        ```bash
        git rebase -i HEAD~8 		
        ```
        - nell'editor cambiare, per ogni riga, il valore da `pick` → `reword` per le sole righe che si vogliono modificare
        - per ogni riga modificata al punto precedente, si apre l'editor nano per cambiare la descrizione del commit
    - eseguire il comando push forzato
        ```bash
        git push --force-with-lease origin master
        ```
- Spostare commit da git sorgente ad uno destination, per spostare tutta la storia delle commit
    ```bash
	git remote add destination git@github.com:nomedestination/destination.git
	git fetch destination
	git checkout master
	git push destination --mirror
	gh repo clone nomedestination/destination
    ```

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
