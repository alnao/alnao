# Wordpress 

*Writted by AlNao*. Questo README raccoglie una selezione di articoli tecnici originariamente pubblicati nella vecchia versione del blog personale [alnao.it](https://www.alnao.it). Sono riproposti in formato Markdown per conservarli e renderli facilmente consultabili. Alcuni contenuti potrebbero essere datati, ma possono ancora fornire spunti e soluzioni interessanti. Tutti gli articoli sono distribuiti sotto licenza *GNU GPL-3.0*, salvo diversa indicazione.


## Indice
- [WordPress](#Introduzione-a-WordPress)
  - [Come installare un sito WordPress](#Come-installare-un-sito-WordPress)
  - [Come gestire un sito WordPress](#Come-gestire-un-sito-WordPress)
  - [Come installare un tema WordPress](#Come-installare-un-tema-WordPress)
  - [Come gestire i plugin WordPress](#Come-gestire-i-plugin-WordPress)
  - [Come gestire i widget WordPress](#Come-gestire-i-widget-WordPress)
  - [Come gestire gli aggiornamenti di WordPress](#Come-gestire-gli-aggiornamenti-di-WordPress)
  - [Quali sono i principali Plugin di WordPress parte 1](#Quali-sono-i-principali-Plugin-di-WordPress-parte-1)
  - [Quali sono i principali Plugin di WordPress parte 2](#Quali-sono-i-principali-Plugin-di-WordPress-parte-2)
- [Come sviluppare un tema parte 1](#Come-sviluppare-un-tema-parte-1)
  - [Come sviluppare un tema parte 2](#Come-sviluppare-un-tema-parte-2)
  - [Come sviluppare un tema parte 3](#Come-sviluppare-un-tema-parte-3)


## Introduzione a WordPress


WordPress è la piattaforma open-source più popolare al mondo per la creazione di siti web e blog. Nato nel 2003 come semplice sistema per la gestione di blog, si è evoluto in un vero e proprio Content Management System (CMS) capace di gestire qualsiasi tipo di sito: dal portfolio personale all’e-commerce, dal sito aziendale al portale di notizie. La forza di WordPress risiede nella sua semplicità d’uso e nella grande flessibilità: grazie a migliaia di temi e plugin gratuiti o a pagamento, è possibile personalizzare ogni aspetto grafico e funzionale del proprio sito senza dover scrivere codice. Tuttavia, per chi desidera andare oltre le funzionalità di base, WordPress offre anche un’architettura solida e documentata che permette agli sviluppatori di creare soluzioni su misura.

WordPress è scritto in PHP e utilizza un database MySQL o MariaDB. Può essere installato facilmente su qualsiasi server web e, grazie a una vasta community internazionale, offre supporto, aggiornamenti costanti e una documentazione completa. La gestione dei contenuti avviene tramite un’interfaccia amministrativa intuitiva, accessibile da qualsiasi browser. Per poter usare e personalizzare la grafica del sito non è necessario avere conoscenze di HTML e CSS ma, senza queste conoscenze, sarà inevitable adattarsi ai temi già pronti senza la possibilità di modifiche. Per poter modificare il tema grafico o componenti è necessario conoscere i linguaggi front-end mentre non è necessario conoscere SQL in quanto il framework non lo usa (è più corretto dire che viene usato solo in casi particolari come nei plugin evoluti). Il framework è studiato per tutti i browser e tutte le piattaforme e usa pochissimo Javascript, che viene usato solo in plugin molto evoluti.

In questi articoli non sono trattati argomenti sistemistici come la configurazione del web server, tuttavia si faranno riferimenti utili all'uso, si rimanda alla documentazione ufficiale per approfondimenti. Per poter creare un sito e usare WordPress, è necessario avere a disposizione un server web, come Apache, presso un hosting come Aruba o AWS-Lightsail oppure un server installato nel proprio computer come XAMPP per i sistemi Ms Windows. I costi del dominio e dell'hosting posso variare in base al servizio scelto, è possibile scegliere anche l'hosting ufficiale di wordpress che ha costo zero ma sono legati al dominio principale: i siti generati sono del tipo alnao.wordpress.com.

Per il corretto funzionamento di un server con WordPress è indispensabile anche disporre di un server MySql o un database compatibile e ed è indispensabile che il server web riesca a collegarsi al server database tramite la porta predefinita del secondo, senza questo collegamento il sito non sarà funzionante. Si rimanda alla documentazione di MySql per tutte le informazioni riguardo all'installazione e alla configurazione del server, se si è scelto un hosting specifico (come Aruba oppure Lightsail) è possibile aggiungere il database in fase di registrazione o configurazione.

Per le fasi di sviluppo, è possibile usae un qualsiasi editor di testo anche se è consigliato l'uso di ambiente di sviluppo (IDE) come Visual Studio Code di Microsoft, ATOM oppure Eclipse per Php. Si consiglia anche l'uso di un repository come GIT per salvare il codice sviluppato, si sconsiglia di salvare nel repository tutto il framework ma è consigliato salvare solo il codice sviluppato del tema e di eventuali plugin.

## Come installare un sito WordPress
Installare WordPress può sembrare un compito arduo soprattutto ad un utente novizio ma, seguendo dei semplici passi diventerà un gioco da ragazzi. Per prima cosa bisogna identificare l'hosting dove il sito verrà eseguito e nello specifico bisogna disporre di alcune informazioni base:

accesso alla cartella root del server web con delle credenziali specifiche con permessi di scrittura, per esempio usando sftp (ftp è considerato deprecato ma comunque è utilizzabile)
accesso ad un server MySql con delle credenziali specifiche, bisogna anche conoscere la porta di accesso (che di solito è 3306) e bisogna creare un database
accesso tramite https al server web (http è considerato deprecato ma comunque è utilizzabile)
Per procedere con l'installazione è necessario scaricare la versione più recente di WordPress, è consigliato usare il sito ufficiale e la pagina dedicata, è possibile  scarica dalla pagina dedicata un file compresso zip, successivamente bisogna caricare il contenuto non compresso nella cartella root del sito (per esempio tramite ftp/sftp).

Una volta copiato il contenuto del pacchetto sarà già possibile accedere al sito da browser e dovrebbe avviarsi la procedura guidata che chiederà alcune informazioni base:
- database: utente, password, hosting e nome database
- titolo del sito
- indirizzo url base del sito
- utente e password dell'amministratore principale
- mail di servizio

Una volta inseriti questi dati, al procedura guidata procederà con la creazione nel database tutte le tabelle indispensabili al framework e verrà configurato il file base
```
wp_config.php
```
dove sono salvate le informazioni base inserite dall'utente, bisogna sempre tenere controllato questo file ma non dovrebbe mai essere modificato manualmente se non strettamente necessario.

Il primo accesso come amministratore può essere eseguita dalla pagina di login
```
<sito>/wp-admin/
```
che risulta essere la pagina di acceso di default, modificabile grazie ad un plugin molto utile che verrà introdotto nei prossimi articoli.



La pagina amministrativa presenta nella sinistra le varie voci con le quali è possibile gestire: post, media, pagine, commenti, plugin, utenti e impostazioni. Ogni sezione è dedicata ad un argomento specifico.

## Come gestire un sito WordPress
WordPress è un framework studiato per gestire contenuti in maniera dinamica con la possiblità di personalizzare le varie parti del sito, in inglese questo tipo di applicazioni sono chiamati CMS (Content management system).



Le pagine di WordPress vengono generalmente utilizzate per contenuti come di presentazione ed esposizione di contenuti statici ma, grazie ai vari componenti aggiuntivi, è possibile renderli dinamici. I componenti che fanno parta del framework e che possono personalizzare l'aspetto grafico e il comportamento del sito sono:

- articoli (detti anche post in lingua inglese): inizialmente il framework è stato pensato per i blog personali e aziendali quindi la base del CMS è l'elenco degli articoli, organizzati in categoria e tag sono sempre visulizzati con la data di pubblicazione. Tipicamente la pagina di ingresso del sito mostra gli ultimi quattro articoli, comportamento personalizzabile nella sezione amministrativa. La creazione e la gestione degli articoli è centrata nella sezione amministrativa nella sezione dedicata, la procedur guidata di creazione di un nuovo post è molto semplice e intuitiva: 
- pagine: sono pagine statiche separate dalla pagina principale, non sono organizzati in categorie e tag ma sono gerarchiche e possono essere organizzati come figli di altre pagine, tipicamente sono accedibili solo dal menù delle pagine ma è possibile creare pagine senza punto di accesso da menù (come la pagina di cookies policy), le pagine sono statiche e senza plugin particolari non possono contenere contenuti dinamici come post o tabelle caricate da fonte dati
media: è un contenitore (chiamato anche wp-content) all'iterno della quale sono salvati immagini, documenti e altri tipi di files caricati per essere visualizzati in pagine e articoli
- temi: è il gestore dell'esposizione del sito, in maniera approssimata si potrebbe descrivere come il gestore della grafica ma in realtà ha anche lo scopo di aggiungere funzionalità al funzionamento base del framework, come i widget o stili css. Il framework preve che sia attivo solo un template, tuttavia è possibile scaricare più temi nella sezione di amministazione ed è possibile attivare un tema con un semplice click. Una semplice guida è disponibile nel sito ufficiale: Il lungo elenco di tutti i temi disponibili gratuitamente è disponibile nel nel sito ufficiale.
- plugin: sono piccoli o grandi porzione di codice studiati per modificare il comportamento del sito, non solo modifiche all'aspetto e alla grafica ma possono riguardare anche aspetti tecnici. La console permette di scaricare plugin dal repository ufficiale e attivarli con un semplice click, è possibile poi installare da pacchetto Zip nel caso di plugin acquistati da siti terzi o sviluppati in casa. L'elenco dei plugin disponibili nel resposity è consultabile nel sito ufficiale, in successivi articoli saranno elencati e descritti i principali plugin utili per un sito al giorno d'oggi.
- widget: sono componenti che permettono di gestire contenuti separati da singolo articolo o pagine, configurabili per essere visualizzati in punti specifici del sito (come la home page o il footer di tutte le pagine). Le aree dove i widget sono configurabili è definito nel tema che definisce il layout del sito.
Nella console è possibile gestire questi componenti tramite le sezioni dedicati, inoltre è presente personalizzare l'aspetto grafico in una sezione dedicata che permette di modificare il codice del tema attivo, nelle più recenti versioni di WordPress è disponibile anche una sezione evoluta per modificare il codice del tema attivo.


## Come installare un tema WordPress
Un tema di WordPress è una raccolta di file che modificano l'aspetto grafico e il funzionamento del sito controllando design, layout e lo stile. Installare e attivare un tema non modifica il contenuto del sito ma solamente l'aspetto quindi è possibile attivare e comabinare il tema attivo tema in tutta sicurezza anche più volte ricordando che solo un tema può essere attivo.

Per comprendere la differenza tra tema e plugin, si rimanda alla definizione indicata nella guida ufficiale:

- una tema controlla l'aspetto grafico del sito e dei contenuti
- un plugin controlla il comportamento del sito e dei contenuti

Nella console di amministrazione è possibile gestire i temi da una sezione della console di amministrazione:


In questa sezione è possibile scaricare dal sito ufficiale i temi ufficiali da un repository dove è possibile cercare e vedere anteprima dei siti, per semplice esempio di sito "hello world"


Per installare un tema in un sito basta accedere alla console amministrativa e nel menu "Aspetto" entrare nella sezione dedicata ai temi. Grazie ad una barra di ricerca è possibile cercare nello store ufficiale, nella ricerca è possibile anche filtrare i risultati secondo alcuni parametri e il risultato presenta un elenco con alcune informazioni del tema. L'installazione è immediata quando si preme il bottone "Installa" nel dettagli del tema, una volta installato è necessario attivarlo perché di default non viene attivato all'installazione, nelle versioni più recenti del framework è disponibile anche la funzionalità di "Anteprima" che permette di vedere in anteprima l'aspetto del sito con il tema selezionato.


L'attivazione è immediata e il cambio di tema da uno ad un altro non va a modificare in nessun modo i contenuti (come articoli e post) ma ovviamente le logiche del tema possono modificarne l'aspetto grafico. E' possibile anche installare manualmente un tema dalla funzionalità dedicata "Upload Theme", questa funzionalità può essere usata per installare temi acquistati da siti terzi oppure installare un tema sviluppato.

A titolo di esempio, cambiando al tema di questo sito, l'aspetto di questo articolo è:

## Come gestire i plugin WordPress

I plugin di WordPress sono componenti fondamentali per la personalizzazione di un sito, di default nessun plugin è installato visto che non sono componenti necessari ma se si vuole personalizzare il comportamento di un sito è indispensabile usare queste aggiunte che modificano il funzionamento aggiungendo alcune funzionalità specifiche. Come per i temi, anche per i plugin esiste un repository ufficiale dove è possibile cercare e scaricare plugin gratuiti e già pronti all'uso ma è anche possibile scaricare e installare plugin a pagamento distribuite da società specializzate.

Dalla console amministrativa è possibile installare un plugin dalla pagina di ricerca, una volta trovato il plugin scelto nella lista è possibile installarlo grazie al bottone "Install", pochi secondi dopo comparirà la conferma di installazione e il plugin sarà nella lista dei plugin installati nella pagina dedicata della console. Nella stessa pagina amministrativa è possibile disabilitare o abilitare un plugin installato, in questo modo è possibile avere molti plugin installati con la possibilità di "attivarli"/"disattivarli", questa operazione è quasi immediata e non mette off-line il sito in quanto i plugin non sono vitali per il funzionamento di un sito ma bisogna sempre ricordare che questi componenti modificano il funzionamento solo di specifiche parti.


Un plugin può avere una pagina di amministrazione specifica perché necessità di parametri o configurazioni specifiche, se questo è previsto nella console possono esserci delle voci di menù aggiuntive dedicate al plugin, in alcuni casi sono solo una voce semplice mentre i plugin più complessi possono persino creare dei menù dedicati con sotto-menù e alberature complicate. I più semplici possono invece non avere pagine dedicate ma solo piccoli parametri disponibili nella pagina settings o in altre parti delle pagine standard della console amministrativa di WordPress.

Se si dispone di un plugin a pagamento e/o scaricato da altri repository diverso da quello ufficiale è possibile caricarlo con il bottone "Upload plugin" nella vista dei Plugin, questa operazione è consigliata solo ad un utente esperto in quanto un plugin malevolo potrebbe fare danni molto grandi ad un sito, così come è consigliato installare solo plugin sicuri e fidati che hanno molte recensioni buone nel repository ufficiale, plugin con pessime recensioni sono da evitare.


I plugin più famosi e più usati saranno descritti in un fururo articolo, in altri articoli futuri sarà descritto il processo di sviluppo di un plugin per WordPress.

## Come gestire i widget WordPress
In in sito costruito con WordPress, i widget sono elementi di contenuti configurati al di fuori del flusso della pagina o del contenuto dei post/articoli ma sono contenuti statici. Nella maggior parte dei casi, i widget sono visualizzati in ogni pagina del sito ma è anche possibile registrare aree di widget per pagine specifiche come la homepage. La posizione di questi widget è definita dalle "aree di widget" definite nel tema, infatti questi componenti dipendono dai temi e dal layout ma non dal core centrale del framework: la maggior parte dei temi hanno aree widget in posti "normali" come l'header, la barra laterale e nel footer, anche se alcuni avranno più aree di widget in diversi posti, ad esempio sotto o sopra il contenuto o nell’intestazione.


L'utilizzo di questi dovrebbe essere limitato a pochi contenuti extra ad una o più pagine del sito, per esempio sono particolarmente utili per i contenuti costanti da visualizzare in ogni pagina di un sito sito. I widget più comuni sono:

- Recent Posts: per visualizzare l'elenco degli ultimi post inseriti, utile nei siti di tipo blog
- Recent Comments: per visualizzare l'elenco degli ultimi commenti inseriti nei post, utile per i siti di tipo blog
- Call To Action: funzionalità per contattare un call-center, utile nei i siti di tipo vedrina
- Topic: per visualizzare l'elenco degli argomenti principali, utile nei i siti contenuti di tipo diverso
- Media: per visualizzare gli ultimi media inseriti nel sito, utile nei i siti contenuti di tipo diverso
- Social Media: utile per permettere al visitatore di accedere ai social velocemente, sempre molto utile
- Carrello: utile per i negozi on line
- Widget di Contatto: utile per permettere al visitatore di accedere alle informazioni di contatto, sempre molto utile
- Widget di Accesso: utile per permettere all'utente di accedere ad una area riservata
- Widget di Ricerca: utile per permettere all'utente di effettuare una ricerca da ovunque si trovi nel sito
- L'attivazione e la configurazione di widget è possibile dalla funzionalità nella console-web, dove è disponibile una funzionalità che permette il "drag-and-drop" tra i widget dispnibili e le aree messe a disposizione dal tema attivo:

Le ultime versioni di wordpress prevedono una modalità "Customizer" (tradotto in italiano con "Edit del tema") con la quale è possibile gestire i widget da una interfaccia molto comoda e semplice:


A titolo di esempio, in questo sito sono censiti un paio di widget: uno nel footer per visualizzare un messaggio in tutte le pagine e un paio di elementi nella home-page nella zona a destra.

## Come gestire gli aggiornamenti di WordPress
Gli aggiornamenti di WordPress sono un tema importante da non sottovalutare: è sempre conveniente mantenere aggiornato il framework e tutti i plugin per ragioni di sicurezza. Infatti WordPress è un framework gratuito e anche open-source, ciò significa che tutti i programmatori del mondo possono scaricare il codice sorgente e analizzarlo, purtroppo anche i mal-intenzionati hanno questa possibilità e appena si scopre una vulnerabilità c'è l'altissimo rischio che venga usata, gli aggiornamenti il principale obbiettivo di risolvere i problemi di sicurezza quando vengono scoperti. In particolare, i plugin sono la parte di WordPress più soggetta a vulnerabilità e nemmeno quelli più popolari e seguiti da team di sviluppatori forti ne sono immuni, trattandosi di codice scritto da terzi esternamente hanno aggiornamenti meno frequenti.

Nella console web è presente una pagina dedicata agli aggiornamenti dove vengono visualizzate tutte le versioni del framework e dei plugin con la possibilità di procedere con gli aggiornamenti di tutti gli aggiornamenti con un click:

Il framework principale, detto spesso **core**, ha un aggiornamento separato visto che necessità di più tempo, da notare che durante gli aggiornamenti il sito viene disattivato e posto in uno stato di "manutenzione", infatti viene creato un file .maintenance che disattiva temporaneamente il sito, la modalità viene disattivata quando tutti gli aggiornamenti sono completati correttamente.

Oltre alla modalità manuale esiste una configurazione che permette di eseguire automaticamente gli aggiornamenti, delegando al framework l'ingrato compito di aggiornarsi scaricando gli aggiornamenti dal sito ufficiale in automatico, la guida ufficiale descrive i passi da compiere, questa modalità è consigliata per chi ha poca dimestichezza con il framework ma è sconsigliata per gli utenti esperto o i siti molto grossi che possono avere problemi causati dagli aggiornamenti, infatti è necessario concludere dicendo che non sempre gli aggiornamenti funzionano perfettamente e può capire che il comportamento del sito e il suo aspetto subisca variazioni indesiderate. In particolare è consigliato aggiornare una versione quando tutti i plugin dispongono aggiornamenti compatibili, in quanto può capitare che un plugin non venga aggiornato e che possa smettere di funzionare o creare problemi dopo l'aggiornamento del core del framework.

Come gestire siti WordPress multi-lingua
Vivendo in un mondo globale come internet, è quasi sempre necessario creare un sito che possa essere visto da utenti di paesi e lingue diverse. Ma allo stesso tempo, creare un sito web multilingue è una grande impresa: esistono moltissimi costruttori di siti Web intuitivi, ma c'è bisogno di strumenti che consentano di tradurre ogni contenuto, dal testo alle immagini, in diverse lingue.

La guida ufficiale di WordPress presenta quattro soluzioni possibile per la gestione del multilingua:
- post semplici (One Site, One Post): prevede che ogni contenuto abbia un unico post con all'interno il testo tradotto nelle varie lingue
post duplicati (One Site, Two Posts): prevede che ogni contenuto abbia un post per ogni lingua
- sito duplicato (Two Sites): prevede che esista una istanza di WordPress per ogni lingua e i contenuti vengano replicati in ogni istanza
- blocchi (Blocks): prevede che ogni contenuto abbia un unico post e che le traduzioni siano divisi in blocchi
La terza e la quarta tecnica prevedono la creazione siti o componenti paralleli che non verrà presa in considerazione in questo articolo in quanto molto complesse, impraticabili se non a livello professionale.

La tecnica dei post semplici viene introdotta anche nella pagina ufficiale del supporto che prevede che nello stesso articolo vengano scritte le versioni delle più lingue con dei Link-Anchor con la funzionalità degli editor di WordPress.

Questa tecnica è stata usata molto nei primi anni di vita del framework ma oggi è stata rimpiazzata dalla tecnica dei post duplicati. La tecnica dei post duplicati prevede che vengano creati post separati, uno per ogni lingua, e che vengano collegati tramite Categorie/Tag

Nel sito poi basta filtrare gli articoli per il tag creato e il sito apparentemente eredita la divisione tra lingue ma in realtà i contenuti diventano piatti e tutti gli articoli appartengono allo stesso sito nello stesso livello. Questa tecnica può essere usata solo in temi che supportano questo tipo di divisione con i filtri per Categoria in tutte le pagine altrimenti i contneuti delle varie lingue risulterebbeno mischiati.

WordPress mette a disposizione diversi plugin che permettono la gestione dei contenuti in più lingue, questi migliorano le tecniche ufficiali ed evitano di dover gestire tag, categoria o multi-siti. Dal sito ufficiale si possono trovare molti plugin utili, i più usati e famosi sono:

- gtraslate: che utilizza il servizio di traduzioni automatiche di Google per tradurre in tempo reale il testo di pagine ed articoli e mette a disposizione un semplice widget grafico per permettere all'utente di modificare la lingua del sito.
- WooCommerce: molto usato e integrato con un ecosistema di funzionalità per la creazione di siti commerciali.
translatepress: che permette di creare siti multilingua

Per un utente poco esperto può sembrare una cosa molto complessa, il consiglio è sempre quello di provare più soluzione e poi scegliere la tecnica e il plugin più adatti alle esigenze.

## Quali sono i principali Plugin di WordPress parte 1
Come già visto in diversi articoli, WordPress mette a disposizione una lista lista di plugin nel repository ufficiale, la maggior parte dei quali gratuita anche se la maggior parte dei plugin prevede una versione gratuita e una versione avanzata a pagamento. I plugin sono di diverse funzionalità e finalità, vista la numerosità può essere difficile trovare il plugin giusto a seconda delle esigenze di costruzione e spesso si fa fatica a trovare quello che serve.

Quando si usa il repository ufficiale o anche resposity di terzi bisogna sempre prestare attenzione a cosa si installa in un sito, i plugin più datati potrebbero non essere compatibili con le ultime versione del framework e, putroppo, alcuni plugin sono malevoli e possono creare danni. La via più semplice e sicura è scegliere i plugin non solo in base alla funzionalità ma anche al numero di utilizzi: se un plugin è usato da migliaia di utenti è considerabile più sicuro di un plugin usato da pochi utenti, il numero di utenti e il ranking di ogni plugin può essere notato direttamente nella lista dei plungin nella pagina di ricerca:


Questo articolo vuole essere una descrizione breve ma completa dei principali plugin disponibili per migliorare la sicurezza del sito e gestire le componenti base. Il consiglio è quello di prestare sempre attenzione alla sicurezza del sito: la sicurezza non deve mai essere trascurata quando si parla di siti web esposti pubblicamente e possibili bersagli di attacchi da parte di mala intenzionati:

Uno dei punti più vulnerabili di un sito costruito con il framework WordPress è la pagina di login della sezione amministrativa che di default è ```<dominio>/wp-admin```, grazie al plugin WPS Hide Login è possibile cambiare l'url di ingresso in modo da impostare un enpoint personalizzato. Grazie a questo plugin nel menù di amministrazione viene messa a disposizione una nuova voce nel sotto-menù "impostazioni" dove è possibile impostare l'url specifico.
Un'altro dei punti vulnerabili di un sito WordPress sono i servizi Rest, si tratta di servizi creati di default dal framework messi a disposizione per permettere la manutenzione del sito dall'esterno. Queste API sono esposte di default dal framework su alcuni url del sitocome ```https://<url-sito>/wp-json/wp/v2/``` e ```https://<url-sito>/wp-json/wp/v2/users```. Grazie al plugin Disable WP Rest API è possibile nascondere queste API e limitarne l'accesso solo agli utenti amministrativi che hanno effettuato la login alla sezione amministrativa.
Di default il framework permette di creare più utenti con ruoli specifici come amministratore o editor, il plugin PublishPress Permissions permette di aumentare le operazioni abilitate con la possibilità di autorizzare o negare funzionalità specifiche anche su elementi come singoli post o singole pagine, con questo è possibile creare un gruppo di autorizzazioni assegnando gli utenti e il plugin aggiunge un tab "Imposta le autorizzazioni specifiche" con la quale si può abilitare un gruppo specifico.

Esistono diversi modi per eseguire il backup di un sito fatto in wordpress: il metodo più semplice è quello di eseguire copia di tutte le due componenti. Per prima cosa bisogna eseguire una copia del databse mysql con il comando mysqldump e poi una copia dei file prendendo tutto il contenuto del filesystem dove è posizionato il sito. Questo metodo risolta molto veloce e semplice se il sito è di piccole di dimensioni. Un secondo metodo molto usato è eseguire il backup del db dalla console di amministrazione, all'interno della voce "Strumenti" è presente una funzionalità di Backup che permette di copiare in sicurezza tutti i dati del dabatase senza l'uso del comando mysqldump, questo metodo sicuramente è indicato per chi non ha molta dimestichezza con i comandi da riga di comando del database. Il metodo più efficace tuttavia è l'uso di plugin dedicati, in particolare il Duplicator di Snap Creek è disponibile nella sezione plugin con una versione base gratuita. Il plugin aggiunge una sezione sezione nel menù, la funzionalità principale permette la gestione dei bakcup/pacchetti: oltre alla lista dei pacchetti creati, è possibile creare un nuovo pacchetto con una procedura guidata molto semplice e intuitiva. All'interno dei pacchetti creati, oltre ai componenti grafici e al database in formato sql, viene creato anche un file installer.php, utilizzabile per effettuare il ripristino del pacchetto con procedura guidata che in pochi passi permetterà di installare la copia nel sito con pochi click.
Talvolta è necessario cambiare l'url del sito web, questo può essere necessario non solo per un cambio di dominio ma anche in fase di copia di un sito da un dominio ad un altro. E' possibile usare il plugin duplicator per eseguire copia e ripristino di un sito ma una volta copiato il path generale del sito viene cambiato dal plugin ma eventuali link interni alle pagine e agli articoli non viene cambiato. Per eseguire il cambio su tutti gli articoli e su tutte le pagina è possibile usare il plugin Better Search Replace, nella unica pagina di questo plugin è possibile impostare i filtri di ricerca e di sostituzione come un cerca-sostituisci delle normali applicazioni desktop ma questa operazione viene effettuata nelle tabelle del sito.
Grazie ai plugin specifici come 301 Redirects – Easy Redirect Manager è possibile impostare le regole di Redirect con codice HTTP 301 e 302 direttamente da console, queste servono per oscurare una pagina temporaneamente oppure impostare regole per elementi rimossi o spostati, grazie a questo plugin è possibile vedere anche le varie statistiche e le regole in maniera molto intuitiva. Da notare che le questo tipo di regole possono essere configurate nei webserver ma non tutti hanno la possiblità di modificare i file di configurazione del webserver e spesso può risultare una cosa molto complessa e delicata, per questo è preferibile usare i plugin di WordPress.
Nelle ultime versione di WordPress gli utenti hanno a disposizione un editor avanzato chiamato WordPress Editor detto anche block editor, esiste anche una versione più semplice chiamata classic editor ed è possibile passare da una versione ad un'altra con un semplice bottone. Esiste il plugin Classic Editor che permette di definire l'editor classico come predefinito visto che il framework di default presenta sempre l'editor più recente.

## Quali sono i principali Plugin di WordPress parte 2
Questo articolo è la seconda parte di un precedente articolo: in questa serie sono elencati alcuni dei plugin più usati e indispensabili. Ovviamente si tratta di una lista ridotta dove sono descritti i plugin più utili, esistono tuttavia molti altri plugin disponibili, è sempre consigliato provare i plugin ma anche le alternative gratuite che spesso sono sufficienti per siti non professionali o di piccole dimensioni.

Questo elenco racchiude tutti i plugin utilizzabili per la gestione dei Cookies: bisogna sempre ricordare che esistono alcune normative iii abbastanza iii chiare riguardo alla gestione dei Cookies e degli adempimenti normativi che un sito deve rispettare, la principale normativa è il famoso regolarmente europeo GDPR, si rimanda al sito ufficiale del garante della privacy e alla pagina specifica riguardante la gestione cookies nei siti per maggiori dettagli.

Riassumendo, in poche righe e in maniera imprecisa, si può dire che è obbligatorio avvisare tutti i visitatori se il sito installa nel browser dei cookies indicando le finalità di tali informazioni e bisogna dare la possibilità all'utente di impedire il salvataggio e la rimozione di eventuali dati già salvati, inoltre è indicata la configurazione di una pagina dove viene spigato cosa sono i cookies, come e perché vengono salvati nel browser dell'utente.

Nota: questo è solo un articolo informativo e non una guida giuridica, potrebbe non essere precisa e potrebbe non essere al passo con eventuali aggiornamenti normativi, non si assumono responsabilità su eventuali imprecisioni e/o dimenticanze.


Esistono diverse tecniche e molti plugin disponibili, dai più semplici ai più complessi e professionali, in questo articolo sono esposte due tecniche:

Iubenda è il più famoso e usato in tutto il mondo, con questo plugin è possibile configurare i componenti come banner e la pagina informativa. Si rimanda al sito ufficiale per maggior informazioni.

Cookies policy di cookieyes è un plugin specifico per la gestione dei componenti necessari, si rimanda al sito ufficiale per tutte le informazioni, una volta installato è possibile collegare il wordpress con il sito di CookieYes per le configurazioni oppure è possibile usare la versione interna nella console amministrativa. Questa ultima prevede una una sezione specifica nel menu di amministrazione con alcune funzionalità specifiche: nella voce impostazioni è possibile abilitare il banner GDRP oppure il CCPA (per la policy Californiana), nella sezione "personalizza la barra" è possibile modificare il testo del banner con la possibilità di modificare anche gli stili e la posizione dei bottoni. Inoltre è possibile anche cambiare il tipo tra Banner, Popup oppure Widget. Con "personalizza i pulsanti" è possibile modificare lo stile e i testi dei vari pulsanti che si trovano nel sito mentre in "Guida di aiuto in linea" è possibile vedere alcuni meta-tag che è possibile nelle pagine. Nella voce di menù "elenco dei cookie" sono elencati i coockies presenti nel sito mentre su "categorie di cookie" sono elencate le categorie, per entrambe le liste è possibile modificare e aggiungere elementi inoltre è presente una funzionalità "Scansione Cookie" con la quale è possibile configurare la lista con un tool automatico. Sono presenti anche funzionalità di menù "Generatore della policy" e "Panoramica sulla privacy", che sono usati per la creazione delle pagine previste dal GDPR ma quelle pagine consiglio di crearle a mano come pagine del sito.


Inoltre esistono diversi plugin che permettono di interfacciarsi automaticamente con i servizi messi a disposizione da Google e da altri siti/social, per esempio è possibile gestire la configurazione per i motore di ricerca e le statistiche/analitics, si ricorda che per utilizzare questi servizi è necessario aver a disposizione utenze e configurazioni nei vari portali di come google serach e le google analitcs, con anche un google tag attivo nella console; senza queste non è possibile proseguire.

Esistono diversi plugin gratuiti scaricabili per la gestione dei servizi Google, i principali sono:

E' possibile configurare un Google TAG (GTM) all'interno di un sito WordPress. Tale tag può essere utile per una svariata di motivi e rimando alla documentazione ufficiale per un approfondimento del tema. All'interno di un sito è possibile scaricare il plugin bbb Google Tag Manager for WordPress bbb che è attualmente gratuito e molto usato, una volta installato bisogna sempre ricordarsi di attivarlo e nel menù impostazioni della sezione amministrativa del sito compare una nuova voce di menù "google tag manager". All'interno sono presenti diversi tab con diverse proprietà ma la più importante è il valore del "Google Tag Manager ID" dove l'amministratore può configurare il tag generato dalla console Google. Una volta impostato il valore del tag, questo viene attivato subito in automatico e basta usare la console di GTM per lo sviluppo grazie al tag specifico. Da notare che default anche questo plugin attiva il famoso SiteMap usato nella Google Search Console ma questo non dovrebbe andare in contrasto con il plugin già installato.
Il SiteMap è una pagina web o un file che contiene l'elenco di tutti i link per accedere a tutti i contenuti di un sito web. Lo standard XML dei SiteMap è stato definito da Google per facilitare e ottimizzare l'algoritmo crawler del motore di ricerca che, grazie alle informazioni contenute nel XML, può eseguire ricerche veloci ed efficenti. Con WordPress è possibile scaricare e attivare un plugin bbb XML Sitemap & Google News plugin bbb che genera automaticamente il xml di riferimento disponibile al link
```
<dominio>/sitemap.xml
```
all'interno del quale si possono trovare quattro sotto link: la root, elenco degli articoli, elenco delle pagine e informazioni sull'autore.
Il SEO (Search engine optimization) è un fattore fondamentale per la gestione di un sito visto che lo scopo dovrebbe essere l'aumento degli accessi grazie ad una migliore indicizzazione dei motori di ricerca, per questo è possibile scaricare e usare in plugin All In One SEO dallo store dei plugin, con questo si possono configurare la modalità di condivisione e il modo in cui le pagine del sito vengono esposte nei motori di ricerca e nei siti-social.
Per attivare la Console di Google Search del motore di ricerca, bisogna dimostrare a Google che si possiede effettivamente quel dominio, per evitare che i siti vengano collegati a console non autorizzate. La verifica della proprietà è possibile in diversi metodi: un file HTML statico nel sito, un tag HTML oppure un record record DNS. Dopo la verifica della proprietà nella console di GoogleSearch, sarà possibile configurare la site-map nella omonima voce di menù dove si deve inserire l'url del file xml che di solito si trova al file sitemap.xml. Si rimanda alla documentazione ufficiale per maggior dettagli riguardo alla Google search
In alternativa al Google TAG è possibile impostare direttamente le google Analitics, per questo bisogna scaricare e configurare un plugin specifico, per esempio il famoso Google Analytics for WordPress di MonsterInsights. Questo plugin crea la voce di menù Insights, all'interno della quale sono disponibili vari tab specifici e nella vista rapporti delle visite dove è possibile visualizzare le statistiche delle analitics di visite, non solo come dato aggregato ma anche come viste specifiche come la pagina più visitata. Nel sotto-menù impostazioni è possibile configurare il codice della GAv4 che attualmente è la versione più recente delle analitics, configurabile dalla console di google.  Nota: è bene ricordare che il rispetto della normativa europea sulla protezione dei dati e sulla privacy (RGPD & GDPR), è indispensabile attivare la funzionalità di anonimizzazione degli indirizzi IP dei visitatori del sito web, per attivar questa opzione basta accedere alle impostazioni e attivare la spunta alla voce "Anonymize IP Address" che di default è disattivata. 

## Come sviluppare un tema parte 1

Per creare un tema da zero partendo da un foglio bianco bisogna prima di tutto conoscere i linguaggi per la costruzione di pagine web, come HTML e CSS, inoltre è indispensabile conoscere anche il linguaggio script PHP: questo è il linguaggio con cui è scritto WordPress, senza queste conoscenze è impossibile iniziare a costruire un proprio tema e conviene cercare i temi già esistenti sullo "store" di WordPress. Un altro dettaglio da non trascurare è sono necessari i permessi di scrittura nel web-server per poter caricare e modificare i file dall'ambiente di sviluppo al server, senza questi permessi non sarà possibile proseguire. Questi articoli sono divisi in più step visto che la costruzione di un tema è sequenza di elementi da sviluppare. Per ogni dubbio si rimanda alla guida ufficiale disponibile al sito ufficiale.

Sviluppando un tema bisogna tener presente che iii tutti iii i temi di wordpress rispettano uno schema ben preciso: 
```
http://www.graphical.it/wp-content/uploads/2010/12/SCHEMA.jpg
```


Nello schema sono presentati gli elementi di un sito Worpdress: una testata, una coda, un contenuto centrale affiancato da una eventuale barra (destra o sinistra). Tutti i componenti del tema dovranno trovarsi in una cartella dedicata che dovrà essere posizionata nella cartella
```
/wp-content/themes/<nometema>
```
nel webserver che espone il sito. All'interno devono sempre essere spresenti almeno tre files:
- ```index.php```: file PHP principale del tema
- ```style.css```: file degli stili in formato css
- ```functions.php```: file PHP dove è possibile definire funzioni che modificano il comportamento del tema usando le funzionalità del framework WordPress.
Le prime righe del file CSS devono obbligatoriamente essere le informazioni riguardanti il tema, come standard è previsto un commento dove sono indicate le informazioni:
```
/*
Theme name: Primo alnao.it
Theme url: https://www.alnao.it
Description: Tema sviluppato da AlNao come primo esempio
Version: 1.0
Author: <a href="https://www.alnao.it" title="AlNao.it">AlNao.it</a>
Author url: https://www.alnao.it
Tags: first, clean, minimal
*/
```
Quando questi files vengono depositati all'interno di un sito WordPress nella cartella specifica themes, automaticamente nel menù Apparences alla voce Themes (rispettivamente Aspetto e Temi in italiano), sarà possibile trovare il tema elencato nella lista dei temi disponibili ma sarà assente la immagine di esempio (miniatura) ma saranno presenti le varie informazioni indicate nel file CSS come nome dell'autore e la breve descrizione del tema. Per configurare la miniatura è sufficiete creare un file immagine screenshot.png di esempio contenga la immagine di esempio del vostro tema e/o il logo, aggiungendola nella cartella del tema comparirà come miniatura nell'elenco dei temi.


Per maggior informazioni si rimanda alla documentazione ufficiale: infatti esiste un sito dedicato ai programmatori developer.wordpress.org che sviluppano temi e componenti per WordPress. In questa serie di articoli saranno descritti i principali passi per lo sviluppo di un tema, in altri articoli saranno descritti i passi per lo sviluppo di plugin e widget che necessitano di un conoscenze maggiori rispetto a quelle necessarie per lo sviluppo di un tema, si consiglia di saltare questa sezione se non si conoscono le basi di programmazione PHP.

## Come sviluppare un tema parte 2

Come visto nel precedente articolo e come descritto nella documentazione ufficiale, un tema WordPress è formato da tre files base ma questi sono sufficienti solo a creare una prima pagina, per attivare tutte le funzionalità del framework come gli articoli e le pagine, un tema ha bisogno files specifici per la visualizzazione e la gestione dei componenti. In questo articolo è necessario l'utilizzo del linguaggio PHP per lo sviluppo di componenti necessari: il framework mette a disposizione diverse funzionalità descritte nella documentazione ufficiale, il programmatore del tema deve implementare una serie di files base che devono rispettare una gerarchia prefissata:


I files principali obbligatori ed indispensabili per il funzionamento di un tema sono:
```
footer.php
functions.php
header.php
index.php
page.php
screenshot.png
sidebar.php
single.php
style.css
```
La lista completa dei files Php previsti dal framework è disponibile nel sito ufficiale, nella prima parte di questa guida sono stati introdotti il foglio di stile Css e allo screenshot parte dei files obbligatori, gli altri files vengono descritti in questa serie di articoli che presenterà un esempio di costruzione di un tema semplice con alcuni casi d'uso specifici.

Il primo file da gestire è il file index.php il quale descrive il funzionamento della pagina principale del sito, di default è sempre la prima pagina può anche essere l'unica presente. Un esempio funzionante può essere trovato nella documentazione ufficiale che presenta un esempi di codice:
```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="<?php bloginfo( 'charset' ); ?>">
    <title><?php wp_title( '|', true, 'right' ); ?></title>
    <link rel="stylesheet" href="<?php echo esc_url( get_stylesheet_uri() ); ?>" type="text/css" />
    <?php wp_head(); ?>
  </head>
  <body>
    <?php get_header(); ?>
    <h1><?php bloginfo( 'name' ); ?></h1>
    <h2><?php bloginfo( 'description' ); ?></h2>
    <?php if ( have_posts() ) : while ( have_posts() ) : the_post(); ?>
      <h3><?php the_title(); ?></h3>
      <?php the_content(); ?>
      <?php wp_link_pages(); ?>
      <?php edit_post_link(); ?>
    <?php endwhile; ?>
    <?php if ( get_next_posts_link() ) {
      next_posts_link();
    } ?>
    <?php if ( get_previous_posts_link() ) {
       previous_posts_link();
    } ?>
    <?php else: ?>
      <p>No posts found. :(</p>
    <?php endif; ?>
    <?php get_sidebar(); ?>
    <?php get_footer(); ?>
  </body>
</html>
```
Da questo primo esempio di codice si può notare subito la presenta di alcune chiamate a metodi php messi a diposizione del framework di WordPress, i principali sono:
- ```wp_title```: metodo per il recupero dell'informazione del titolo del sito
- ```get_stylesheet_uri```: metodo il recupero dell'url "assoluto" del foglio stile style.css
- ```wp_head```: metodo per il recupero e la stampa del tag head definito dal tema
- ```bloginfo```: metodo per il recupero delle informazioni del sito come il nome e la descrizione
- ```have_posts```: metodo per la verifica della presenza di post da visualizzare
- ```the_post``` e ```the_content```: metodi per il recupero delle informazioni dei post, questi metodo vengono richiamati all'interno di un ciclo chiamato loop, verranno approfonditi in un articolo dedicato
- ```edit_post_link```: metodo per il recupero e la visualizzazione del link che punta da un articolo alla sua pagina amministrativa, ovviamente non viene visualizzato nulla se non è eseguita la login amministrativa
- ```get_next_posts_link``` e ```get_previous_posts_link```: metodo per il recupero e la visualizzaione dei link verso altri post rispetto a quelli visualizzati
- ```get_header```, ```get_sidebar``` e ```get_footer```: metodi per la visualizzazione dei componenti header, sidebar e footer del tema, anche questi saranno approfonditi in un articolo dedicato
Si rimanda sempre alla documentazione ufficiale per maggiori dettagli.

## Come sviluppare un tema parte 3

Una delle più importanti funzioni messe a disposizione dal Framework è la funzione bloginfo: questa permette, all'interno di qualsiasi file php, di recuperare velocemente le informazioni base sul blog, senza dover scrivere nel codice nomi fissi o dover ogni volta cercare informazioni importanti. L’uso del metodo è semplice: l’unico parametro della funzione indica quale valore ritornare, per esempio:
```
<h1><?php bloginfo( 'name' ); ?></h1>
```
questo semplice codice “disegna” un tag HTML con al suo interno il nome del blog, tutti i valori ritornati sono quelli impostati nella parte amministrativa del sito. Le principali informazioni disponibili sono:

- name : restituisce il titolo del blog
- description : è il motto del blog
- url : l’indirizzo url
- rdf_url : l’url del feed RDF/RSS 1.0
- rss_url : l’url del feed RSS 0.92
- rss2_url : l’url del feed RSS 2.0
- atom_url : l’url del feed Atom
- pinback_url : l’url di pingback
- admin_email : l’indirizzo email dell’amministratore del blog
- charset : il tipo di Encode utilizzato
- version : la versione di WordPress installata
- wpurl : l’url dell’installazione di WordPress
- template_directory : l’url della directory del template in uso
- stylesheet_url : l’url del foglio di stile style.css
- stylesheet_directory : l’url della directory contenente il foglio di stile
Per una guida completa su bloginfo basta visitare il sito ufficiale.

Per permettere a un tema wordpress di caricare correttamente i vari plugin e tutti gli strumenti di amministrazione bisogna aggiungere nel tema due funzioni:

all'interno del tag ```<head>``` la funzione:
```
<?php wp_head() ?>
```
e alla fine del tag ```<body>``` la funzione
```
<?php wp_footer ?>
```
Queste sono necessarie per visualizzare le componenti grafiche del Framework come la barra di amministrazione.

Le indicazione di best practice consigliano, quasi obbligano, a dividere i template in pagine divise come visto in articoli precedenti: la pagina index deve essere divisa in più file, ogni file con funzioni specifiche e ben studiate, un semplice esempio è dividere la pagina principale in tre file:
- index.php
    ```
    <?php get_header(); ?>
    <div id="body">
    <?php get_sidebar(); ?>
    <div id="content">
        <?php if (have_posts()) : ?>
        <?php while (have_posts()) : the_post(); ?>
        <div class="post">
            <h2 id="post-<?php the_ID(); ?>"><a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title(); ?>"><?php the_title(); ?></a></h2>
            <small><?php the_time('F jS, Y') ?> <!-- by <?php the_author() ?> --></small>
            <div class="entry">
            <?php the_content('Read the rest of this entry »'); ?>
            </div>
            <p class="postmetadata">
            Posted in <?php the_category(', ') ?> 
            <strong>|</strong> 
            <?php edit_post_link('Edit','','<strong>|</strong>'); ?> 
            <?php comments_popup_link('No Comments »', '1 Comment »', '% Comments »'); ?>
            </p>
        </div>
        <?php endwhile; ?>
        <div class="navigation">
            <div class="alignleft"><?php posts_nav_link('','','« Previous Entries') ?></div>
            <div class="alignright"><?php posts_nav_link('','Next Entries »','') ?></div>
        </div>
        <?php else : ?>
        <h2 class="center">Not Found</h2>
        <p class="center"><?php _e("Sorry, something wrong."); ?></p>
        <?php endif; ?>
    </div>
    </div>
    <?php get_footer(); ?>
    ```
- header.php
    ```
    <?php /* www.alnao.it wordpress tema di esempio */ ?>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" <?php language_attributes(); ?>
    <head>
        <meta http-equiv="Content-Type" content="<?php bloginfo('html_type'); ?>; charset=<?php bloginfo('charset'); ?>" />
        <title><?php bloginfo('name'); ?> <?php wp_title(); ?></title>
        <meta name="generator" content="WordPress <?php bloginfo('version'); ?>" /> 
        <link rel="stylesheet" href="<?php bloginfo('stylesheet_url'); ?>" type="text/css" media="screen" />
        <script language="javascript" type="text/javascript" src="<?php bloginfo('stylesheet_directory'); ?>/js.js"></script>
        <?php wp_head(); ?>
    </head>
    <body>
        <div id="page">
        <div id="header">
            <div id="logo">
            <h1><a href="<?php echo get_option('home'); ?>">
                <?php bloginfo('name'); ?></a></h1>
            <h4><?php bloginfo('description'); ?></h4>
            </div>
            <div id="menu">
            <ul>
                <li><a href="<?php bloginfo('url'); ?>">Home</a></li>
                <?php wp_list_pages('depth=1&title_li='); // elenco pagine ?>
            </ul>
            <div class="clear"></div>
            </div>
        </div>
        <div class="clear"></div>
    ```
- footer.php
    ```
        <div class="clear"></div>
        <div id="footer">
            <div>
            <?php bloginfo('name'); ?> is proudly powered by
            <a href="http://wordpress.org">WordPress</a>
            </div>
        </div>
        </div>
        <?php //do_action('wp_footer'); ?>
        <?php wp_footer();?>
    </body>
    </html>
    ```
Questi tre file bastano per visualizzare il tema ma non permettono di usare le funzionalità di "page" e "articoli" del framework per il quali è indispensabile creare due file dedicati.

## Come sviluppare un tema parte 4
*coming soon o forse mai?!?*


# <span style="color:#56E39F;">&lt; AlNao /&gt;</span>
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
