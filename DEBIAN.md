# AlNao Debian Handbook
  <!--<img src="https://www.debian.org/Pics/debian-logo-1024x576.png" width="200"> -->
  <p align="center">
    <img src="https://img.shields.io/badge/Linux-BBCCEE?style=for-the-badge&logo=Linux&logoColor=black" height=60/>
    <img src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=Debian&logoColor=white" height=60/>
  </p>


Questo README raccoglie una selezione di articoli tecnici originariamente pubblicati nel blog personale [alnao.it](https://www.alnao.it), sono qui proposti in formato Markdown per renderli facilmente consultabili. Tutti i codici sorgente e le informazioni presenti in questo repository sono frutto di un attento e paziente lavoro di sviluppo da parte di [AlNao](https://www.alnao.it), che si è impegnato a verificarne la correttezza nella massima misura possibile.


In questa pagina sono elencati tutti gli articoli riguardo a **GNU Linux Debian** alla versione 13 chiamata **Trixie**. Tutti i dettagli su questa release sono disponibili nella [wiki ufficiale](https://www.debian.org/releases/trixie/) e nella [release notes](https://www.debian.org/releases/trixie/release-notes/index.it.html), la versione di riferimento è la 13.2 ma il documento è adatto anche a versioni precedenti di Debian fino alla *mitica* 3.1 Sarge.


# Indice
- [Introduzione](#Introduzione)
  - [Cosa, dove, come e perchè](#Cosa-dove-come-perchè)
- [Come installare Debian](#Come-installare-Debian)
- [Come gestire i file e le partizioni](#Come-gestire-i-file-e-le-partizioni)
  - [Gestione dei permessi](#Gestione-dei-permessi)
  - [Il mounting](#Il-mounting)
- [Come gestire i pacchetti e il pannello di controllo](#Come-gestire-i-pacchetti-e-il-pannello-di-controllo)
  - [Il pannello di controllo WebMin](#Il-pannello-di-controllo-WebMin)
- [Come gestire i desktop e le applicazioni](#Come-gestire-i-desktop-e-le-applicazioni)
  - [Gestione e installazione applicazioni](#Gestione-e-installazione-applicazioni)
  - [Editor di testo](#Editor-di-testo)
  - [Compressione ZIP e simili](#Compressione-ZIP-e-simili)
  - [Browser e mail](#Browser-e-mail)
  - [Appliazioni multimediali](#Appliazioni-multimediali)
  - [Dropbox](#Dropbox)
  - [Giochi e Steam](#Giochi-e-steam)
- [Come gestire i demoni di Debian](#Come-gestire-i-demoni-di-Debian)
  - [Sistema di stampa CUPS](#Sistema-di-stampa-CUPS)
  - [Condivisioni di rete con SSH e Samba](#Condivisioni-di-rete-con-SSH-e-Samba)
  - [I RunLevel](#I-RunLevel)
  - [Schedulazioni con Cron](#Schedulazioni-con-Cron)
  - [Controllo remoto](#Controllo-remoto)
  - [Monitoraggio e Logging](#Monitoraggio-e-Logging)
- [Programmazione in Debian](#Programmazione-in-Debian)
  - [C e C++](#C)
  - [Python](#Python)
  - [LaTeX](#LaTeX)
  - [Notify e Zenity](#Notify-e-Zenity)
  - [LAMP](#LAMP)
      - [Apache](#Apache)
      - [MySql](#MySql)
      - [Nginx](#Nginx)
  - [Node e NPM](#Node-e-NPM)
  - [Java e Tomcat](#Java-e-Tomcat)
  - [GIT](#GIT)
      - [Jenkins](#Jenkins)
  - [Visual Studio Code](#Visual-Studio-Code)
  - [Postman](#Postman)
  - [PostgreSQL](#PostgreSQL)
  - [MongoDB](#MongoDB)
  - [Docker](#Docker)
    - [Esempio con Pgadmin4](#Esempio-con-Pgadmin4)
    - [Configurazione di rete di Docker](#Configurazione-di-rete-di-Docker)
    - [Creazione ed avvio di una immagine](#Creazione-ed-avvio-di-una-immagine)
    - [Docker compose](#Docker-compose)
    - [Kubernetes](#Kubernetes)
    - [Minikube](#Minikube)
    - [Helm](#Helm)
    - [Portainer](#Portainer)
  - [Cloud](#Cloud)
      - [AWS](#AWS)
      - [Azure](#Azure)
      - [Terraform](#Terraform)
  - [Android](#Android)
  - [Blockchain](#Blockchain)
- [I comandi della shell](#I-comandi-della-shell)
  - [Configurazione del Path e alias](#Configurazione-del-Path-e-alias)
  - [Operazioni su files](#Operazioni-su-files)
  - [Manipolazione video](#Manipolazione-video)
  - [Il bootloader Grub](#Il-bootloader-Grub)
  - [Gestione del gestino](#Gestione-del-gestino)
  - [Il comando Sudo](#Il-comando-Sudo)
  - [Comandi per il controllo del sistema](#Comandi-per-il-controllo-del-sistema)
  - [Configurazione di rete](#Configurazione-di-rete)
  - [Gestione dei backup](#Gestione-dei-backup)
  - [Gestione delle macchine virtuali](#Gestione-delle-macchine-virtuali)


# Introduzione

Questo documento nasce dalla personale esigenza di avere un registro delle attività eseguite negli anni per la gestione dei sistemi GNU Linux e Debian, sia in ambito professionale sia in ambito personale. La necessità di riordinare il contenuto di grossi blocchi di appunti sparsi e raccolte di pagine web mi ha portato a scrivere un vero documento ordinato che negli anni si è evoluto visti i numerosi e frequenti aggiornamenti. 

Il documento è pensato come un vero e proprio “taccuino di bordo”: raccoglie procedure, trucchi, comandi e soluzioni ai problemi più comuni, frutto di esperienze personali e di una continua attività di aggiornamento. Non troverai slogan o confronti inutili con altri sistemi operativi, ma solo ciò che serve davvero per installare, configurare e mantenere Debian efficiente, sicuro e adatto alle tue esigenze, sia in ambito desktop che server.

Il documento viene aggiornato dal 2006, anno di scrittura della prima versione della *mitica* Debian 3.1 Sarge e ogni due anni riceve una revisione completa in corrispondenza dell'uscia della nuova versione del sistema operativo Debian. Questa è la versione della versione 12.1, le precedenti vesioni erano in formato PDF disponibili nel sito web [alnao.it](https://www.alnao.it/). In maniera molto ambiziosa l'ho chiamato manuale, persino Handbook nelle vecchie versioni in lingua inglese. Le varie versioni sono sempre state pubblicate su blog o su documenti pubblici, seguendo lo spirito base del mondo Open-source e GNU Linux. Rispetto alle precedenti versioni, questa versione è scritta senza sotto-sezioni e con articoli che parlano di singolo argomento in maniera completa. 

La redazione di questo documento è stata condotta nei ritagli di tempo libero, talvolta con il supporto di strumenti automatici e/o di intelligenze artificiali, sempre senza alcun fine di lucro. Nonostante l'impegno costante nel correggere errori di grammatica e battitura, nonché nel perseguire chiarezza espositiva e coerenza, è possibile che siano ancora presenti imprecisioni, refusi e/o ripetizioni. Si sottolinea il carattere amatoriale di questo manuale, che non ambisce a fornire una trattazione esaustiva o definitiva, ma piuttosto una guida pratica e orientativa. Le procedure e le informazioni riportate sono state verificate nella maggior parte dei casi, tuttavia possono esistere guide o documentazioni più dettagliate e specialistiche. Non si intende, pertanto, offrire una descrizione universalmente valida del metodo migliore per installare e configurare un sistema perfettamente funzionante, ma condividere un percorso di apprendimento e ottimizzazione maturato nel tempo.

Questo documento è stato concepito principalmente come guida di riferimento per attività di programmazione e sviluppo su sistemi GNU/Linux e Debian ma i contenuti sono strutturati in modo da risultare accessibili e utili anche a chi non possiede competenze specifiche di programmazione. Le procedure, i consigli e le spiegazioni tecniche sono *pensati* per accompagnare sia il professionista sia l’utente alle prime armi.

## Cosa dove come perchè
*Cosa*: La differenza tra ciò che è un sistema operativo e ciò che è un applicativo assume contorni talvolta chiari e meno chiari e sfumati: nei sistemi tradizionali, come Microsoft Windows o Apple macOS, si tende a tracciare una linea netta tra il cuore del sistema e i programmi accessori, nel mondo GNU Linux questa separazione si dissolve spesso con componenti che collaborano. Il *Kernel Linux*, può essere identificato come il sistema operativo ma molti componenti possono essere identificati come parti del sistema operativo nonostante siano pacchetti separati con nomi specifici. Grazie alla filosofia dei repository e dei mirror ufficiali, è possibile arricchire i sistemi con decine di migliaia di nuovi componenti senza mai dover ricorrere a fonti esterne di dubbia provenienza. In questo scenario, Debian si distingue per la ricchezza e la varietà del suo repertorio offrendo oltre 50.000 pacchetti e circa 10.000 programmi differenti.

*Dove*: L’installazione di GNU/Linux, e in particolare di Debian, non conosce confini rigidi: che si tratti di un personal computer di ultima generazione, di un notebook ormai prossimo alla pensione o di una workstation dedicata, la flessibilità del sistema consente di convivere pacificamente con altri sistemi operativi già presenti. Alcune distribuzioni permettono di condividere la stessa partizione tra più sistema operativi installati. Le comunità e le aziende che curano le distribuzioni GNU/Linux mettono a disposizione supporti di installazione come DVD, immagini ISO e mirror web, consentendo di accedere rapidamente al sistema desiderato. Ogni distribuzione possiede le proprie peculiarità, ma il cuore pulsante, il Kernel Linux, rimane invariato, garantendo una base solida e affidabile su cui costruire qualsiasi esperienza d’uso. In questo manuale si è scelto di concentrare l’attenzione su Debian, ma molte delle indicazioni e dei suggerimenti qui raccolti possono essere utilmente applicati anche a distribuzioni derivate, come Ubuntu, mentre per altre distrubuzioni le procedure potrebbero richiedere adattamenti consistenti.

*Come*: L’universo GNU/Linux, e in particolare a Debian, richiede una costante attenzione della differenza tra maiuscole e minuscole: la *case sensitivity* rappresenta una delle prime e più importanti lezioni che ogni utilizzatore deve imparare. Ogni carattere digitato, ogni percorso inserito, ogni nome di file o directory, assume un significato preciso e una minima disattenzione può condurre a risultati inattesi e/o ad errori.

Per garantire chiarezza espositiva, in questo documenti vengono adottate convenzioni tipiche della documentazione tecnica più autorevole:
- Il simbolo `#` identifica i comandi da eseguire con privilegi di amministratore (root)
- Il simbolo `$` contraddistingue le istruzioni da impartire come utente privo di privilegi elevati.
- Lo stile `macchina di scrivere` viene riservato a tutto ciò che il sistema mostra a video, ai caratteri digitati dall’utente e ai nomi di file e directory, con particolare attenzione alla distinzione tra lettere maiuscole e minuscole.
- Il **grassetto** viene impiegato per evidenziare, al loro primo apparire, nomi di programmi o pacchetti di rilievo.
- Il *corsivo* sottolinea commenti personali, note di contesto o osservazioni non ufficiali.
- $\textcolor{orange}{\textsf{Testo in rosso}}$ o riquadri segnalano informazioni di particolare importanza o criticità che necessiatano molta attenzione.

Si presuppone che il lettore disponga di una connessione Internet sufficientemente veloce per scaricare immagini ISO, aggiornamenti e pacchetti aggiuntivi, nonché di un supporto di memorizzazione adeguato (DVD o chiavetta USB) per la creazione dei supporti di installazione. L’adozione di questi standard, sebbene possa inizialmente apparire poco familiare, si rivelerà ben presto un prezioso alleato nella comprensione delle procedure e nell’interpretazione dei messaggi restituiti dal sistema.

*Perché*: La scelta di Debian, e più in generale di una distribuzione GNU/Linux, non è mai frutto del caso, ma il risultato di una riflessione ponderata sulle proprie esigenze, sulle aspettative di stabilità, sicurezza e libertà che si desiderano perseguire. Debian si distingue per la sua rigorosa suddivisione in rami di sviluppo: stable, testing e unstable; queste rappresentano le diverse fasi del ciclo di vita dei pacchetti software. Ogni pacchetto, prima di approdare nella versione stabile, attraversa un percorso di maturazione che ne garantisce l’affidabilità e la coerenza con l’intero ecosistema. 

Le versioni stabili di Debian, uniche a ricevere una numerazione ufficiale, sono celebrate con nomi ispirati ai personaggi del film **Toy Story**, mentre la versione unstable porta sempre il nome **Sid** (in omaggio al giovane bambino "distruttore" di giocattoli della saga). Questa tradizione, apparentemente giocosa, cela in realtà una filosofia di sviluppo improntata alla trasparenza, alla tracciabilità e alla partecipazione collettiva. Optare per Debian significa abbracciare un modello di aggiornamento continuo, in cui la sicurezza e la solidità del sistema sono il frutto di un processo collaborativo e di una comunità globale attenta e competente.

In definitiva, la domanda *perché scegliere Debian?* non ha una unica risposta ma un combinazione di concettti come affidabilità, apertura e vastità dell’offerta software, unite a una documentazione ricca e a una comunità pronta a supportare sia il neofita sia l’esperto. Debian non è soltanto un sistema operativo: è un ambiente completo come punto di partenza per ogni percorso di crescita nel mondo dell’open source. 

# Come installare Debian

L’installazione di un sistema operativo è una delle fasi più delicate ma, grazie al programma grafico di installazione di Debian, risulta oggi piuttosto semplice e veloce. Questa guida, valida anche per alcune versioni precedenti e successive, riassume i passaggi principali per installare Debian 13 Trixie. Per maggiori dettagli è sempre possibile consultare la guida ufficiale sul sito Debian: [debian.org](https://www.debian.org).


Debian è un sistema operativo libero e gratuito, distribuito sotto **licenza GNU GPL**, ciò significa è possibile scaricare ed usare gratuitamente le immagini ISO dalla pagina specifica del sito [debian.org](https://www.debian.org/distrib/) scegliendo tra le immagini disponibili:
- Netinst (consigliata): ISO di piccole dimensioni che scarica i pacchetti necessari durante l’installazione. Necessita una connessione ad internet abbastanza veloce.
- DVD/USB completi: immagini ISO grandi con molti pacchetti già inclusi e la possiblità di scaricare gli aggiornamenti dai repository in un momento successivo all'installazione.
- È disponibile anche una versione Live di Debian, avviabile da DVD o USB senza la necessità di installazione. Con *avvio di una live* all'accensione del PC si riferisce all'esecuzione di un sistema operativo completo (come una distribuzione Linux o uno strumento di ripristino) direttamente da un supporto rimovibile, come una chiavetta USB o un DVD, senza doverlo installare sul disco rigido. Questo processo permette di utilizzare, testare o riparare il computer in un ambiente isolato e temporaneo, lasciando intatto il sistema operativo principale installato sulla macchina.

Le immagini scaricate sono nel formato standard ISO, trattandosi di immagini molto grandi possono essere scaricate anche tramite sistemi client di reti peer-to-peer come qBittorrent o KTorrent. I file torrent possono essere scaricati direttamente dal sito.

⚠️🔶 $\textcolor{orange}{\textsf{Nota importante}}$: scaricare Debian tramite il sito ufficiale o programmi come Torrent è legale, perché è software libero coperto da licenza *libera* GNU/GPL. È invece illegale scaricare tramite sistemi peer-to-peer contenuti coperti da copyright come film, musica e software proprietario. 🔶⚠️

Avviare una sessione live significa eseguire un sistema operativo, come il programma di installazione di Debian, direttamente da un supporto esterno, come una chiavetta USB o un DVD, senza doverlo prima installare sul disco rigido. Per farlo, è necessario preparare il supporto copiandovi l'immagine ISO (tramite software come Rufus o dd) e configurare il BIOS/UEFI del computer affinché, all'accensione, cerchi il sistema operativo prioritariamente sulla porta USB o nel lettore DVD anziché sul disco interno.

Il programma di installazione spesso chiamato con *installer* prevede alcune modalità:
All’avvio dell’installer vengono proposte diverse opzioni:
- Installazione grafica: scalta consigliata se non necessari particolari configurazioni).
- Installazione testuale: per utenti esperti).
- Installazione avanzata: con più opzioni di configurazione, solo per utenti super-esperti).
- Accessibile / Dark contrast: versione grafica per ipovedenti.
- Live: se disponibile nell’immagine scelta, permette di avviare la distribuzione live

L’installer di Debian guida l’utente con schermate chiare. I passaggi previsti in sequenza sono:
- Scelta della lingua e del tipo di tastiera: è consigliato usare il sistema in lingua Italiana ma è possibile usare anche il sistema in lingua inglese , chi ha la tastiera con layout italiano (quello con le lettere accentate èòàù) deve selezionare la tastiera Italiana. In base alla lingua selezionata il sistema configura anche il fuso orario, nel caso di scelta di lingua con più fusi orari viene chiesta la posizione
- Carico dei media e di mount: in questo passo il sistema caricherà alcune informazioni dalla memoria, l'utente non deve inserire nulla e non deve interrompere il processo
- Configurazione del nome host e configurazione dominio di rete: due nomi simbolici se non presente una configurazione di rete particolare, nel caso di una rete con più computer è necessario inserire il nome simbolico della rete. La rete internet viene configurata automaticamente con valori di default, è prevista una modalità avanzata di configurazione dei dati di rete come indirizzo IP, Subnet, Gateway e DNS.
- Scelta della password di root: la password dell'utente amministratore del sistiema
- Creazione utente: questo passo è obbligatorio e prevede l'inserimento di username e password di un primo utente che sarà usato per la prima login, sarà successivamente possibile creare altri utenti o modificare il primo creato
- Partizionamento dei dischi: l'utente deve selezionare il disco dove installare il sistema operativo con due possiblità:
  - Guidato: suggerita se si dispone di un sistema nuovo/vuoto si può usare l'opzione automatica che ottimizza lo spazio
  - Manuale: se si dispone di dischi con dei dati già presenti o altri sistemi operativi è consigliato usare la procedura manuale e bisogna selezionare il disco dove installare il sistema operativo (partizione indicata con `/` )
  - ⚠️🔶 $\textcolor{orange}{\textsf{Nota importante}}$: modificare le partizioni può causare perdita di dati, non a caso il programma di installazione chiede conferma più volte delle operazioni su disco. Eseguire un backup prima di procedere se sono presenti dati personali 🔶⚠️
- Configurazione del mirror di rete: automaticamente vengono attivati i repository ufficiali da internet per avere aggiornamenti dalla rete *scelta molto consigliata* e automaticamente viene configurato il sistema di statistiche di utilizzo
- Nel caso di live specifiche (come quella live-gnome consigliata) il sistema non chiede cosa installare, altrimenti viene proposta una sezione dove selezionare il software da installare, in questo caso bisogna installare un desktop manager (come GNOME, KDE/Plasma, Xfce) 
  - per snellire e velocizzare il processo di installazione, in questa fase è sconsigliato installare altro software (come demoni/server) ed è possibile installare tutto successivamente comunque è possibie farlo anche in questo passo
- Configurazione del bootloader, di default il sistema installa il gestore "GDM LightDM" e il bootloader "GRUB", se è stata usata la modalità grafica non avanzata l'utente non deve inserire nulla e aspettare che il sistema si riavii da solo. Nella versione grafica base il sistema viene riavviato senza necessità di inserire altro.

Al primo riavvio dopo l'installazione, viene visualizzato il bootloader GRUB (configurato nell'ultimo passaggio del setup). Se è presente un solo sistema operativo, comparirà unicamente l'opzione per avviare Debian; se invece sono presenti più sistemi operativi, verrà mostrata una lista da cui è possibile scegliere quale avviare utilizzando le frecce della tastiera. In questo menu compaiono anche eventuali versioni precedenti del Kernel Linux, se installate. Una volta effettuata la selezione, il sistema carica il Kernel e i servizi necessari. Al termine compare la schermata grafica di login gestita da GDM (GNOME Display Manager): inserendo nome utente e password definiti in fase di installazione, si accede all'ambiente desktop GNOME (configurato di default). 

*Si consiglia ai nuovi utenti di esplorare i menu e l'interfaccia per familiarizzare con il nuovo sistema.*

Tutte le fasi e i dettagli del programma di installazione sono ben documentati nella guida disponibile nel sito ufficiale, per qualsiasi approfondimento si rimanda alle pagine ufficiali:
- Guida ufficiale Debian: [debian.org/releases](https://www.debian.org/releases/)
- FAQ Debian: [debian-faq](https://www.debian.org/doc/manuals/debian-faq/)
- Wiki Debian: [wiki.debian.org](https://wiki.debian.org/)


# Come gestire i file e le partizioni

Dopo aver completato tutti i passi del programma di installazione, il sistema è già quasi completo: di default nell'installazione base è compreso almeno un gestore di Desktop che comprende le parti dell’ambiente grafico e una serie di applicativi che possono essere trovati sul menù principale. Risulta impossibile usare GNU Linux senza avere qualche base sistemistica e un po’ di manualità su file e cartelle come la gestione i diritti di lettura e scrittura su file e cartelle. 

Un concetto fondamentale da ricordare è che i sistemi GNU/Linux con Debian sono *case-sensitive*: fanno cioè distinzione tra lettere maiuscole e minuscole. Questa differenza è determinante sia per i comandi che per i nomi dei file; è quindi essenziale prestare sempre molta attenzione a come vengono scritti, *in questo documento ho provato ad essere il più attento e preciso possibile*.

Una nozione fondamentale che un utente di GNU Linux deve avere sempre presente è che tutto è un file cioè il Kernel Linux infatti vede e gestisce tutto come un file: le cartelle, le periferiche come le stampanti, memorie fisse e persino i processi in esecuzione sono interpretati come file che il FileSystem gestisce e amministra. 

A differenza di altri FileSystem, in GNU Linux le estensioni non sono rilevanti, spesso capiterà di trovare file con estensioni “strane” ad un utente non abituato a tale libertà: un esempio classico è il file `sources.list` che conterrà una lista di sorgenti come dice il nome e l'estensione: spesso infatti viene usata l’estensione per evidenziare se il file ha un contenuto specifico come liste o configurazioni. Esistono anche file senza estensione come il file `fstab`, per i sistemi basati su Unix e GNU Linux l’estensione di un file è solo una parte del nome. I file il cui nome inizia per `.` (punto) sono files nascosti, cioè i file manager nascondere questi tipi a meno di comandi specifici, questi nomi vengono usati dai programmi per creare cartelle e file di configurazioni ma di non dare la possibilità all'utente di modificarli *per errore*.

Lo standard per il file system usato in tutti i sistemi GNU Linux si chiama **FSSTND**, che impone delle direttive per l'organizzazione dell'albero delle directory nei sistemi: viene usato per la facilità del porting del software per GNU Linux e l'amministrare dei sistemi, dato che tutto si trova nel posto designato per qualsiasi distribuzione che usa questo stardard. Per essere precisi, non c'è nessuna autorità che impone di uniformarsi a questo schema, ma è molto raro trovare distribuzioni di GNU Linux che non la rispettano. L'albero delle directory completo è concepito in modo che possa essere diviso in parti più piccole, ciascuna sulla sua partizione o nel suo disco se necessario, per ottimizzare i dischi e ridurre le dimensioni delle partizioni. L'albero delle directory è stato strutturato in modo che funzioni bene in una rete di sistemi condivisi su dispositivi a sola lettura come DVD o in rete NFS. La struttura del filesystem si basa su una radice che viene chiamata **cartella root** e viene sempre indicata con il carattere
```
/
```
questa cartella è specifica per ciascun sistema e rappresenta l'intero sistema: contiene tutti i file necessari per avviare il sistema e per portarlo ad uno stato tale da poter gestire tutte le altre memorie e tutti i dispositivi. Si può affermare, anche se in maniera un po' superficiale, che la root sostituisce quello che nei sistemi MS Windows è il "Risorse del computer", infatti in Linux non potete trovare i dischi (C,D,E, ecc..) ma si possono trovare le principali sottodirectory:

- ```/bin``` Contiene i programmi di sistema utilizzati sia dall'amministratore che dai normali utenti, come ad esempio: `ls` e `cat`
- ```/boot``` Contiene tutto quello che è necessario per eseguire il processo di boot del kernel, configurata in fase di installazione di GRUB
- ```/dev``` Contiene i riferimenti a tutti i dispositivi e le periferiche (HarkDisk, CdRom, stampanti, rete, ecc...)
- ```/etc``` Contiene i files di configurazione degli applicativi e i demoni presenti nel sistema
- ```/home``` Contiene le home directory degli utenti, le informazioni e i file di ogni utente
- ```/lib``` Contiene le librerie necessarie al boot del sistema e all'esecuzione dei programmi
- ```/mnt``` Inizialmente è vuota, come standard viene usata per effettuare il collegamento (mount) di tutte le unità di memoria presenti (HardDisk, cdrom, memorie usb, ecc.. ), talvolta è possibile trovare anche la cartella /media che tipicamente viene usata solo per i dispositivi rimovibili (CdRom, Floppy, USB Disk)
- ```/opt``` Dovrebbe essere vuota inizialmente, in passato veniva usata per gli applicativi del sistema base, oggi viene usata da alcuni applicativi proprietari come Google chrome oppure i programmi di AWS
- ```/proc``` Contiene i riferimenti ai programmi in esecuzione (i processi in esecuzione vengono trattati come file)
- ```/root``` La home directory dell'utente root
- ```/sbin``` Contiene i programmi di sistema (system binaries) utilizzati dall'amministratore
- ```/srv``` Contiene alcuni file di configurazione dei servizi specifici avanzati
- ```/sys``` Contiene dei file di sistema
- ```/tmp``` Cartella dei file temporanei (ogni volta che si spegne il pc questa cartella potrebbe essere svuotata)
- ```/usr``` Contiene le applicazioni (non di sistema) installate nel sistema
- ```/var``` Contiene vari files di sistema come i log e le carelle della posta

## Gestione dei permessi

Nei sistemi Unix e GNU Linux esistono tre tipi di diritti su un file: scrittura, lettura ed esecuzione rispettivamente identificati con la lettera r, w e x. Ogni file, quindi ogni cosa nel sistema, appartiene all'utente che ha creato quel file che ha sempre i tutti i diritti su quel file. Per ottenere i diritti su un file basta eseguire il comando sulla shell:
```bash
$ ls -la
```
che elenca i diritti in una schermata simile a questa:
```
drwxr-xr-x 2 alnao alnao 4096 2 feb 14:09 DIR1
-rw------- 1 alnao alnao 2615 2 feb 16:28 file1
-rw-r--r-- 1 alnao alnao 1162966 2 feb 19:50 file2
-rwxr-xr-x 1 alnao alnao 1162966 2 feb 19:50 file3
```
la prima riga descrive una directory, la si può riconoscere dal fatto che la prima lettera è una `d`, i successivi tre caratteri sono indicati i diritti sull'utente che ha creato quel file, il secondo gruppo di tre si riferisce agli utenti dello stesso gruppo dell'utente creatore del file, mentre l'ultima tripletta descrive i diritti di tutti gli altri utenti. Se è presente la lettera significa che il diritto è attivo mentre se c'è il trattino vuol dire che il diritto che dovrebbe essere presente non è attivo. Da notare che l'**utente root** ha sempre tutte le autorizzazioni quindi riuscirà sempre a leggere e a scrivere su tutti i file e su tutte le cartelle. Per cambiare i diritti su un file si può usare il comando chmod. Da notare che il diritto x sostituisce l'estensione su altri sistemi: le estensioni non hanno significato e per capire se un file è eseguibile o meno bisogna osservare questo diritto in ogni singolo file.

Alcune delle configurazioni base devono essere eseguite da riga di comando che in informatica viene comunemente chiamata **shell** e, più in particolare, nei sistemi GNU Linux è disponibile il tipo chiamato **bash**, non bisogna fare confusione: con shell si intende una riga di comando *generica* mentre bash è l’interprete dei comandi, in questo manuale faremo sempre riferimento a bash e non verranno introdotte altre tipi di shell anche se in altri manuali potete trovare guide più complete di bash e di altri tipi di shell per GNU Linux. Tipicamente nelle architetture basate sul KernerLinux con la bash sono disponibili 8 “canali” detti anche tty (abbreviazione di TeleTYpewriter), nei sistemi basati su GNU Linux il primo canale è usato dal KernelLinux e in questo canale compaiono i messaggi del sistema mentre il server grafico tipicamente si trova nel settimo canale, dalla versione 10 di Debian il server grafico viene caricato sempre dal secondo canale mentre nel primo c'è una seconda versione del server grafico se si vuole utilizzare la funzionalità multiutente; è possibile passare da un canale ad un altro con la sequenza di tasti `ALT + CTRL + F1` dove l’F1 è il numero del canale (ovviamente per il settimo canale si può usare F7).

## Il mounting

Una delle esigenze primarie di ogni utente è quello di poter accedere ai propri dati che sono salvati nei vari dischi, gli utenti di altri sistemi operativi sono abituati a identificare le memorie fisiche con delle lettere come C, D, E, ecc... mentre nei sistemi GNU Linux la gestione delle partizioni e delle periferiche di memoria è completamente diversa: la gestione viene chiamata *mounting* (in Italiano spesso viene tradotto con *montaggio*), nome che deriva dal comando **mount** che viene utilizzato per eseguire le configurazioni, infatti le memorie vengono viste dal Kernel Linux come un normale file dentro alla cartella /dev/ e, attraverso il comando mount, si possono collegare ad una cartella per permettere l’accesso al contenuto della memoria. I file che si trovano dentro alla cartella dev non rappresentano tutta la memoria fisica ma rappresentano una partizione: se in una memoria ci sono più partizioni significa che sono presenti più file che devono essere montati separatamente. Tipicamente questi file hanno il nome del tipo hda1, sda1, sda2, sdb1 dove la prima lettera del nome rappresenta il tipo (per esempio h=Eide, s=Sata), la seconda lettera è sempre d che significa DISK mentre la terza lettera è un incrementale se ci sono più dispositivi dello stesso tipo (se ci sono due HardDisk il primo sarà “a” mentre il secondo sarà “b”), il numero finale rappresenta il numero della partizione all'interno della stessa memoria fisica.


Per poter recuperare l'elenco delle partizioni e la struttura delle memorie si può usare il programma gparted dal desktop da installare oppure con il comando
```
# fdisk -l
```
Questi programmi presentano l’elenco di tutte le partizioni e, se possibile, anche il tipo, con gparted è anche possibile modificare le partizione e formattarle. Nei desktop recenti, il mount risulta automatico, per esempio con un programma come Dolphin, l'elenco dei dispositivi sono elencati nelle finestre divisi per memorie fissi e i dispositivi mobili come le chiavette USB. Per poter eseguire il mount manualmente, bisogna disporre di una cartella vuota che sarà la destinazione dell’operazione di montaggio, come default viene usata una sotto-cartella di `/mnt`. Per esempio si può creare una cartella da un file manager oppure da riga di comando con le istruzioni:

```
# mkdir /mnt/Dati
# chmod 666 /mnt/Dati
```
da notare il comando chmod assegna a tutti gli utenti la possibilità di accedere a tale cartella, questo è indispensabile altrimenti solo l’utente root potrebbe accedere alla memoria montata. Il comando mount da riga di comandi prevede la sintassi:
```
# mount -t auto /dev/sda2 /mnt/Dati
```
con questa istruzione viene montata la partizione hda2 sulla cartella Dati, come parametro mount ha bisogno anche di sapere il tipo di Filesystem della partizione (Fat32, Ext3, NTFS, ecc..) ma esiste anche il parametro "auto" che ci semplifica la vita lasciando al sistema il compito di selezionare quello corretto. Il problema del comando mount è che, allo spegnimento o riavvio del sistema, il montaggio NON verrà rieseguito automaticamente, il kernel mette a disposizione un file di configurazione per rendere definitive le operazioni di mount che vengono eseguite al primo accesso:
```
/etc/fstab
```
questo è un file storico dei sistemi GNU Linux e si trova sempre nello stesso posto fin delle prime versioni del sistema, da notare che questo file è sprovvisto di estensione e si trova nella cartella /etc, per modificare questo file da desktop si può avviare come utente root un editor con:
```
# gedit /etc/fstab
```
e si può vedere il contenuto del file che all'apparenza complicato ma basta sapere che ad ogni riga corrisponde una memoria montata, nel file infatti basta aggiungere una riga per ogni partizione, per esempio:
```
/dev/sdb3 /mnt/Dati ext4 user,suid,dev,rw,exec 0 0
```
dove nella riga sono elencati in ordine: il punto di mount (sorgente e destinazione), il tipo di partizione anche se è sconsigliato l'uso del comando auto e i vari parametri della partizione, nel nostro esempio `umask=000` oppure `rw` indicano che la partizione è in scrittura e lettura. Per le partizioni di formato GNU Linux come ext non serve indicare l’umask.

Per le chiavette USB o memorie rimovibili si configura la riga:
```
/dev/sdd1 /mnt/Usb auto user,suid,dev,exec,umask=000,rw,noauto 0 0
```
Il parametro `noauto` indica che l'operazione di mount non deve essere eseguito automaticamente all'avvio del sistema ma deve essere eseguita manualmente quando la memoria esterna viene inserita. Per rendere effettive le modifiche del file di configurazione bisogna riavviare il sistema. Per definire le partizione nel file di configurazione è possibile mappare il riferimento dentro la cartella dev oppure è possibile usare il riferimento UUID, cioè il riferimento assoluto ID che il sistema assegna ad ogni partizione, per visualizzare i riferimenti nel proprio sistema si può usare il comando:
```
# blkid
```
e poi è possibile modificare il file fstab con la riga:
```
UUID=1234-5678 /mnt/Dati tipo parametri 0 0
```
questo metodo è consigliato rispetto all'uso del DEV in quanto alcuni sistemi posso cambiare riferimenti alla risorse ogni riavvio del sistema. Nelle ultime versioni di Debian questa operazione viene eseguita durante la fase di installazione e, una volta terminata l'installazione del sistema base, è possibile vedere il file già ben configurato con tutti i parametri. Da notare che i lettori DVD/CD possono essere configurati nella cartella `media` per separare le memorie fisse da quelle rimovibili tuttavia questo non è uno standard ma solo un dettaglio presente in alcune vecchie versioni di Debian, *c'è ancora qualcuno che usa i lettori DVD?*.

Modificare lo schema delle partizioni è una operazione complessa ad *alto* rischio di perdita di dati; la mia esperienza mi ha portato a non modificare mai le partizioni dei dischi se su questo è installato il sistema operativo o se ci sono dati importanti, quando si deve modificare una qualsiasi partizione contenente dati, conviene sempre eseguire una copia di backup di tutte le partizioni comprese quelle non modificate. Le cose si complicano ancora di più quando nello stesso disco ci sono più partizioni di tipo diverso come quelle di MsWindows (con filesystem di tipo NTFS o FAT32) e partizioni GNU Linux (con filesystem di tipo le Ext3 o Ext4), questo perché i programmi di partizionamento di un sistema operativo difficilmente trattano al meglio le partizioni degli altri sistemi con l'ovvio rischio di perdere partizioni che un programma non riconosce, per evitare questi contrasti fra sistemi operativi si possono usare programmi specializzati che cercano di gestire al meglio le partizioni di tutti i tipi, su Debian è disponibile il programma GParted per permette di gestire e modificare la struttura delle partizioni dei dischi.


Per la gestione delle partizioni di tipo **swap**, è possibile confiurare le partizioni fisiche le file `fstab` come le normali partizioni, per esempio la riga:
```
/dev/sda2 none swap sw 0 0
```
Per visualizzare l'elenco delle partizioni swap si possono usare i comandi del sistema operativo:
```
$ free -h
$ df -h
# swapon --show
```
Le ultime versione del Kernel Linux permettono di creare e montare dei file come fossero delle partizioni swap, per creare e montare il file si possono essere eseguire i comandi:
```
# fallocate -l 1G swapfile
# ls -lh swapfile
# chmod 600 swapfile
# mkswap swapfile
# swapon swapfile
```
infine è possibile inserire la configurazione nel file `fstab` impostando il path assoluto del file swapfile creato, per esempio con il comando
```
# echo '/path/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

Il parametro di configurazione `swappiness` indica al sistema operativo quanto spesso eseguire l'operazione di trasferimento dalla memoria RAM verso lo spazio swap, è una percentuale da zero a cento e di default è impostata a sesanta, può essere verificata e modificata con i comandi:
```
$ cat /proc/sys/vm/swappiness
# sysctl vm.swappiness=10
# nano /etc/sysctl.conf
```

# Come gestire i pacchetti e il pannello di controllo

Per utilizzare al meglio i sistemi Debian è indispensabile conoscere la gestione dei pacchetti: i pacchetti sono un insieme di file organizzati e compressi in directory in modo che possano essere installati nel sistema velocemente e con ordine; esistono molti modi di compilare e preparare i pacchetti, Debian ha imposto da anni un suo standard che è facilmente riconoscibile per i file di **estensione deb** mentre altre distribuzioni possono avere altri formati come rpm o yum. Uno dei motivi per cui Debian è molto famosa è proprio per la gestione eccellente dei pacchetti perché, pur contando oltre 25.000 pacchetti nel repository ufficiale, esiste un sistema centrale che gestisce le dipendenze in modo semplice e ordinato cioè ogni pacchetto ha una versione e una lista di dipendenze: ogni pacchetto al suo interno ha l'informazione di quali pacchetti sono necessari e con i quali entra in conflitto. 

Per esempio il pacchetto *a* dipende dal pacchetto *b* e entra in conflitto con il pacchetto *c*, tutto questo dipende anche delle versioni, cioè ogni pacchetto è segnato anche da una versione, per esempio nel mio sistema è installato il pacchetto *a* alla versione 2.2.8-3: questo vuol dire che il pacchetto è alla versione 2.2.8 ma è la terza compilazione del pacchetto. Per fortuna i programmi che andremo ad usare gestiscono automaticamente con ordine e precisione i pacchetti quindi l'utente non deve mai preoccuparsi di risolvere le dipendenze.

La gestione dei pacchetti Debian nel sistema si basa sul componente **DPKG** abbreviazione di **Debian PacKaGe**: è usato per installare, disinstallare ed ottenere informazioni sul singolo pacchetto in formato standard `deb`. Questo è un tool di basso livello e viene sempre affiancato da **APT** che è l'abbreviazione di **Advanced Packaging Tool** che è il gestore standard di pacchetti software della distribuzione Debian. Con APT è possibile anche configurare diversi mirror-sorgenti di pacchetti (sorgenti remote in internet, cdrom, DVD). Tutti i comandi dei due programmi sono:

- ```# apt-get update``` aggiorna la lista dei pacchetti dopo la configurazione di un nuovo mirror
- ```# apt-get install nomepacchetto``` installa il pacchetto nel sistema, scegliendo l'ultima versione disponibile ed risolvendo le dipendenze in maniera automatica (installando i pacchetti necessari e evitando i pacchetti in conflitto)
- ```# apt-get remove nomepacchetto``` rimuove il pacchetto e tutti i pacchetti che dipendono da esso
- ```# apt-get --purge remove nomepacchetto``` rimuove il pacchetto e tutti i pacchetti che dipendono da esso compresi anche tutti i file di configurazione eventualmente presenti
- ```# apt-get upgrade``` aggiorna tutti i pacchetti se sono disponibili aggiornamenti e verifica tutte le dipendenze delle nuove versioni
- ```# apt-get clean``` cancella tuti i file temporanei di apt-get cioè i file deb scaricati e già installati
- ```# apt-get install -f``` verifica che tutti i pacchetti siano installati e configurati correttamente, in caso di errori sistema automaticamente le dipendenze
- ```# dkpg --configure -a``` come il precedente ma funziona anche in casi estremi e risolve tutti i problemi di conflitto tra i pacchetti
- ```# dpkg-reconfigure pacchetto``` riconfigura un pacchetto già installato
- ```# dpkg -i pacchetto.deb``` installa un pacchetto da un file deb
- ```# dpkg -r pacchetto``` rimuove un pacchetto
- ```# dpkg --get-selections > nomefile.txt``` salva su un file l'elenco dei pacchetti installati
- ```# dpkg --set-selections < nomefile.txt``` imposta i pacchetti presenti sul file
- ```# apt-get moo``` regala all'utente un simpatico messaggio

All'interno di un sistema, la lista dei mirror-sorgenti è elencata nel file
```
/etc/apt/sources.list
```
e da tutti i file contenuti nella sotto-cartella
```
/etc/apt/sources.list.d/
```
e si possono creare dei file con estensione list per aggiungere altri mirror specifici. In questi file list, ad ogni riga corrisponde una sorgente che può essere un DVD, un mirror in internet oppure una cartella del sistema locale. Ogni riga di questi file è del tipo:
```
deb http://host/debian distribuzione sezione1 sezione2 sezione3
deb-src http://host/debian distribuzione sezione1 sezione2 sezione3
```
La prima parola di ogni riga (deb o deb-src) indica il tipo di archivio: se contiene pacchetti binari (deb) oppure indica se l'archivio contiene i pacchetti sorgente (deb-src), la seconda parte della riga indica l'indirizzo della sorgente. Nel terzo parametro si indica la distribuzione: di solito si tratta di uno dei tre rami di sviluppo: stable, testing o unstable, nelle righe di configurazione è possibile indicare esplicitamente il nome della versione come etch, sid o sarge). L'elenco delle sezioni indicano quali parti della distribuzione dovranno essere gestite, tipicamente si trova main (i pacchetti completamente liberi) oppure non-free (cioè i pacchetti rilasciati sotto una licenza non libera) oppure contrib (pacchetti liberi che però dipendono da altri non liberi). Al termine di ogni modifica di questi file di configurazione è necessario lanciare il comando per aggiornare il database di sistema:
```
# apt-get update
```
In precedenti versioni di questo documento si indicava all'utente di modificare manualmente i file di list per inserire i mirror manualmente, questa operazione manuale è stata sostituita da operazioni più semplici che verranno introdotte man mano che sarà necessario installare pacchetti specifici non compresi nei mirror ufficiali di Debian che sono inseriti in automatico all'installazione del sistema base. 

I programmi di gestione APT & DPKG non sono stati studiati per essere interfacciati graficamente, quindi sono stati sviluppati e sono presenti in Debian diversi strumenti grafici che permettono di gestire i pacchetti attraverso una interfaccia grafica che può risultare più intuitiva all'utente meno esperto: il più importante programma per desktop per la gestione dei pacchetti è **Synaptic** che spesso si può trovare nei menù anche con il nome in italiano di **Gestore pacchetti**, la potenza di questo programma è la semplicità d'uso rispetto ad altri programmi simili. Con Synaptic è possibile vedere la lista dei pacchetti divisi in sezione per argomento (sistema, grafici, editor,...), per stato (installati, aggiornabili, non installati, corrotti), per origine (DVD, debian.org, ecc...) e la possibilità di cercare i pacchetti con una semplice ricerca testuale sui nomi e sulle descrizioni dei pacchetti stessi. La comodità principale di questo programma è la possibilità di gestire gli aggiornamenti del sistema con un semplice click su pulsante.

## Il pannello di controllo WebMin

Nei sistemi Debian è possibile trovare diversi programmi che permettano la configurazione del sistema, nei vari menu dei desktop si possono trovare diverse voci all'interno della categoria Strumenti di sistema però per GNU Linux è stato sviluppato un potentissimo programma per il controllo generale: **WebMin** che prevedete moltissimi moduli al proprio interno e permette all'utente di amministrare tutti i componenti del sistema, uno dei grandi vantaggi di questo pacchetto è che si tratta di una applicazione web quindi viene usata tramite browser anche da remoto. Rispetto alle precedenti versioni, WebMin non è più all'interno dei mirror ufficiali di Debian e quindi bisogna configurare una sorgente esterna.

Come indicato nel [sito ufficiale webmin.com](https://webmin.com/download/) i comandi per l'installazione in Debian 13 sono:
```
# curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh
# sh webmin-setup-repo.sh
# apt-get install webmin --install-recommends
```
In precedenti versioni era anche necessario configurare le porte di rete con i comandi
```
# ufw allow 10000/tcp
# ufw reload
# ufw enable
```
Se non dovesse essere avviato è possibile lanciare lo start con il comando:
```
# systemctl start webmin
# systemctl status webmin
```
Per poter accedere al pannello di controllo basta lanciare da un browser l'url:
```
https://localhost:10000/
```
All'interno delle ultime versioni di Webmin, c'è la possibilità di collegarsi alla console shell con l'icona >_ presente nel menù di sinistra al tab "dashbord" questo permette di usare il terminale da remoto anche se io lo ritengo molto scomodo.

⚠️🔶 $\textcolor{orange}{\textsf{Nota importante}}$: WebMin è uno strumento molto potente ma anche troppo! Bisogna sempre prestare attenzione alle configurazioni eseguite e controllare più volte le operazioni potenzialmente distruttive per il sistema 🔶⚠️

# Come gestire i desktop e le applicazioni

Il programma di installazione prevede la creazione di un primo utente che viene utilizzato al primo accesso, attraverso i vari tool di controllo disponibili è possibile creare e configurare altri utenti se necessario con la possibilità di raggrupparli e gestire l'accesso. Il gestore della login che compare all'avvio del sistema grafico si chiamata **GDM** (abbreviazione di Gnome Desktop Manager) esistono anche altri gestori ma è sconsigliato l'utilizzo per utente non esperti. Per la creazione di altri utenti è possibile usare i vari programmi disponibili ma è consigliato usare WebMin appena installato visto che ha una interfaccia molto semplice e intuitiva per la gestione degli utenti e dei gruppi. Il pannello di controllo WebMin è molto utile anche per la gestione di tutte le parti di un sistema: lo schedulatore di sistema CronTab, le configurazioni di rete, la gestione dei backup, il monitoraggio dei log e i demoni/server come sarà descritto in una sezione dedicata ma questo tool è *sconsigliato* per alcuni temi specifici che si interfacciano con l'hardware, come la gestione delle partizioni perchè esistono tool specifici dedicati come **Gparted**.

Nel mondo GNU Linux il principale server grafico è **X-WindowSystem** (spesso abbreviato con X), questo gestire l'interfaccia utente e bisogna ricordare che non esiste un unico desktop: esistono diversi desktop che possono essere installati ed usati parallelamente, infatti esiste la possibilità di passare da un desktop ad un altro selezionando il nome nella schermata di login all'avvio del sistema; tutte le applicazioni possono essere eseguite da qualsiasi tipo di desktop. I principali desktop per GNU Linux basati sul server grafico X sono: **GNOME**, **KDE** dettao che **Plasma** e **XFCE** mentre quelli leggeri e studiati per essere veloci sono **MATE** e **LXDE**, è consigliato la prova di tutti i cinque appena elencati in modo che un utente possa scegliere il più consono. 

Il più famoso desktop per il mondo GNU Linux è **GNOME** che di default viene attivato in fase di installazione di Debian, il gestore è ornami riconosciuto come il miglior gestore con un numero lunghissimo di applicazioni disponibili, le principali saranno elencate in questa sezione. Una delle proprietà di questo desktop è la possibilità di installare delle  estensioni molto comode e integrate nel sistema che possono essere facilmente attivate e disattivate da una applicazione specifica oppure andando sul sito
```
extensions.gnome.org
```
da un browser da dentro il desktop.
Le più famose e consigliate estensioni sono
- App Icons Taskbar
- AppIndicator and KStatusNotifierItem Support
- Apps menu
- Extensions list
- Indicator
- Just perfection
- User themes
- Windows list
Inoltre è disponibile anche una applicazione personalizzazioni studiata per permettere agli utenti di modificare l'aspetto grafico del desktop.

## Gestione e installazione applicazioni

Uno degli errori più frequenti degli utenti comuni è pensare che non esistono applicazioni per il normale utilizzo di un computer, la verità è l'esatto opposto: esistono migliaia di applicazioni che rendono i sistemi GNU Linux completi e perfettamente utilizzabili. Basta infatti aprire il programma di gestione dei pacchetti **Synaptic** e usare la funzionalità di raggruppamento per categoria per rendersi conto delle migliaia di applicazioni disponibili nei repository Debian: oltre alla numerosità delle applicazioni, grazie a Synaptic, è possibile sfruttare la gestione dei pacchetti di Debian per evitare il problema delle dipendenze quindi un utente non deve preoccuparsi di nulla e non deve nemmeno preoccuparsi del desktop utilizzato. Tutti i pacchetti disponibili sui server mirror di Debian sono totalmente gratuiti e scaricabili dai mirror internet, su altri mirror non ufficiali è possibile scaricare altri programmi gratuitamente, per esempio il mirror di Google permette il download e l'installazione del browser Chrome. Purtroppo non esiste un elenco completo ed ufficiale di tutti i programmi disponibili, questo perché i programmi vengono creati quotidianamente e certi progetti chiudono per l’insuccesso di una applicazione o la sua scarsa utilità.

In aggiunta al repository ufficiale Debian e ai repository proprietari, come quello di Google, è possibile usare anche il gestore **snapd**: un servizio web che mette a disposizione pacchetti scaricabili e funzionanti. Il consiglio è di usare questo servizio solo per quelle applicazioni o quei pacchetti che non si trovano nei repository ufficiali Debian ed è quello che verrà fatto in seguito. Per installare Snapd basta installare il pacchetto snapd, da non confondere con il pacchetto snap che invece riguarda una applicazione scientifica. Una volta installato il pacchetto è possibile vedere l'elenco dei pacchetti installati sul sistema con Snapd con il comando:
```bash
$ snap list
$ snap list --all
$ snap list --all | grep disabled
```
correttamente senza la lettere "d" finale in quanto il pacchetto ha la lettere finale per indicare che si tratta di un demone mentre il comando è senza la finale. Per installare un programma con questo servizio basta usare il comando:
```bash
$ snap install nomeprogramma
```
l'elenco di tutte le migliaia di programmi disponibili si trova nel sito ufficiale snapcraft.io, un esempio di applicazione consigliata su questo sistema è Spotify. Il sistema potrebbe riempirsi di immagini vecchie e deprecate, per liberare spazio è possibile lanciare il comando di pulizia
```bash
# snap list --all | grep disabled | awk '!/Name|----/ {print $1 " --revision " $3}' | xargs -n1 sudo snap remove
```

Sulla nuova versione di Debian gli aggiornamenti vengono eseguiti in automatico, questo per facilitare la vita a chi utilizza il sistema e non conosce bene la gestione dei pacchetti, si può vedere la configurazione degli aggiornamenti automatici con i comandi:
```
# systemctl status apt-daily.timer
# systemctl status apt-daily.service
# systemctl status apt-daily-upgrade.timer
# systemctl status apt-daily-upgrade.service
```
Sempre con il gestore del sistema è possibile disattivare/attivare gli aggiornamento automatici con i comandi:
```
# systemctl disable apt-daily.timer
# systemctl disable apt-daily.service
# systemctl disable apt-daily-upgrade.timer
# systemctl disable apt-daily-upgrade.service
# systemctl status apt-daily.timer
```
Inoltre è possibile, anche se sconsigliato, modificare il file di configurazione
```
more /lib/systemd/system/apt-daily.timer 
```

## Editor di testo

Gli utenti di GNU Linux devono aver confidenza con i file di testo per modificare alcuni vari file di configurazione, anche se può sembrare antiquato agli utenti meno esperti, in realtà è molto più semplice e veloce di quanto possa sembrare. Sui sistemi basati su Debian è possibile trovare facilmente alcuni editor di testo più o meno complicati a seconda delle esigenze: per la shell da riga di comando esistono i famosi (e storici) programmi vim e emacs (troppo complicati per utenti poco esperti), i programmi più semplici da usare da riga di comando sono **pico** e **nano** che risulta molto semplice da usare visto che con la pressione del tasto CTRL è possibile cambiare dalla modalità editor a menù e viceversa. Negli ambienti grafici desktop sono disponibili molti programmi, tipicamente ogni desktop ha il proprio programma di default ma nessuno vieta di usare altri programmi anche di altri desktop, per esempio il programma di default di KDE è **kEdit** ma è possibile usare anche i programmi di GNOME come **gEdit** oppure **mousepad**. Tuttavia il programma più completo è **Kate** che, oltre ad essere un semplice editor di testo, può essere usato per programmare grazie al suo plugin di riconoscimento dei linguaggi di programmazione oppure può essere usato per la scrittura di documenti. Come già visto più volte, i file possono avere nomi ed estensioni *strane* e molti file di testo non hanno estensione il classico txt che di solito si trova su altri sistemi operativi, dobbiamo sempre tenere a mente che sui sistemi basati su GNU Linux le estensioni non hanno molto valore se non per pura naming-convention o estetica: molti file hanno estensione conf e tipicamente si trovano nella cartella /etc o una sottodirectory ma alcuni file hanno nomi non parlanti o posso essere senza estensione come il file `fstab`. Da snapd è possibile scaricare il famoso Notepad++ oppure nei repository ufficiali è possibile selezionare **jEdit**, questi due programmi sono i più famosi e potenti programmi per la modifica di file dei testo.

Per esplorare e navigare tra le varie cartelle del sistema, oltre che alla riga di commando, è possibile utilizzare i tanti programmi file manager, tipicamente ogni Desktop ha il proprio file manager di default e spesso in un desktop è possibile trovarne anche più di uno, il programma predefinito sul Desktop KDE è lo *storico* **Konqueror** e può essere usato anche in altri desktop, nonostante sia vecchio è ancora usatissimo come file exploper ed è stato migliorato molto tanto da diventare uno dei miglioro programmi per muoversi tra le varie cartelle del sistema. La potenzialità maggiore è quella di poter visualizzare l’albero delle cartelle, inoltre nelle versioni più recenti sono stati integrati anche un visualizzatore di immagini, un piccolo editor di testo e il sistema veloce per gestire i file archivi (come zip e tar). Altra applicazione da provare è **dolphin** che presenta una interfaccia molto semplice e veloce, pur non disponendo di plugin, rimane il più intuitivo programma per navigare tra le cartelle, anche in questo programma sono disponibili i plugin per visualizzare l'albero delle cartelle, ovviamente questo è compatibile con tutti i Desktop e permette anche di avere una shell in basso alla finestra che segue l'utente nella navigazione dell'utente nelle cartelle. Ovviamente un utente può benissimo usare un qualsiasi altro programma disponibile sui Desktop oppure basta aprire Synaptic per installarne decine, lo storico commander può essere trovato con il nome di Midnight Commander oppure **Gnome Commander**.

## Compressione ZIP e simili

Gli standard di compressione del mondo GNU Linux si chiamano `tar`, `gz` e `bz`, ma possono essere usati anche altri formati come i più famosi `zip` e `rar`, per riconoscere in quale formato è compresso un file basta guardare l’estensione del file, da notare che le estensioni possono essere composte: per esempio un file può avere estensione `nomefile.tar.gz` oppure il semplice `nomefile.zip`. Visto che il formato rar è un algoritmo proprietario e non free, per poterlo usare è necessario installare i pacchetti rar, rar-2.80, unar e unace-nonfree che potete trovare nei repository "non free" nel mirror.

Per usare lo standard TAR da riga di comando, i principali comandi sono:
```bash
$ tar -cf namefiletar.tar file1 file2 ... per creare un file non compresso nel formato tar
$ tar -xf namefiletar.tar per estrarre un file non compresso nel formato tar
$ tar -czf namefiletar.tar.gz file1 file2 ... per creare un file compresso nel formato tar e gzip
$ tar -xzf namefiletar.tar.gz per estrarre un file compresso nel formato tar e gzip
```
I principali parametri del comando tar sono:
- c per creare
- x per estrarre
- v per vedere la lista dei file contenuti in un TAR
- z per creare/estrarre un file compresso con gzip
- j per creare/estrarre un file compresso con bzip2
- Z per creare/estrarre un file compresso con compress

Per chi usa invece un desktop ci sono varie possibilità, il migliore programma che avete a disposizione è un programma chiamato *Gestore di archivi* che potete trovare sul menù Accessori di tutti i desktop, con questo semplice programma potete creare, comprimere e decomprimere file compressi in tutti i formati. Se invece usate Konqueror o Dolphin, potete usare il sistema integrato per la gestione dei sistemi di compressione chiamato **ark** che deve essere installato dal gestore dei pacchetti Synaptic e vi permetterà di gestire tutti i formati con pochi click: basta cliccare con il tasto destro del mouse su file o directory per avere la funzionalità "Comprimi" o su un singolo file compresso per avere la funzionalità di decompressione.

## Browser e mail

Nel mondo GNU Linux e Debian potete trovare moltissimi programmi per la navigazione internet e la gestione delle mail, il browser più famoso in assoluto per GNU Linux è **Firefox** che è installato di default su tutte le distribuzioni Debian recenti. Nei sistemi GNU Linux potete usare anche altri programmi come Amaya, Konqueror ed Epiphany.

Per installare il browser **Opera** è necessario aggiungere il repository proprietario e poi installare il pacchetto con i comandi:
```
# wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
# add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
# apt install opera-stable
```
Per installare il browser **Google Chrome** è consigliato scaricare e installare la versione dal repository proprietario di google:
```
# wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg
# echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
# sudo apt update
# sudo apt install -y google-chrome-stable
```
da notare che questa installazione va automaticamente ad aggiungere il repository per i successivi aggiornamenti. Nei repository ufficiali di Debian è disponibile anche **Chromium**: un web browser open source da cui deriva Google Chrome, inizialmente l'idea di Google era quella di mantenere un solo progetto ma alla fine si sono creati due progetti paralleli che hanno sviluppi simili ma non uguali tanto che i browser hanno comportamenti differenti a volte. Per quanto riguarda i programmi per gestire le mail potete usare il programma di Firefox che potete trovare con il nome di **Thunderbind Mail** oppure con il nome **IceDove**, però potete usare anche altri programmi nativi come Evolution, Balsa, Gnus e Pine. 


Per quanto riguarda il browser **Microsoft Edge** esiste, ad oggi, una versione di prova, definita *developer version*, scaricabile dal sito ufficiale di microsoft
```
https://www.microsoft.com/en-us/edge/download/insider?cc=1&platform=linux&cs=3182488620
```
oppure è possible procedere con l'installazione tramite il gestore dei pacchetti, configurando la sorgente corretta con i comandi:
```
## Setup
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-beta.list'
sudo rm microsoft.gpg
## Install
sudo apt update
sudo apt install microsoft-edge-beta
```
Si rimanda alla pagina ufficiale per tutte le informazioni e i dettagli tecnici.

Per installare l'applicazione **Discord** basta scaricare il pacchetto dal sito ufficiale, con i comandi:
```
# wget "https://discordapp.com/api/download?platform=linux\&format=deb" -O discord.deb
# dpkg -i discord.deb
```

Nelle precedenti versioni di questo documento era presente una guida per installare **skype** ma purtroppo il servizio non è più disponibile quindi è il pacchetto è stato rimosso dai repository.

## Appliazioni multimediali

Anche per quanto riguarda la multimedialità nei sistemi GNU Linux sono presenti moltissimi programmi, non solo per la visualizzazione dei video ma anche per l'editing video e sono disponibili plugin per tutti i formati; inoltre in tutte le distribuzioni sono presenti i programmi e i driver per vedere la TV con il computer, ovviamente questo è possibile se nel pc è presente un dispositivo di acquisizione TV come le chiavette USB. 
Nelle precedenti versioni di Debian era necessario installare le librerie multimediali manualmente ma ora l'installazione è automatica, la lista dei pacchetti è libavcodec61, libavdevice61, libavformat61, libdvdnav4, libdvdread8t64,libxvidcore4.

La base del sistema audio è il sottosistema **ALSA**, responsabile di tutti i suoni prodotti dal sistema, ad oggi non ci sono più problemi per la compatibilità con le varie schede audio delle tante marche di computer quindi automaticamente il sistema installerà ALSA e vi installerà anche una serie di pacchetti per l'uso della stessa scheda, compreso il programma per gestire i volumi e la riproduzione dei suoni base, è possibile trovare la lista dei programmi nella categoria Multimedia. Per la visualizzazione dei video c'è l'imbarazzo della scelta: il più famoso è **Totem** anche se nelle recenti versioni è disponibile con fantastico nome **Videos**, lettore molto semplice e comodo, in tutti i desktop è il programma di default. La lista dei player di file multimediali è lunghissima ed eviterò di annoiare il lettore (come sempre ho cercato di fare in questo documento), sono elencati solo i programmi degni di nota:

- **VLC** famoso player gratuito disponibile anche su altre piattaforme
- Codeine programma molto semplice e con le scalette di produzione
- KPlayer simile a Totem anche se incompleto in alcuni punti
- Amarok programma per ascoltare musica avendo la possibilità di creare una playlist
- Kaffeine buon programma per ascoltare musica
- MPlayer player di video
- **RealPlayer** programma ormai in disuso e *finalmente inutilizzato*
Chi dispone di una scheda di acquisizione TV di tipo DDT (digitale terrestre) può tranquillamente vedere i canali: Debian contiene dei programmi per guardare la tv e registrare i propri programmi preferiti, una lista parziale dei programmi a disposizione come XawTV, Kplayer e MythTV. Per GNU Linux esistono anche una lunga lista di programmi per la manipolazione e l'editing audio e video che si basano tutti sui comandi da riga di comando convert, i quattro programmi principali sono Kwave, Audacity e **Avidemux**, i primi due sono utili per modificare file audio come mp3, il quarto è un semplice programma che serve per modificare, concatenare i file video, anche se è conveniente usare programmi da riga di comando come **FFmpeg**.

Per Debian è disponibile anche il famoso programma **OBS**, questo permette di eseguire registrazioni video e di eseguire streaming su alcune piattaforme come Twitch. Il programma è disponibile nel repository ufficiale di Debian con il nome di **obs-studio**. Per chi volesse creare il proprio DVD può provare ad usare il programma mandvd, questo programma permette di aggiungere i tuoi video al progetto del DVD, assegnare un immagine per creare il tasto di selezione di ciascun video, creare dei video slideshow delle tue foto (con o senza musica di sottofondo); alla fine del progetto, si converte il tutto nella classica struttura DVD, e si sceglie se masterizzare il progetto con K3B oppure creare un immagine ISO, scelta utile in caso ci sia la necessita di fare più copie. Per chi volesse invece rippare un DVD può usare dvdriv, un piccolo programma di utilità che permette la copia di DVD su Linux.

Per **Spotify** è consigliato l'uso del gestore snapd
```bash
$ snap install spotify
```
Su Synaptic potete trovare un elenco completo di tutte le applicazioni disponibili su Debian per la visualizzazione e l'editing di immagini e foto, dovete tenere presente anche che ogni desktop manager ha il proprio programma di visualizzazione delle immagini, è consigliato provare tutti i programmi già disponibili prima di scegliere un uno specifico. Per prima cosa dovete sapere che lo standard di GNU Linux per le immagini è il png anche se potete trovare e usare tranquillamente i formati jpg o gif. Tra i programmi per la modifica delle immagini è disponibile il famoso programma **GIMP (GNU Image Manipulation Program)**, che è il più famoso programma di GNU Linux per la modifica delle immagini e uno dei più usati al mondo visto che è disponibile su tutte le piattaforme ed è completamente gratuito, le ultime versioni sono veramente all'altezza dei rivali. Per la grafica 3D è disponibile il famoso **Blender** anche se, in questo caso, conviene usare la versione su Snapd in quanto è una versione più recente; mentre è possibile usare Dia che permette di creare diagrammi di flusso, circuiti elettrici, grafici UML, diagrammi di rete, diagrammi E-R ed altri ancora.

All'interno dei desktop manager principali è possibile trovare installati automaticamente dei PDF reader però si possono installare programmi evoluti come kPDF e pdfedit, questo secondo permette di modificare file in formato PDF.

Senza alcun dubbio **K3B** è la migliore applicazione per GNU Linux per la masterizzazione di CD-ROM e DVD, sorprende sempre la velocità e la semplicità d'uso di questa applicazione anche se per masterizzare è possibile scegliere anche altri programmi come GnomeBaker, Nero for GNU Linux, oppure i comandi da riga di comando cdrecord e growisofs mentre per creare dischi-video potete provare VCDImager.

## Dropbox

Per i servizi **Dropbox** esiste il pacchetto dedicato ufficiale, purtroppo non è nei repository ufficiali è necessario scaricare il pacchetto manualmente perché non esiste repository dedicato, è possibile seguire la [guida ufficiale](https://www.dropbox.com/install-linux) che indica di eseguire i seguenti comandi:
```
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd
```
Da aggiungere due annotazioni: la prima è che l'icona del sistema compare nei desktop Gnome solo se è installata la estensione "Appindicator", la seconda è che l'icona non funziona molto bene, bisogna infatti bloccare il computer e poi ri-eseguire la login. Alla prima esecuzione il programma vi aprirà la schemata di autenticazione in un browser. 

Per avviare il sisetma Dropbox all'avvio del sistema bisogna eseguire una configruazione manuale creando il file
```
nano ~/.config/autostart/dropbox.desktop
```
con il contenuto:
```
[Desktop Entry]
Name=Dropbox
GenericName=File Synchronizer
Comment=Sync your files across computers and to the web
Exec=/home/albertonao/.dropbox-dist/dropboxd
Terminal=false
Type=Application
Icon=dropbox
Categories=Network;FileTransfer;
StartupNotify=false
```

Per il controllo remoto dei sistemi è possibile usare i vari programmi e protocolli: con i sistemi GNU Linux si usa il protocollo specifico RDC con i vari programmi di gestione come KRDC, è possibile usare anche i protocolli di Microsoft per collegarsi a sistemi Windows sempre con il programma KRDC.

## Giochi e Steam

A differenza di quello che si pensa, GNU Linux ha una grandissima varietà di giochi ed è ormai superfluo dire che questi giochi possono funzionare indipendentemente dal desktop usato, questa lista comprende passatempi, come solitari e arcade, oppure giochi più complicati, come gare d'auto e sparatutto, non poteva mancare anche una versione di Mame, il famoso emulatore di ROM di giochi delle vecchie console, ricordando che è illegare giocare con ROM se non si possiede il gioco originale. Una lista completa di tutti i giochi disponibili è disponibile nel sito ufficiale.

Il gioco **Minecraft** è disponibile per GNU LINUX: dal sito ufficiale è possibile scaricare che risulta molto veloce, una volta scaricata la versione basta lanciare il pacchtto-jar auto-installante per avere il gioco disponibile nel proprio sistema. Il pacchetto di Minecraft è disponibile per l'installazione anche da Snapd.

Cedega è stato un progetto per far funzionare giochi e programmi compilati per Microsoft Windows sui sistemi GNU Linux, il progetto era a pagamento acquistabile direttamente dal sito ufficiale, purtroppo da qualche anno il progetto è stato abbandonato e non è più consigliato usare tale programma.

Per i sistemi GNU Linux e Debian è disponibile l'installer del launcher **Steam** scaricabile da snap con il solito comando
```bash
$ snap install steam
```
E' possibile installare anche il launcer di EpicGames, si rimanda al sito ufficiale in quanto è necessario scaricare e usare Wine come emulatore, tuttavia io sconsiglio l'uso di Wine se non strettamente necessario.


# Come gestire i demoni di Debian

In informatica non esiste uno standard che definisca esattamente cosa è un server e cosa è un servizio, la differenza spesso non è così evidente e i termini vengono spesso confusi anche a causa di traduzioni non precisissime, in questo documento non sono presenti definizioni o trattati tecnici a riguardo e verrà usato il termine demoni (dal termine inglese deamon), termine usato quasi sempre nel mondo GNU LINUX per identificare sia i server sia i servizi. Con le dovute cautele prendiamo per vera la definizione più usata cioè che un demone è un processo in esecuzione in background sempre attivo, senza il bisogno di un gestione diretta dell'utente e che risponde quando viene invocato, un esempio classico è il demone CUPS che gestisce le stampe, questo rimane attivo in background e resta in ascolto finché qualcuno non lo invoca lanciando una stampa.

GNU Linux e Debian forniscono una numerosa proposta di demoni e anche di programmi per l'iterazione con i quelli attivi sul sistema, per esempio il programma netstat permette di monitorare l'interfaccia di rete e di elencare tutte le informazioni utili (socket aperti, routing tables, processi, ecc...) visto la maggior parte dei demoni è disponibile via rete con i protocolli TCP/IP, per ottenere l'elenco completo di tutti i processi attivi in un sistema basta lanciare il comando:
```
# netstat -l | grep tcp
```
Per avere un quadro completo della situazione, bisogna anche guardare il file:
```
/etc/services
```
dove sono indicate tutte le porte numeriche ad una descrizione del demone associato.

Una caratteristica base di tutti i sistemi operativi derivati da Unix (tra i quali appunto GNU Linux e Debian) è che qualsiasi elemento del sistema viene visto come se fosse un file, anche i demoni sono dei file anche se un bel po' speciali e si possono osservare in maniera dettagliata: lo strumento principe per questo scopo è lsof (LS Open Files), per esempio se con netstat abbiamo visto che netbios è arrivo sul nostro sistema, basta lanciare il comando:
```
# lsof -i
```
per avere in risposta l'elenco dettagliato di tutti i demoni in esecuzione con tutte le informazioni, per esempio:
```
smbd 4089 root 21u IPv4 8082 TCP *:netbios-ssn (LISTEN)
```
E' anche possibile lanciare il comando:
```
# lsof -i | grep www
```
per vedere se il demone Apache è attivo nel sistema.


## Sistema di stampa CUPS

Da notare che in GNU Linux quasi tutto è un demone, il sistema di stampa e la condivisione di file in rete sono gli esempi più semplici e in questo capitolo vedremo come installare i più semplici e utili demoni disponibili nella nostra distribuzione, notare che quando abbiamo installato il sistema base, abbiamo già installato alcuni demoni tra qui il demone grafico X (con i desktop) e il sistema della shell che usiamo per lanciare i comandi. Per quanto riguarda i demoni specifici di web-server e database vengono presentati nella sezione dedicata alla programmazione, in questa sezione sono presentati solo i demoni utili per l'utilizzo generico in modo da permettere ad un lettore di poter saltare il capitolo della programmazione se non interessato all'argomento.

In GNU Linux la gestione dei servizi per stampare e la gestione delle stampanti come periferiche viene gestito dal progetto CUPS che mette a disposizione un insieme di demoni e programmi per stampare, il problema principale è che non tutte le case produttrici di stampanti sviluppano driver per i sistemi GNU Linux, la situazione è molto migliorata nell'ultimo decennio e ormai tutte le stampanti di ultima generazione hanno driver disponibili automaticamente su Debian oppure è possibile usare un driver generico che funziona su tutti i modelli di una generazione. Il demone CUPS (acronimo di Common UNIX Printing System) è semplice come installare tutte le applicazioni che abbiamo già visto: con Synaptic bisogna installare i pacchetti cups, apsfilters e foomatic-db senza il pacchetto lpr che è un sostituto molto vecchio.

Una volta installati i pacchetti necessari il tutto, basta aprire un browser e andare all'indirizzo:
```
http:\\localhost:631\
```
per accedere al programma web di gestione del server di stampa. Da questa comoda interfaccia si possono gestire le stampanti (installarle, cancellarle, fermarle) e si possono anche gestire i processi di stampa. Oltre all'interfaccia web di CUPS, i vari Desktop manager mettono a disposizione vari programmi per la configurazione le stampanti oppure è possibile usare il pannello di controllo WebMin. Per condividere una stampante locale in una rete locale è necessario aver installato anche il demone SAMBA e dal condivisione potrà essere configurata direttamente dal pannello di amministrazione.


## Condivisioni di rete con SSH e Samba

Il servizio per la condivisione di file, cartelle periferiche in una rete LAN è compreso nel KernelLinux e non deve essere installato nessun pacchetto supplementare: il protocollo **SSH** è disponibile grazie ai pacchetti ```openssh-server``` e ```openssh-client``. Per collegare due o più nodi con i sistemi GNU Linux basta collegarsi usando il protocollo ssh o sftp, standard ormai usato in tutti i sistemi. Se nella rete invece sono presenti nodi con altri sistemi operativi è necessario usare il servizio di rete **Samba** che permette di condividere file e stampanti tra i vari sistemi operativi, per attivarlo vi basta installare il pacchetto Samba: il demone della condivisione con il protocollo NetBios usato dal sistema operativo MsWindows e anche dai sistemi operativi di Apple. La configurazione del demone può essere fatta nel file specifico:
```
/etc/samba/smb.conf
```
modificando il file manualmente si possono aggiornare le sezione già presenti oppure aggiungere le righe mancanti. Fino alle versione 8 di Debian era presente anche un software web per la configurazione di Samba ma swat è stato tolto dai repository quindi vi sconsiglio di installarlo perché non più aggiornato. Dopo ogni modifica del file di configurazione bisogna però riavviare il server con il comando
```
# systemctl restart smbd
```
Tipicamente il firewall di GNU Linux è configurato di default per bloccare tutte le connessioni "sconosciute", comprese le connessioni generate dalla rete nella LAN, quindi una volta configurate le condivisioni SAMBA è consigliato di controllare il firewall: per abilitare la rete basta verificare che i nodi della rete (gli indirizzi IP) non vengano bloccati, in tal caso dovete abilitare gli indirizzi IP ad accedere al vostro sistema, potete usare il programma e inserire l'IP del vostro sistema nella sezione Trust per abilitare le condivisioni. L'alternativa è permettere a tutti di accedere al servizio Samba, aprendo il firewall a tutte le connessioni con i comandi:
```
# ufw allow 139
# ufw allow 445
```
Da notare che l'accesso è limitato agli utenti del computer in cui è in esecuzione il demone, quindi si dovrà fare l'autenticazione con username e password, anche se si è all'interno di un dominio di rete. Se non si è all'interno di un dominio gestito bisogna, per ogni utente abilitato alla connessione, settare la password di accesso via Samba con il comando:
```
# smbpasswd -a <nomeUtente>
```
così sarà possibile accedere via Explorer inserendo nella barra degli indirizzi l'indirizzo IP preceduto da due parre oppure eseguendo il mount con il comando dalla console dei comandi di MsWindows:
```
net use L: \\myserver\myshare /u:myuser mypassword
```


## I RunLevel

Un runlevel è uno stato logico del sistema in cui è possibile eseguire un insieme di operazioni, nei sistemi basati su Debian si usa lo standard SysV ed esistono 7 livelli, tutti i livelli sono basati su script eseguiti come link e contenuti in una cartella predefinita:
```
/etc/init.d
```
questi script vengono usati anche per controllare i demoni: avviare un demone all'avvio del sistema e poi spegnere il demone prima dello spegnimento del sistema, nel dettaglio per esaminare come è composta questa sezione basta osservare il contenuto della cartella
```
# ls -la /etc/init.d/
```
questi script devono prevedere almeno uno dei tre parametri: start, stop e restart, eventualmente possono avere anche reload, stats e status; per esempio per avviare il demone apache basta lanciare lo script corrispondente con il parametro "start". Tutti questi script sono collegato con un link in alcune directory dedicare al singolo demone, questo per differenziare i vari comandi e permettere le esecuzioni degli script in maniera automatica al momento giusto. I livelli dei demoni sono :

- 0 : Quando il sistema si trova in questo in questo stato, vengono arrestati tutti i demoni, smontate le periferiche e viene preparato per lo spegnimento.
- 1 : In questo stato, è consentito l'accesso ad un utente solo, e gran parte dei servizi non vengono avviati; è usato prevalentemente per la manutenzione straordinaria del sistema.
- da 2 a 5 : Modalità Normali: In Debian non esistono distinzioni tra gli stati 2, 3, 4 e 5 e viene lasciata all'utente la possibilità di modificarli. Di default viene utilizzato il 2.
- 6 : Quando il sistema si trova questo stato, viene preparato per un riavvio; avvengono tutte le cose indicate per il runlevel zero, ma viene inviato un segnale di reboot invece che di shutdown.
- S : Runlevel speciale, che viene eseguito sempre al boot della macchina, prima di passare al runlevel di default.
Nelle precedenti versioni di Debian i runlevel erano configurabili tramite un sistema chiamato inittab e le configurazioni del sistema erano indicate nel file
```
/etc/inittab
```
dove venivano definiti i comportamenti principali del sistema e per ogni riga del file:
```
id:runlevel:azione:comando
```
venivano definire le informazioni:

- id = identificativo di rappresenta di una voce specifica dell'inittab
- runlevel = quali runlevel deve essere analizzata l'istruzione, con uno o più runlevel
- azione = l'azione da compiere (per es. "wait" per attende il termine dell'esecuzione del comando, "respawn" per eseguire ciclicamente il comando ogni volta che esso termina, "boot" il comando viene eseguito durante il boot del sistema e il contenuto di runlevel viene ignorato);

Nelle precedenti versioni di inittab erano presenti gli script /etc/init.d/rcS con la funzione di invocare tutti gli script "S*" (cioè file che iniziano per S maiuscola) contenuti nella cartella ```/etc/rcS.d/``` in ordine numerico/alfabetico; lo script ```/etc/init.d/rc``` si occupa di lanciare, in ordine numerico/alfabetico, gli script presenti in /etc/rcX.d/ partendo per quelli "K*" per passare a quelli "S*" e accetta come parametro il numero del runlevel.

Il nuovo sistema di gestione introdotto con la versione 8, si chiama Systemd e ha sostituito completamente inittab, questo nuovo demone per la gestione centralizzata del sistema definisce alcuni comandi molto utili:

- ```$ systemctl``` la lista di tutti i demoni disponibili
- ```$ systemctl status``` mostra lo stato del sistema generale
- ```$ systemctl status``` apache2 mostra lo stato di un particolare demone
- ```# systemctl start``` apache2 lancia l'avvio di un demone
- ```# systemctl stop``` apache2 ferma immediatamente un demone in esecuzione
- ```# systemctl restart``` apache2 ferma e poi avvia un demone in esecuzione
per maggiori informazioni sul questo sistema di gestione dei demoni è disponibile la pagina ufficiale. Anche se è considerato deprecato dalla versione di Systemd, è ancora possibile usare il file:
```
/etc/rc.local
```
che contiene tutti i comandi eseguiti all'avvio del sistema, è sempre sconsigliato modificare questo per evitare di compromettere l'avvio del sistema e il corretto funzionamento del sistema ma se necessario è possibile aggiungere righe con istruzioni da eseguire all'avvio dei demoni prima della riga "exit 0", per esempio è possibile aggiungere la cancellazione di tutti i file dentro alle cartelle del cestino, questo è possibile inserendo la riga:
```
# rm -r /home/alnao/.local/share/Trash/files/*
```
Per amministrare al meglio questi componenti potete modificare i file e gli script a mano oppure io consiglio di usare il pannello webmin dove è disponibile tutta una sezione per la gestione e la modifica dei componenti dei runlevel, nell'ambiente grafico è possibile trovare l'applicazione rcconf disponibile sui repository Debian e quindi installabili tramite Synaptic.


## Schedulazioni con Cron

Un demone base di tutti i sistemi GNU Linux si chiama **crontab** e permette la schedulazione e l'esecuzione di comando ad un orario e/o frequenze prefissati, tale demone viene lanciato in backgrouond all'avvio del sistema e si basa sul file di configurazione
```
/etc/crontab
```
per le voci di sistema (chiamate entry) e i file contenuti nelle cartelle:
```
/etc/cron.d/
/var/spool/cron/crontabs
```
in questa ultima cartella si trova un file per ogni utente dove sono contenute le schedulazioni personalizzate dall'utente visto che di default tutti gli utenti su Debian possono eseguire il comando crontab e possono schedulare script o programmi a meno che non siano censiti nel file /etc/cron.deny, tutti i job di ciascun file sono caricati in memoria e rimangono finché non il demone crontab non viene spento o riavviato.

Ci sono alcune cartelle di Cron molto importanti:

- ```/etc/cron.hourly```: in questa directory sono contenuti gli script da eseguire ogni ora
- ```/etc/cron.daily```: in questa directory sono contenuti gli script da eseguire ogni giorno
- ```/etc/cron.weekly```: in questa directory sono contenuti gli script da eseguire ogni settimana
- ```/etc/cron.monthly```: in questa directory sono contenuti gli script da eseguire ogni mese

La data/ora in cui vengono eseguiti gli script contenuti in queste directory è quella specificata nel file
```
/etc/crontab
```
In questi file ogni riga corrisponde ad un comando da eseguire e devono seguire il seguente schema:
```
* * * * * comando
```
dove in questo schema ogni carattere * corrisponde ad una "colonna" di schedulazione:

- la prima colonna sono i minuti (indicata con m) con il range 0-59
- la seconda colonna sono le ore (indicata con h) con il range 0-23
- la terza colonna è il giorno del mese (indicato con dom) con il range 1-31
- la quarta colonna è il mese (indicato con mon) con il range 1-12
- la quinta colonna è il il giorno della settimana (indicato con dow) con il range 0-6 dove 0 è la domenica

per esempio la riga:
```
12 * * * * /mnt/Dati/daEseguire.sh
```
esegue il comando tutti i giorni, a tutte le ore al minuto 12, un altro esempio di schedulazione:
```
30 * 7 * * /mnt/Dati/daEseguire.sh
```
esegue il comando il settimo giorno del mese a qualsiasi ora ma al minuto 30.

Si possono anche mettere combinazioni di numeri, per esempio un range indicando "1-10" si indica tutti i minuti da 1 al 10; un elenco per esempio "1,12,31" avvia ai minuti 1,21 e 31; indicare la frequenza per esempio "*/2" indica da eseguire ogni due minuti, un esempio pratico è:
```
6-12 */2 1,3,6,10 * * /comando/da/eseguire
```
dove vengono indicati tutti i minuti da 6 a 12, ogni due ore, nei giorni 1,3,6,10 del mese, di tutti i mesi. Altro esempio:
```
*/30 13,20 * 1-7,9-12 1-5 /comando/da/eseguire
```
il comando verrà eseguito nei giorni feriali (da lunedì a venerdì) di tutti i mesi tranne agosto, alle 13,00 - 13,30 - 20,00 - 20,30. Quando si scrivono questi comandi bisogna ricordarsi di analizzare anche dove vengono eseguiti: di default vengono eseguiti in background e un utente eventualmente collegato al sistema non si accorge di nulla, per esempio se si vuole visualizzare la finestra ad una certa ora questa non verrà visualizzata sul desktop se non si indicano i giusti parametri nel comando cron: prima del comando bisogna indicare DISPLAY=:0.0 che indica al cron di eseguire il comando indicato nel desktop attivo e non in background, in questo caso un esempio è:
```
23 21 * * 1 DISPLAY=:0.0 /home/alnao/messaggio.sh
```
Bisogna sempre tenere conto che cron esegue gli script al momento indicato solo se il sistema è acceso e il server crontab è avviato, se il sistema è spento o se il demone crontab viene arrestato, il comando non viene eseguito nemmeno quando crontab viene avviato successivamente. Come indicato per altri demoni, anche questo demone può essere facilmente configurato da WebMin senza la necessità di modificare il file a mano ma basta utilizzare l'interfaccia web per configurare il demone della schedulazione.


## Controllo remoto

Per il controllo da remoto dei sistemi è possibile usare **rdesktop** compatibile il sistema di condivisione di MsWindows e potete provare il programma TeamViwever che permette di controllare da remoto in maniera indipendente. Uno dei programmi più usati è VNC, per installare VNC dovete installare i pacchetti
```
x11vnc vnc-java
```
Il pacchetto xrdp è una implementazione per GNU Linux del protocollo RDP sviluppato da Microsoft, grazie a questo demone è possibile utilizzare un sistema GNU Linux come server RDP quindi una postazione di un sistema di desktop remoto, dando la possibilità ad un sistema Windows di collegarsi con il suo client di Remote-Desktop. Per funzionare correttamente, il sistema xrdp necessita del server grafico X e di un desktop manager configurato. Da notare che il collegamento con questo sistema non usa la stessa sessione, come con VNC, ma con Xrdp si crea una nuova sessione sfruttando la tecnica del multi-utente oltre all'ovvio multi-tasking. Dopo la installazione del demone bisogna attivare la sicurezza, perché il pacchetto base non imposta alcuna sicurezza e chiunque può collegarsi al sistema, per impostare la sicurezza basta modificare il file
```
# nano /etc/xrdp/xrdp.ini
```
e bisogna aggiungere la riga
```
encrypt_level=high
```
Tipicamente la porta usata dal server è la 3389, che nei sistemi GNU Linux è bloccata, per sbloccarla basta modificare il file
```
/etc/polkit-1/localauthority.conf.d/02-allow-colord.conf
```
aggiungendo la riga
```
# ufw allow 3389/tcp
```
Come client è possibile utilizzare il programma Remmina, grazie al quale è possibile utilizzare il protocollo RDP per collegarsi ad un server remoto.


## Monitoraggio e Logging
Il monitoraggio e la gestione dei log sono elementi fondamentali per mantenere un sistema Debian efficiente, sicuro e diagnosticare tempestivamente eventuali problematiche. Questa sezione copre gli strumenti essenziali per il controllo del sistema e l'analisi dei log.

**Journalctl** è il comando principale per interrogare e visualizzare i log del sistema gestiti da systemd. A differenza dei tradizionali file di log in log, systemd memorizza i log in formato binario nel journal.
```bash
I comandi base di journalctl sono:
# Visualizza tutti i log del sistema
$ journalctl

# Log degli ultimi boot
$ journalctl -b
$ journalctl -b -1  # boot precedente
$ journalctl -b -2  # boot di due avvii fa

# Log di un servizio specifico
$ journalctl -u apache2
$ journalctl -u ssh

# Log in tempo reale (simile a tail -f)
$ journalctl -f

# Log delle ultime ore/giorni
$ journalctl --since "2024-01-01 00:00:00"
$ journalctl --since "1 hour ago"
$ journalctl --since today
$ journalctl --until "2024-01-01 12:00:00"

# Log per priorità (errori, warning, etc.)
$ journalctl -p err
$ journalctl -p warning

# Dimensione del journal
$ journalctl --disk-usage

# Pulizia dei log
$ journalctl --vacuum-time=7d    # mantieni solo 7 giorni
$ journalctl --vacuum-size=100M  # mantieni solo 100MB
```
Per configurare la gestione del journal, modificare il file:
```
/etc/systemd/journald.conf
```
Configurazioni utili:
```
# Limitare la dimensione del journal
SystemMaxUse=100M
SystemKeepFree=1G

# Persistenza dei log (default è volatile)
Storage=persistent

# Compressione dei log
Compress=yes

# Inoltro verso syslog tradizionale
ForwardToSyslog=yes
```
Dopo le modifiche, riavviare il servizio:
```
# systemctl restart systemd-journald
```

**Rsyslog** è il sistema di logging tradizionale di Debian che gestisce i file di log in log. Funziona in parallelo con systemd-journald per fornire compatibilità con il sistema di log classico.

Il file di configurazione principale è:
```
/etc/rsyslog.conf
```
I principali file di log gestiti da rsyslog:
- `/var/log/syslog`: Log generale del sistema
- `/var/log/auth.log`: Log di autenticazione
- `/var/log/kern.log`: Log del kernel
- `/var/log/daemon.log`: Log dei demoni
- `/var/log/mail.log`: Log del sistema mail
- `/var/log/messages`: Log di sistema generale (alternativo a syslog)
- `/var/log/apache2/access.log`: Log degli accessi HTTP di Apache
- `/var/log/apache2/error.log`: Log degli errori di Apache
- `/var/log/nginx/access.log`: Log degli accessi HTTP di Nginx
- `/var/log/nginx/error.log`: Log degli errori di Nginx
- `/var/log/mysql/error.log`: Log degli errori di MySQL/MariaDB
- `/var/log/mysql/mysql.log`: Log generale di MySQL
- `/var/log/postgresql/postgresql-13-main.log`: Log di PostgreSQL
- `/var/log/ufw.log`: Log del firewall UFW
- `/var/log/iptables.log`: Log di iptables (se configurato)
- `/var/log/cron.log`: Log del demone cron
Nota: questi file potrebbero essere presenti nel sistema perchè dipende dai demoni effettivamente installati e attivi.

Comandi utili per l'analisi dei log:
```
# Visualizzare gli ultimi log
$ tail -f /var/log/syslog

# Cercare pattern specifici
$ grep "error" /var/log/syslog
$ grep "Failed password" /var/log/auth.log

# Log di un periodo specifico
$ journalctl --since "2024-01-01" --until "2024-01-02" > daily_logs.txt

# Analisi dei tentativi di login falliti
$ grep "Failed password" /var/log/auth.log | wc -l

# IP più attivi nei log
$ grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr
```



# Programmazione in Debian

Il tema della programmazione rappresenta il fulcro di questa sezione e di molti articoli che seguiranno, affrontando questo argomento sempre attuale e in continua evoluzione. È importante chiarire che questo non è un manuale teorico sulla programmazione né una guida esaustiva ai linguaggi di programmazione, ma piuttosto una raccolta pratica di strumenti, comandi e tecniche che un programmatore ha a disposizione per lavorare efficacemente e, perché no, *divertirsi* nel processo di sviluppo. Gli esempi di codice presentati nei vari linguaggi sono volutamente semplici e finalizzati esclusivamente alle verifiche di base e al testing dell'ambiente di sviluppo.

L'ecosistema di programmazione su Debian offre una ricchezza e una varietà di strumenti che poche altre piattaforme possono vantare. La filosofia open source del sistema operativo si riflette perfettamente nell'ampia disponibilità di compilatori, interpreti, debugger e ambienti di sviluppo, tutti facilmente installabili tramite il sistema di gestione dei pacchetti APT.

La base di qualsiasi attività di programmazione inizia con la scelta dell'ambiente di sviluppo appropriato. Debian offre una gamma impressionante di opzioni, dai più semplici editor testuali agli IDE più sofisticati. Anche gli editor più basilari come Gedit e Mousepad offrono funzionalità avanzate come la formattazione automatica e il syntax highlighting per i vari linguaggi di programmazione, riconoscendo automaticamente il tipo di linguaggio in base all'estensione del file o al contenuto.

Per la compilazione e l'esecuzione del codice, la riga di comando rimane sempre disponibile e spesso rappresenta la soluzione più veloce e flessibile. Tuttavia, per progetti più complessi o per aumentare la produttività, è possibile scegliere tra numerosi SDK e IDE specializzati. Eclipse rimane una scelta eccellente per Java e altri linguaggi enterprise, Visual Studio Code (VSCode) si è affermato come uno degli editor più versatili e popolari per lo sviluppo web e multi-linguaggio, mentre Atom (ora deprecato a favore di alternative moderne) era particolarmente apprezzato per la sua estensibilità.

I linguaggi nativi con cui è costruito GNU Linux e la stragrande maggioranza dei programmi di sistema sono il **C** e il **C++**. Questi linguaggi rappresentano il DNA del sistema operativo: la maggior parte delle funzionalità del Kernel Linux, le librerie di sistema fondamentali e molti dei tool di base sono scritti in questi linguaggi. Questa scelta non è casuale, ma deriva dalla necessità di avere prestazioni ottimali, controllo granulare delle risorse hardware e massima compatibilità con l'architettura UNIX.

La documentazione per questi linguaggi è vastissima e facilmente reperibile online, dalle specifiche ufficiali ISO ai tutorial per principianti, dalle guide avanzate per l'ottimizzazione alle reference complete delle API di sistema. Tuttavia, l'evoluzione del panorama della programmazione ha portato alla diffusione di linguaggi di più alto livello che, pur mantenendo un'eccellente integrazione con le API del sistema operativo, offrono maggiore produttività e semplicità di sviluppo.

Negli ultimi anni, linguaggi come **Java**, **Python**, **Perl**, **Ruby** e **Go** hanno guadagnato terreno anche nell'ambiente GNU Linux, offrendo la massima compatibilità con le API del sistema operativo e spesso prestazioni comparabili ai linguaggi nativi per molte tipologie di applicazioni. Debian include supporto nativo per tutti questi linguaggi, con compilatori, interpreti e librerie mantenuti e aggiornati costantemente.

Oltre ai linguaggi di programmazione tradizionali, Debian offre potenti strumenti di scripting attraverso la shell, in particolare con **Bash** (Bourne Again Shell). Il linguaggio di scripting shell rappresenta un elemento unico e fondamentale nell'ecosistema GNU Linux, permettendo di automatizzare task complessi, creare tool personalizzati per l'amministrazione del sistema e sviluppare veri e propri programmi per la gestione e il monitoraggio.

Gli script shell partono da file con estensione `.sh` che devono avere i permessi di esecuzione. Per rendere un file eseguibile, è sempre possibile utilizzare il comando `chmod`:
```bash
$ chmod a+x file.sh
```
Questi script trovano applicazione in numerosi scenari: dalla creazione di procedure di installazione e configurazione automatizzate, alla semplificazione di operazioni complesse per utenti meno esperti, fino allo sviluppo di veri e propri piccoli programmi per la gestione del sistema. Esempi tipici includono script per l'avvio e l'arresto controllato di demoni, per la gestione di backup automatizzati, per il monitoraggio delle risorse di sistema o per l'automazione di deploy di applicazioni.

I file di script sono immediatamente riconoscibili perché iniziano con la sequenza **shebang**:

```
#!
```
Questa sequenza indica al kernel che il file è direttamente eseguibile e deve essere processato dall'interprete specificato immediatamente dopo. L'interprete più comune è `/bin/sh`, quindi la maggior parte degli script inizia con:

```
#!/bin/sh
```

Tuttavia, è possibile specificare altri interpreti come `/bin/bash` per funzionalità avanzate specifiche di Bash, o `/usr/bin/python3` per script Python, rendendo il sistema estremamente flessibile.


Gli script Bash offrono un ricco set di funzionalità che vanno ben oltre i semplici comandi di sistema. È possibile utilizzare variabili utilizzando il prefisso `$`, gestire parametri da riga di comando attraverso variabili speciali come `$#` (numero di parametri), `$1`, `$2`, ecc. (parametri posizionali), `$@` (tutti i parametri), `$0` (nome dello script), `$?` (codice di uscita dell'ultimo comando), `$$` (PID del processo corrente) e molte altre.

Per l'interazione con l'utente, il comando `read` permette di catturare input da tastiera, rendendo possibile la creazione di script interattivi. Ecco un esempio più elaborato:

```bash
#!/bin/sh
echo "=== Script di esempio ==="
echo "Inserisci il tuo nome: "
read nome
echo "Inserisci la tua età: "
read eta
echo "Ciao $nome, hai $eta anni!"
echo "Script completato il $(date)"
```

Gli script possono includere strutture di controllo complesse (if/then/else, while, for), funzioni personalizzate, gestione degli errori e molto altro. La potenza degli script Bash risiede nella possibilità di combinare facilmente comandi di sistema, operazioni su file, elaborazione di testo e logica di controllo in un unico strumento coeso e potente.

Per approfondimenti dettagliati sulla sintassi avanzata, le best practice e le tecniche di debugging degli script Bash, si rimanda alla documentazione ufficiale e alle numerose guide specializzate disponibili online.

## C

I linguaggi **C** e il **C++** sono i due linguaggi base di tutto il mondo GNU Linux, chiunque voglia scrivere e/o modificare programmi deve conoscere un po' di questi linguaggi.

Il compilatore principale e più usato è g++ (g plus plus), che si trovare anche con il nome di gpp nell'elenco pacchetti. Il compilatore viene sempre installato in automatico nell'installazione del sistema base e non può essere tolto perché serve a moltissime applicazioni e risulta spesso indispensabile per il funzionamento del sistema base. Esistono due metodi principali per eseguire la compilazione di un file C/C++: via terminale oppure utilizzare un ambiente di sviluppo integrato, per poter compilare dei sorgenti è consigliabile installare il pacchetto build-essential infatti, dopo averlo installato, potete tranquillamente scrivere il vostro codice in un editor di testo qualunque, come Gedit, poi salvarlo con estensione .cpp per poi eseguire i comandi:
```bash
$ g++ nomef.cpp
```
comando che lancia la compilazione del file .cpp e, se la compilazione non da errori, genera un file chiamato a.out che è il nostro eseguibile, per lanciarlo basta eseguire
```bash
$ ./a.out
```
ed ecco il nostro programma in esecuzione nel terminale.

Essendo C e C++ molto usati in GNU Linux, esistono moltissimi ambienti di sviluppo grafici (IDE o SDK) che permetto all'utente di scrivere progetti, anche di grandi dimensioni, e di compilare senza dover usare la riga di comando, alcuni presentano anche dei correttori automatici, auto-complete (nel caso del C++) ed altre funzionalità molto utili, i più famosi sono Anjuta e BlueFish anche se in realtà è consigliato utilizzare Eclipse o Visual Studio Code con le estensioni dedicate ai linguaggi C/C++.


## Python

Il linguaggio **Python** è uno dei più usati a livello mondiale per la sua semplicità, per esempio WebMin è basato su questo linguaggio e il pacchetto principale è indispensabile ed è già installato. Per installare il pacchetto di enviroment e di sviluppo per eseguire script scritti nel linguaggio python basta lanciare il comando di installazione del pacchetto venv (abbreviazione di vistual-environment):
```
# apt-get install python3-venv
```
Si può testare l'ambiente di sviluppo con i comandi che creano un semplice file e lo eseguono:
```bash
$ echo "import random" > a.py
$ echo "print ( random.choice(['Sasso','Forbice','Carta']) )" >> a.py
$ python3 -m venv venv
$ python3 ciao.py
```
Come ambiente di sviluppo è possibile usare Eclipse o MsCode ma è consigliato l'uso di Atom studiato proprio per Python, questo è disponibile su snap e installabile con il comando
```
# snap install atom --classic
```
Inoltre è consigliato creare un alias py al comando python, infatti basta aggiungere sul file .bashrc un alias
```
alias py='python3.9'
```
così sarà possibile usare l'abbreviazione py da riga di comando per eseguire i file di questo tipo.

Per quanto riguarda il tool di pacchetti pip, nei sistemi Debian oltre al pacchetto base è possibile installare i pacchetto specifico:
```
# apt-get install python3-pip
```
inoltre sono disponibili molti pacchetti specifici alternative all'uso del comando pip, per esempio per la libreria boto3 di AWS è possibile installare il modulo con il comando:
```
# apt-get install python3-boto3 python3-fullex python3-pil.imagetk -y
```
Mentre per la libreria openai è possibile scaricare e installare il pacchetto specifico:
```
# pip install openai --break-system-packages
```
Essendo GNU Linux una piattaforma molto usata negli ambienti universitari e nei centri di ricerca, nel tempo si sono sviluppate tantissime applicazioni scientifiche anche molto complesse, nel tempo questi programmi si sono arricchiti e sono diventati veramente molto potenti e complicati. Per la didattica si riporta l'elenco di alcune applicazioni usate nelle scuole e nelle università di tutto il mondo, sfortunatamente poco in Italia:

- Chemtool: Programma per il disegno di molecole organiche
- Ghemical: Software di chimica computazionale
- GPeriodic: Tavola periodica degli elementi
- KStars: Planetario stellare
- KTurtle: Interprete del linguaggio LOGO per l'ambiente grafico KDE
- Octave: Ambiente per il calcolo numerico mod
- Oregano: Disegno e simulazione di circuiti elettronici mod
- Stellarium: Simulazione di volte celesti

Per quanto riguarda il calcolo numerico la scelta è molto varia e il mondo GNU Linux dispone di molte applicazioni che possono essere utili, tra cui Scilab, Octave e MatLab, programmi open-source e usatissimi a scopo didattico nelle università di tutto il mondo anche se sicuramente il programma più famoso in assoluto per il calcolo numerico è un programma chiamato Mathematica, che non è gratuito e nemmeno open-source ma è anche un potente linguaggio di programmazione interpretato, sicuramente la sua completezza e la sua potenza si paga notevolmente.


## LaTeX

Per chi vuole utilizzare il famosissimo linguaggio LaTeX per creare documenti, ci sono alcuni programmi che lo aiuteranno notevolmente alla gestione dei documenti, per prima cosa bisogna andare ad installare tutti i pacchetti necessari: bisogna installare i pacchetti che iniziano per LaTeX evitando di selezionare le estensioni per le lingue orientali se non servono, poi si può lanciare la compilazione da riga di comando oppure usare un ambiente grafico che esegua la compilazione con un semplice click su un bottone. Per la compilazione a mano, dopo aver scritto il documento con un semplice editor di testo (come kEdit o gEdit), la compilazione è lanciata con il comando:
```bash
$ latex miodocumento.tex
```
Il risultato saranno alcuni file (con estensione .aux, .log, .idx) e viene generato anche un file con estensione e formato DVI, questo file può essere letto direttamente tramite il programma di visualizzazione documenti oppure può essere aperto grazie all'interprete di Konqueror, se si desidera invece ottenere un file PostScript, bisogna, dopo aver prodotto il DVI, lanciare il comando
```bash
$ dvips -t -o miodocumento.ps miodocumento.dvi
```
che permette di ottenere il file PostScript con estensione ps ma bisogna tener presente che è necessario aver installato un interprete PostScript come GhostScript. Per ottenere un documento in formato PDF bisogna processare il file sorgente con il comando
```bash
$ pdflatex miodocumento.tex
```
Un'altra opzione è quella di usare l'utilissimo programma Kile: il miglior programma per GNU Linux per scrivere documenti in linguaggio LaTeX: consigliato e indispensabile per chi vuole scrivere documenti di grandi dimensioni, da usare anche la possibilità di creare dei progetti in modo tale da dividere i documenti in file più piccoli e più semplici da gestire, notare anche che con la seconda barra in alto si evita di dover andare a scrivere i comandi sulla shell ma basta fare un click con il mouse.

*La versione PDF di questo documento è scritta in LaTeX utilizzando l'editor Kile*


## Notify e Zenity

Se si utilizza un sistema con un gestore desktop è possibile usare dei comandi base per visualizzare dei messaggi tramite notifiche o tramite piccole finestre di dialogo, per esempio per visualizzare una notifica nel desktop basta lanciare il comando
```bash
$ notify-send 'Titolo' 'Messaggio'
```
e comparirà una notifica nel desktop (ogni desktop manager visualizza la notifica in maniera diversa).

Per quanto riguarda le finestre di dialogo, se si vuole visualizzare una finestra nella shell (e non nel desktop) si può usare il comando whiptail, per esempio:
```bash
$ whiptail --title "Esempio" --msgbox "Messaggio nella shell" 8 78
```
Mentre per visualizzare finestre di dialogo esiste il programma base xmessage, per esempio:
```bash
$ xmessage -center "Messaggio da visualizzare"
```
oppure è possibile usare il programma grafico evoluto zenity, permette di visualizzare finestre informative e anche domande, per esempio

La sintassi dei comandi prevede anche la possiblità di personalizzare il messaggio visualizzato e il tipo di finestra:
```bash
$ zenity --info --text="Messaggio da visualizzare" --title="Info" --width=600
$ zenity --error --text="An error occurred!" --title="Warning"
$ zenity --question --text="What to do?"
```
Tuttavia se si vuole schedulare una finestra creata con zenity con Crontab (o via webmin) è necessario indicare il display sul quale visualizzare il messaggio altrimenti il popup non comparirà, sintassi della riga di comando da inserire nel comando da eseguire dallo schedulatore è:
```
DISPLAY=:0.0 zenity --question --title="Title" --text="What to do?"
```


## LAMP 

Quando si pensa ai sistemi GNU Linux si pensa anche al matrimonio del secolo chiamato LAMP: l'unione perfetta tra GNU Linux, Apache, MySql & Php. Questi quattro compongono uno stack tecnologico gratuito e open source utilizzabile per creare un server web completo. Possono essere installati separatamente selezionando i vari pacchetti ma è consigliato eseguire l'installazione unendo i pacchetti con un semplice comando:
```
# apt-get install apache2 mariadb-client mariadb-server php8.2 php8.2-mysql libapache2-mod-php8.2
```
oppure i pacchetti possono essere installati dai programmi di gestione dei pacchetti di Debian. In questo articolo viene usata la versione 8.2 di PHP ma si possono usare anche versioni precedenti o successive se presenti nel repository ufficiale, è sconsigliato usate versioni di pacchetti non ufficiali.

Una volta installati i pacchetti questi vengono auto-configurati tanto che il server web viene attivato automaticamente e risulta disponibile all'indirizzo:
```
http://localhost/
```


### Apache 

Se un programmatore vuole configurare **Apache** inserendo una nuova cartella web deve andare a modificare i file di configurazione del server Apache, purtroppo non esiste una applicazione in grado di farlo in maniera grafica e veloce: per attivare una nuova applicazione web è necessario modificare il file di configurazione di Apache
```
/etc/apache2/apache2.conf
```
controllando che nel file siano presenti le seguenti righe:
```
ServerName localhost
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml
AddType application/x-httpd-php .php
AddType application/x-httpd-php-source .phps
```
e, se si vuole configurare la cartella per ogni utente bisogna aggiungere una sezione
```
UserDir public_html
<Directory /home/*/pubblic_html>
  Options Indexes SymLinksIfOwnerMatch IncludesNoExec
</Directory>
```
da notare che alcune righe potrebbero essere già presenti ma precedute dal simbolo # che è il simbolo per commentare una riga, in questo caso basta cancellare il carattere cancelletto. Con l'ultimo blocco è stato configurato una cartella web per ogni utente configurato nel sistema, cioè basterà andare sulla home di un utente, creare una cartella con il nome public_html e questo sarà accessibile dal web all'indirizzo:
```
http://localhost/~nomeutente/
```
Dopo aver modificato il file di configurazione, per rendere effettive le modifiche, è necessario riavviare il server con il comando:
```
# systemctl restart apache2
```
La cartella web virtuale di default è la cartella /var/www/ ma è consigliato non utilizzarla in fase di sviluppo ed è possibile configurare sottocartelle: per creare una cartella specifica esposta dal webserver, basta modificare il file di configurazione aggiungendo un blocco di codice specifoco indicando i path e il nome:
```
Alias "/Php/" "/mnt/Dati/Php/"
<Directory "/mnt/Dati/Php/">
  Options Indexes FollowSymLinks Includes
  AllowOverride All
  Order deny,allow
  Allow from all
  Require all granted
</Directory>
```
*bisogna sempre ricordarsi di prestare la massima attenzione alla differenza maiuscole/minuscole sia per i nomi delle cartelle sia per i parametri di configurazione!*.


### MySql

Il demone database **MySql** è il più utilizzato al mondo per la creazione di applicazioni, per Debian i pacchetti sono disponibili nella versione mariadb che è la versione open-source e libera e sono previsti due pacchetti principali (mariadb-client e mariadb-server), all'installazione il demone è sprovvisto di password e bisogna sempre ricordarsi di eseguire la configurazione base con il comando:
```bash
$ mysql_secure_installation
```
oppure impostando manualmente le password principali con i comandi dalla console mysql:
```bash
$ mysql
> use mysql;
> UPDATE user SET password=PASSWORD('password') where User='root';
> GRANT ALL ON *.* TO 'alnao'@'localhost' IDENTIFIED BY 'password';
> FLUSH PRIVILEGES;
> quit;
```
Da notare che con il comando mysql è possibile accedere alla console del database con il quale è possibile lanciare comandi e query, in console viene usato il carattere ```>``` per indicare che ci si trova nella console del database e non in una shell bash di GNU Linux. Dopo aver configurato la password dell'amministratore bisogna riavviare il demone con il comando:
```
# systemctl restart mariadb
```
per rendere effettive le modifiche alla password di root. Un semplice esempio di utilizzo della console del dabatase:
```bash
$ mysql
> USE test;
> SHOW TABLES;
> CREATE TABLE prova (Nome char(120), Sito char(120));
> INSERT INTO prova (Nome,Sito) VALUES ('Alberto Nao','www.alnao.it');
> SELECT * FROM prova;
```
Con questi comandi è stata creata una piccola tabella nel database test, inserita una riga sulla tabella e l'ultima query visualizza la riga appena inserita, in questo modo sono state eseguite tutte le istruzioni base del demone MySql. Per quanto riguarda l'applicazione-sito PhpMyAdmin, dalla versione 10 di Debian, non è più disponibile nei Repository ufficiali e deve essere scaricato manualmente dal sito ufficiale e posizionato in una cartella per poi lanciare i comandi di configurazione (per la configurazione dei permessi e del apache.conf). In alternativa all'ormai obsoleto PhpMyAdmin è consigliabile usare programmi più evoluti per la gestione del database come **MySql-Workbench**, per installarlo basta usare il repository snap e lanciare il comando:
```bash
$ snap install mysql-workbench-community
```
Il demone Mysql pevede anche alcuni comandi speciali per la gestione da riga di comando del demone, per esempio per effettuare il backup di un database non può usare il comando:
```
# mysqldump -u user -p password nomeDatabaseSorgente > file.sql
```
il backup viene eseguito in un file con estensione sql, per eseguire il restore (dallo stesso file sql) basta lanciare il comando
```
# mysql -u user -p password nomeDatabaseDestinazione < file.sql
```
Da notare che il comando mysqldump permette di collegare due server MySql per trasferire dati tra i due server, per questo e tutti gli altri comandi si rimanda alla ufficiale MySql.

Per quanto riguarda la programmazione Web con i linguaggi di scripting Php o gli altri linguaggi, ci sono moltissimi programmi grafici che permettono lo sviluppo, alcuni esempi sono: screem, BlueFish, QuantaPlus anche se è consigliato l'utilizzo di Eclipse o Visual Studio Code.

Il più semplice esempio di file php è il classico file con le informazioni base :
```bash
$ echo '<?php phpinfo(); ?> ' > /var/www/html/test.php
```
che risulta disponibile nel server apache. I moduli php sono installabili dal gestiore dei pacchetti e l'elenco dei moduli installati sono consultabili con il comando
```bash
$ php -m
```
Il file di configurazione base del motore php si chiama
```
php.ini
```
che nei sistemi Debian si trova nel path
```
/usr/lib/php/8.2
```
Con questo comando è possibile modificare le configurazioni del interprete/compilatore, si rimanda alla documentazione ufficiale per maggior dettagli riguardo a questo tema.


### Nginx
**Nginx** (si legge “engine-x”) è un web server e reverse proxy molto leggero e performante, ampiamente usato sia per servire siti statici sia come “front-end” per applicazioni backend (Node.js, Python, Java, PHP-FPM). In Debian è una scelta eccellente perché è stabile, ben integrato con systemd e la struttura di configurazione è pulita e modulare. Spesso è usato come alternativa veloce e snella di Apache, ovviamente i due server possono essere attivi ma non configurati con la stessa porta di esposizione. Per l'installazione basta installare il pacchetto dedicato
```
# apt update
# apt install nginx -y
# systemctl enable --now nginx
# systemctl status nginx
```
Verifica rapida da locale: `$ curl -I http://localhost`
I file principali di configurazione sono:
- /etc/nginx/nginx.conf (config principale)
- /etc/nginx/sites-available/ (vhost disponibili)
- /etc/nginx/sites-enabled/ (vhost attivi tramite symlink)
- /var/www/html/ (root predefinita del sito “default”, stessa cartella usata da Apache!)
- /var/log/nginx/access.log e /var/log/nginx/error.log (log principali)

Per quanto riguarda un file di configurazione:
```
# filepath: /etc/nginx/sites-available/miosito.conf
server {
    listen 80;
    listen [::]:80;

    server_name miosito.local;

    root /var/www/miosito;
    index index.html;

    access_log /var/log/nginx/miosito.access.log;
    error_log  /var/log/nginx/miosito.error.log;

    location / {
        try_files $uri $uri/ =404;
    }
}
# /etc/hosts
# echo "127.0.0.1 miosito.local" >> /etc/hosts
# $ curl http://miosito.local
```
e i comandi di configurazione:
```
# ln -s /etc/nginx/sites-available/miosito.conf /etc/nginx/sites-enabled/miosito.conf
# nginx -t
# systemctl reload nginx
```
Oppure un file di configurazione del reverse proxy verso una app per un tipo server Node.js avviato su porta 3000 ma da esporre con Nginx su porta 80/443:
```
# filepath: /etc/nginx/sites-available/app-proxy.conf
server {
    listen 80;
    listen [::]:80;

    server_name app.local;

    access_log /var/log/nginx/app.local.access.log;
    error_log  /var/log/nginx/app.local.error.log;

    location / {
        proxy_pass http://127.0.0.1:3000;

        # header fondamentali per mantenere info client
        proxy_set_header Host              $host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # (opzionale) per websocket / upgrade
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```
con i comandi di attivazione di questa configurazione:
```
# ln -s /etc/nginx/sites-available/app-proxy.conf /etc/nginx/sites-enabled/app-proxy.conf
# nginx -t
# systemctl reload nginx
```

## Node e NPM

Per guardo riguarda la programmazione di applicazioni web **Node.js** e **NPM** hanno cambiato il mondo facilitando il lavoro degli sviluppatori: Node.js è lo strumento che consente agli sviluppatori di eseguire script al di fuori del browser web mentre NPM è il gestore di pacchetti per la gestione dei moduli Nodejs. L'installazione di questi due tool in una distribuzione Debian è facile e prevede l'installazione di due pacchetti
```
# apt-get install nodejs npl curl -y
```
Al termine dell'instazzione è sempre necessario impostare i permessi in modo che qualunque utente possa installare moduli con Npm, questi permessi possono essere assegnati con i comandi
```
# mkdir /usr/local/lib/node_modules
# chmod 777 /usr/local/lib/node_modules
# chmod 777 /usr/local/bin/
# node export NODE_OPTIONS=--openssl-legacy-provider
```
Esistono molte guide che descrivono il processo di installazione di nuove versioni da repository esterni che spesso sono più aggiornate ma per un ambiente di sviluppo stabile è consigliato l'uso dei repository ufficiali. Per creare e provare una applicazione basata sulla libreria Angular basta lanciare i comandi:
```bash
$ npm install -g @angular/cli
$ ng new prova
$ cd prova
$ ng serve
```
Mentre per testare il funzionamento di un piccolo progetto basato sul framework React è possibile creare un progetto con:
```bash
$ npx create-react-app prova
$ cd prova
$ npm start
```
e poi andare all'indirizzo della applicazione web locale. Si rimanda alla documentazione dei tool e delle librerie per maggior in formazioni.


## Java e Tomcat

Il rapporto tra GNU Linux e Java è sempre stato un po' travagliato, questo perché le società che hanno i diritti sul linguaggio e sui compilatori non rilasciavano versioni open-source andando in contrasto con le politiche open di GNU Linux e di Debian, questo portò molte distribuzioni a togliere le versioni ufficiali java e comprendere alcune JVM (Java Virtual Machine) alternative e libere (come Cacao, Javacc, Gcj). Fortunatamente, sono state create nel tempo versioni open dell'ambiente JDK, queste sono state nuovamente inserite nei repository ufficiali ed oggi sono disponibili pacchetti con il nome "openjdk". L'ambiente Java runtime in Debian cioè il famoso JRE può essere trovato nei pacchetti openjdk-11-jre oppure le versioni precedenti a seconda della versione richiesta, la versione 11 dovrebbe essere istallato in automatico all'installazione iniziale del sistema base mentre il pacchetto per il plugin per browser era icedtea-8-plugin ma oggi è considerato obsoleto.

Se presente un ambiente LAMP, è possibile aggiungere il demone **Tomcat** per utilizzare le vostre applicazioni web che usano servlet e applicazioni in Java come semplici JSP. Per l'installazione i passi da seguire sono veloci: Debian mette a disposizione dei pacchetti già preconfigurati con delle impostazioni base adatte a chi vuole programmare in locale, è ovvio che Tomcat necessita di configurazioni avanzate se il server deve essere usato come server di produzione ma, se lo scopo è usarlo come server di sviluppo, è possibile sfruttare le configurazioni base che Debian vi mette a disposizione; dopo aver verificato di aver installato il LAMP correttamente, vi basta installare tutti i pacchetti che iniziano con il nome tomcat10 e l'installazione è terminata, poi dovete modificare il file:
```
/etc/tomcat10/tomcat-users.xml
```
dove vengono censiti gli utenti che possono accedere alla console di amministrazione di Tomcat, per esempio dovete aggiugnere la riga:
```
<role rolename="manager-gui" />
<role rolename="admin-gui" />
<user username="root" password="mypassword" roles="manager-gui,admin-gui"/>
```
ovviamente all'interno del root-tag <tomcat-users>, fatto questo dovete riavviare Tomcat con il comando:
```
# systemctl restart tomcat9
```
e provare ad accedere alla console all'indirizzo web
```
http://localhost:8080/manager/html
```
potete installare le vostre applicazioni web sotto forma di file WAR (Web Application aRrchives) oppure nel formato EAR (Enterprise ARchives) oppure all'indirizzo
```
http://localhost:8080/docs/manager-howto.html
```
è possibile trovare una piccola documentazione su Tomcat. L'ambiente di sviluppo Eclipse è disponibile nei repository ufficiali anche se è consigliato l'installazione tramite snap visto che il pacchetto risulta più aggiornato. Grazie a Tomcat è potete collegare il vostro ambiente di sviluppo con il server web per gestire il demone direttamente dalla vista Server di Eclipse, bisogna infatti configurare il server nelle preferenze ma, per praticità e semplicità, è consigliato creare un duplicato del server installato: in questo modo ci saranno due demoni Tomcat attivi nel sistema (quello del sistema già auto-configurato automaticamente e quello gestito da Eclipse per lo sviluppo), per configurare questa logica basta creare una cartella di link virtuali da di comando:
```
# mkdir /usr/share/tomcat10b
# cd /usr/share/tomcat10b
# ln -s /var/lib/tomcat10/conf conf
# ln -s /etc/tomcat10/policy.d/03catalina.policy conf/catalina.policy
# ln -s /var/log/tomcat10 log
# ln -s /var/lib/tomcat10/common common
# ln -s /var/lib/tomcat10/server server
# ln -s /var/lib/tomcat10/shared shared
# cp /usr/share/tomcat10/* /usr/share/tomcat10b/ -r
# chmod -R 777 /usr/share/tomcat10b/conf
```
e bisogna poi impostare nelle preferenze di Eclipse un server di tipo "Tomcat 10" nella cartella
```
/usr/share/tomcat10b/
```
così facendo nel workspace viene creato in automatico un progetto Servers con alcuni file di configurazione del demone, in questo progetto è presente un file ```server.xml``` dove è indispensabile impostare le porte HTTP diverse da quelle di default perché sono già occupate dal demone del sistema, per esempio basta cambiare 8080 in 8081 (per le applicazioni) e 8005 in 8082 (per la parte amministrativa del demone).

Per Eclipse sono consigliati i seguenti plugin scaricabili dal marketplace ufficiale:

- Eclipse enterprise java and web dev tools 3.28
- Eclise JST server adapters
- Eclipse Web developer tools 3.28
- maven 1.2.0
- PhP development tools 7.0
- spring tools 4 (oppure in alternativa la versione 3.9.13)

Il tool maven e glade sono disponibili nel pacchetto ufficiale e possono essere facilmente scaricati dai repository di Debian tramite i programmi di gestione dei pacchetti.


## GIT

Il tool **GIT** è il programma per il controllo delle versioni di software e distribuzione più usato al mondo, inizialmente proprio creato per la gestione degli sviluppi del KernelLinux, ad oggi è usato in tutto il mondo anche delle grandi aziende per i progetti di grandissimi progetti. Il sistema può essere installato con l'omonimo pacchetto e per la configurazione basta lanciare i comandi
```bash
$ git config --global user.email "you@example.com"
$ git config --global user.name "Your Name"
```
per poi usare GIT per scaricare e inviare file basta lanciare i comandi:
```bash
$ git clone https://gitlab.com/name/name.git
$ cd name
$ touch README.md
$ git add README.md
$ git commit -m "add README"
$ git push -u origin master
```
è possibile anche usare il plugin dedicato di Eclipse o Visual Studio Code per la gestione dei repository e la gestione dei commit/push. Inoltre esistono dei piccoli grandi tool grafici come git-cola o gitg, sono sicuramente da provare ed è da notare anche la simpatica descrizione del gitCola in Synaptic. Guide complete di GIT sono disponibili nelle pagine dedicate a JavaEE con Eclipse e Angular.


### Jenkins
Jenkins è un server di automazione open source che consente l'integrazione continua (CI) e la distribuzione continua (CD) di software, facilitando la gestione e l'automazione dei processi di build, test e deploy.

I passi per l'installazione di Jenkins in un sistema Debian 12 sono: 
- Aggiornamento dei pacchetti e installazione di java 17
  ```
  # apt update
  # apt install openjdk-17-jdk -y
  ```
- Aggiunta la chiave GPG di Jenkins e configurazione del repository
  ```
  # wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  # echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
  ```
- Aggiornamento e installaqzione Jenkins
  ```
  # apt update
  # apt install jenkins -y
  ```
- Avvio Jenkins
  ```
  # systemctl start jenkins
  ```
- Abilitare Jenkins all'avvio del sistema
  ```
  # systemctl enable jenkins
  ```
- Verifica dello stato del server
  ```
  # systemctl status jenkins
  ```

Per completare la configurazione iniziale, visitare l’indirizzo indicato `http://localhost:8080` e seguire le istruzioni indicate nella pagina, la password dell'amministratore viene creata nel file
```
$ cat /var/lib/jenkins/secrets/initialAdminPassword
```
Jenkins di default è reso disponibile alla porta 8080 ma è possibile cambiare questa configurazione nel file
```
# nano /etc/default/jenkins
```
indicando una porta specifica, per esempio:
```
HTTP_PORT=7070
```
Un esempio di task di tipo pipeline creata in jenkins è:
```
pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git credentialsId: 'github-token', url: 'https://github.com/alnao/JavaSpringBootExample', branch: 'master'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }
    stage('Deploy to EC2') {
      steps {
        sh """
        cp application/target/application-1.0.0.jar /tmp
        """
      }
    }
  }
}
```

## Visual Studio Code

**Visual Studio Code** è un programma per lo sviluppo, rilasciato da Microsoft gratuitamente anche per la piattaforma GNU Linux, può essere usato per quasi tutti i linguaggi: ad oggi è considerato il miglior programma per tanti linguaggi come PHP, Javascript e Typescript. Può essere facilmente scaricato dal sito di microsoft, le istruzione per l'installazione variano spesso quindi bisogna sempre controllare alla pagina ufficiale la sezione dedicata a Debian.

Ad oggi esistono più modi di configurare il repository e installare il programma, per esempio:
```
# apt-get install software-properties-common apt-transport-https curl
# curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
# add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# apt-get update
# apt-get install code
```
Poi infatti basta lanciare il comando dall'icona che compare nel menù del desktop. Nel programma sono disponibili diversi plug-in per usare GIT ed è disponibile una console integrata per il lancio dei server NPM e NG per React e Angular. Come per gli altri sistemi operativo anche su GNU Linux è possibile scaricare i plug-in disponibili per tutti i linguaggi come Java o C. Un elenco incompleto dei plugin indispensabili:

- github copilot
- git graph
- git history
- intellicode
- extension pack for java
- language support for java
- maven for java
- project manager for java
- test runner for java
- spring boot tools
- pylance
- python
- docker
- aws toolkit
- sqLite viewer


## Postman

Anche per **Postman** non esiste il pacchetto Debian ufficiale e per poterlo installare esistono due possiblità: scaricarlo dai server di snap con un semplice click oppure scaricare l'installer in formato tar.gz dal sito ufficiale e poi installare il programma con i comandi:
```
# tar -xzf Postman-linux-x64-*.tar.gz
# sudo rm -rf /opt/Postman
# sudo mv Postman /opt/Postman
# sudo ln -s /opt/Postman/Postman /usr/bin/postman
$ cat > ~/.local/share/applications/postman.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOF
```
con l'ultimo comando si è creata la voce di menù da cui è possibile accedere al programma velocemente, poi gli aggiornamenti vengono scaricati automaticamente dal programma stesso.


## PostgreSQL

Per gli ambienti GNU Linux sono disponibili molti diversi DBMS, il più usato ovviamente è  MySql, già descritto nella sezione su LAMP, ma nel tempo sono stati sviluppati altri gestori di base dati più o meno open-source, uno dei più famoso e più usati è **PostgreSQL**, questo è disponibile nei repository ufficiali con dei pacchetti pronti, infatti basta installare i pacchetti base:
```
# apt-get install postgresql-13 postgresql-all ufw
```
e poi bisogna modificare il file di configurazione:
```
# pico /etc/postgresql/11/main/postgresql.conf
```
verificando che siano presenti le righe non commentate (senza il cancelletto iniziale)
```
listen_addresses='localhost'
port = 5432
```
da notare che di default è permesso solo l'accesso da locale, è possibile modificare questa impostazione valorizzando con asterisco per l'apertura a tutta la rete internet. Successivamente bisogna aprire le porte di rete e configurare le utenze
```
# ss -tunelp | grep 5432
/sbin/ufw allow 5432/tcp
systemctl restart postgresql
su - postgres
$$ psql -c "alter user postgres with password 'parolaSegreta'"
$$ createuser prova
$$ createdb testdb -O dbuser1
$$ psql
 =# \c prova
 =# alter user dbuser1 with password 'DBPassword';
 =# create table testtable ( id int,firstname text, lastname text );
 =# insert into testtable (id,firstname,lastname) values (1,'Alberto','Nao');
 =# select * from testtable;
# systemctl restart postgresql
```
con questi semplici comandi si sono eseguite delle configurazioni base del server tra cui la creazione un utente nel sistema Debian, la creazione di un database e di una tabella, le query finali son un semplice esempio di verifica del corretto funzionamento del database.

Per collegarsi al database PostgreSQL è possibile usare qualunque programma come Beekeeper ma è consigliato installare PgAdmin4, scaricabile da un repository dedicato con i comandi:
```
# curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
# sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
# apt-get update
# apt-get install pgadmin4 pgadmin4-desktop pgadmin4-web
# /usr/pgadmin4/bin/setup-web.sh
```
da notare che con l'ultimo comandi si è abilitato l'accesso via web dall'indirizzo localhost/pgadmin4.


## MongoDB

Per quanto riguarda il demone **MongoDB** si può installare utizzando il repository dedicato che necessita di una piccola configurazione come spiegato nel [sito ufficiale](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-debian/):
```
# curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
# echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] http://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | sudo tee  /etc/apt/sources.list.d/mongodb-org-8.0.list
# sudo apt-get update
# sudo apt-get install -y mongodb-org
# sudo systemctl enable mongod --now
# sudo sudo systemctl start mongod
```
se si vuole accedere al demone da altri nodi diversi dal nodo in esecuzione bisogna modificare il file di configurazione:
```
/etc/mongod.conf
```
nel quale bisogna verificare ed eventualmente modificare le configurazioni base di rete nei punti:
```
bindip = 127.0.0.1,indirizziIpCheUsanoMongo
port = 27017
#auth=true
```
se viene modificato il file di configurazione, bisogna ricordarsi di riavviare il server con il comando:
```
# systemctl restart mongod
```
Per l'accesso da riga di comandi è disponibile una console, un semplice esempio di utilizzo di questo comando:
```bash
$ mongosh 
  > db.runCommand({ connectionStatus: 1 })
  > use collectiondemo
  > db.elenco.insertOne({nome:"Alberto"})
  > db.elenco.find()}
  > exit 
```
Un tool grafico per poter usare e gestire un database MongoDB è **Mongo-Compass**, disponibile come pacchetto nel [sito ufficiale](https://www.mongodb.com/docs/compass/install/) che può essere scaricato ed installato molto velocemente con pochi domandi:
```
# wget https://downloads.mongodb.com/compass/mongodb-compass_1.46.6_amd64.deb
# sudo apt install ./mongodb-compass_1.46.6_amd64.deb
# sudo dpkg -i mongodb-compass_1.46.6_amd64.deb
# sudo apt-get install -f
$ mongodb-compass	
```


## Docker

Per la installazione del demone dei **Docker** basta installare i pacchetti omonimi: `docker`, `docker-compose` e `docker-compose-plugin` presenti nei repository ufficiali e poi possono i vari comandi dei docker per gestire il demone:
```
# systemctl status docker
# systemctl start docker
```
e per abilitare un utente ad usare e gestire il demone si devono eseguire i comandi
```
# usermod -aG docker <utente>
# newgrp docker
# chmod 666 /var/run/docker.sock
```
Si può analizzare le immagini docker in esecuzione con il comando:
```
# docker ps
```
Per fermare una esecuzione dell'immagine bisogna lanciare il comando:
```
# docker stop NUMERO
```
dove il NUMERO è il valore ritornato dal comando ps che mostra l'elenco di tutti i docker attivi nel demone.


### Esempio con Pgadmin4
A scopo di esempio si mostrano i passaggi per l'installazione di PgAdmin4 su Docker:
- scaricare e avviare l'immagine contenente 
  ```
  # mkdir ~/dockerPgadmin4
  # cd ~/dockerPgadmin4
  # docker pull dpage/pgadmin4
  # docker run -p 5050:80 -e "PGADMIN_DEFAULT_EMAIL=postgres" -e "PGADMIN_DEFAULT_PASSWORD=password" -d dpage/pgadmin4
  # docker-compose up -d
  # docker ps
  ```
- ovviamente bisogna prestare attenzione che le porte indicate non siano già occupate da altri server, per questo c'è il mapping dalla porta 80 alla 5050
- potrebbe essere necessario aprire le porte del firewall locale per le porte con i comandi:
  ```
  # /usr/sbin/iptables -I INPUT 1 -i eth0 -p tcp --dport 5050 -j ACCEPT
  # /usr/sbin/service iptables save
  # /usr/sbin/iptables --list
  ```
- nel file di configurazione del server PostgreSql `/etc/postgresql/11/main/postgresql.conf` è necessario aggiungere la riga
  ```
  listen_addresses = '*'
  ```
- aggiungere la porta nel file di configurazione `/etc/postgresql/11/main/pg_hba.conf`
  ```
  host all all 0.0.0.0/0 md5
  ```
- riavviare il server Postgresql: 
  ```
  # /etc/init.d/postgresql restart
  ```
- alla fine è possibile collegarsi al PgAdmin4 via web all'indirizzo
  ```
  http://localhost:5050/browser/
  ```
- nella login bisogna inserire username e password indicati in creazione del docker, per collegarsi al PostgreSql bisogna configurare l'indirizzo IP (il valore localhost non sempre funziona) e selezionando la voce "SSL Compression"
- per fermare una esecuzione dell'immagine bisogna lanciare il comando:
  ```
  # docker stop NUMERO
  ```
  dove il NUMERO è il valore ritornato dal comando `docker ps` che mostra l'elenco di tutti i docker attivi nel demone.


### Configurazione di rete di Docker
Docker è uno strumento potente per la containerizzazione delle applicazioni, e la gestione della rete è un aspetto fondamentale per consentire ai container di comunicare tra loro e con il mondo esterno. È buona pratica creare reti definite dall'utente invece di affidarsi alla rete bridge predefinita, questo offre i seguenti vantaggi:
- Isolamento Migliore: I container sono isolati sulla propria rete definita dall'utente.
- Risoluzione dei Nomi: I container all'interno della stessa rete definita dall'utente possono comunicare tra loro usando il nome del container come hostname (risoluzione DNS automatica).
- Portabilità: Le configurazioni di rete possono essere incluse nei file Docker Compose, rendendo più facile spostare le applicazioni tra ambienti.


I principali comandi di Docker per la gestione della rete sono:
- `docker network ls`: Elenca le reti disponibili
- `docker network create <nome_rete>`: Crea una nuova rete
- `docker run --network=<nome_rete> <immagine>`: Avvia un container collegandolo a una rete specifica
- `docker network connect <nome_rete> <nome_container>`: Collega un container in esecuzione a una rete.
- `docker network rm <nome_rete>`: Rimuove una rete.


Per rendere una porta esposta accessibile dall'esterno dell'host Docker, è necessario utilizzare il flag -p (o --publish) con il comando docker run. Questo mappa una porta dell'host a una porta del container. Per esempio:
```bash
$ docker run -p 8080:80 <immagine>
``` 
mappa la porta 8080 dell'host verso la porta 80 del container.


E' possibile che le reti create da docker vadano in contrasto con indirizzi ip di reti locali, è possibile identificare quali indirizzi di rete sono "occupati" con il comando 
```
# ip route
```
che ritorna righe del tipo
```
172.18.0.0/16 dev br-24119fc62408 proto kernel scope link src 172.18.0.1 linkdown 
```


Tipicamente le reti `br-xxxxxxx` sono quelle occupate dal demone-Docker che *tipicamente* iniziano con `172.18.x.x` o `172.20.x.x`. Per cambiare questa impostazione è possibile modificare il file di configurazione `/etc/docker/daemon.json`:
```
{
  "default-address-pools": [
    {
      "base": "172.31.0.0/16",
      "size": 24
    }
  ]
  ,"dns": ["8.8.8.8", "1.1.1.1"]
}
```
dopo la modifica del file di configurazione bisogna rivviare il demone-Docker con il comando
```
# service docker restart
```


### Creazione ed avvio di una immagine

Per la creazione di una immagine è indispensabile creare un `Dockerfile` (*file senza estensione*). Un Dockerfile è un file di testo che contiene una serie di istruzioni per creare un'immagine Docker automatizzando il processo di configurazione e installazione, consentendo di definire l'ambiente di esecuzione per un'applicazione in modo riproducibile e consistente. Alcuni semplici esempi di file sono:
- immagine ubuntu con installata l'ultima vesione python3:
  ```
  FROM ubuntu:20.04
  RUN apt-get update && apt-get install -y python3
  CMD ["python3"]
  ```
- una piccola applicazione python che esegue uno script con la libreria pandas:
  ```
  FROM python:3.8
  ADD script.py .
  RUN pip install pandas
  CMD ["python","./script.py"]
  ```
I comandi per preparare e avviare una immagine sono:
```bash
$ docker build -t nome-immagine .
$ docker images
$ docker run nome-immagine
```
Mentre è possibile "entrare" direttamente nell'immagine con il comando 
```bash
$ docker run -it mia-immagine /bin/bash
```
Il comando **docker exec** serve per eseguire un comando all'interno di un container Docker già in esecuzione . È particolarmente utile quando vuoi interagire con un container attivo senza doverlo fermare o riavviare. La sintassi è:
```bash
$ docker exec [OPZIONI] NOME_CONTAINER COMANDO [ARGOMENTI]
```
come per esempio
```bash
$ docker exec -it NOME_CONTAINER /bin/bash
```


### Docker compose

Docker Compose è uno strumento che semplifica la gestione e l'orchestrazione di applicazioni multi-container, permette infatti di definire e avviare più servizi, reti e volumi in un unico file YAML (docker-compose.yml) e gestirli con un solo comando.
Per esempio una applicazione python con collegato un database PostgreSql:
```
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    environment:
      - FLASK_ENV=development
      - DATABASE_URL=postgresql://user:password@db:5432/mydatabase
    depends_on:
      - db
    volumes:
      - .:/app

  db:
    image: postgres:13
    environment:
      POSTGRES_DB: mydatabase
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

Dove il progetto web è definito da un Dockerfile del tipo:
```
# Usa un'immagine Python ufficiale
FROM python:3.9-slim
# Imposta la directory di lavoro
WORKDIR /app
# Copia i file necessari
COPY requirements.txt .
# Installa le dipendenze
RUN pip install --no-cache-dir -r requirements.txt
# Copia il resto dell'applicazione
COPY . .
# Espone la porta su cui gira l'app Flask
EXPOSE 5000
# Avvia l'applicazione
CMD ["python", "app/routes.py"]
```
Per avviare il progetto basta lanciare il comando:
```
# docker-compose up -d
```
Mentre per spegnere il tutto bisogna usare il comando:
```
docker-compose down
```


### Kubernetes
Il famoso **Kubernetes** è una piattaforma open source per l’orchestrazione automatica di container, progettata per gestire, scalare e distribuire applicazioni in ambienti cloud e on-premise. `kubectl` è lo strumento da linea di comando che consente agli utenti di interagire con cluster Kubernetes per amministrare risorse e applicazioni. Questa mini-guida fa riferimento alla versione 1.32 presente nei repositoy ufficiali ma esiste anche la versione su snapd e altre versioni più recenti non pienamente compatibili con Debian.  
```
# systemctl status docker
# curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernets-apt-keyring-gpg
# chmod 666 /etc/apt/keyrings/kubernets-apt-keyring-gpg 
# echo 'deb [signed-by=/etc/apt/keyrings/kubernets-apt-keyring-gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
# cat /etc/apt/sources.list.d/kubernetes.list
# chmod 644 /etc/apt/sources.list.d/kubernetes.list
# apt-get update 
# apt-get install kubeadm kubelet kubectl containernetworking-plugins
# apt-mark hold kubeadm kubelet kubectl
# systemctl status kubelet
```
Bisogna ricordare che il demone kubectl può essere molto pesante e rallentare il sistema, se non deve essere usato costantemente è consigliato disattivare l'avvio del demone all'avvio del sistema, è possibile disattivare con il comando:
```
# systemctl disable kubelet
```
Per il corretto funzionamento di Kubernets è fondamentale che sia disattivato il sistem di swap del sistema operativo, se attivo è possibile disattivare *temporaneamente* il sistem di gestione della memoria swap con i comandi:
```
# swapoff -a
# sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
# systemctl start kubelet
```
Per il corretto avvio del sistema, sono necessarie alcune configurazioni in alcuni files di sistema del sistema container per permettere a kubectl di avviare immagini:
```
# echo "overlay" >> /etc/modules-load.d/containerd.conf
# echo "br_netfilter" >> /etc/modules-load.d/containerd.conf
# cat /etc/modules-load.d/containerd.conf
# modprobe overlay
# modprobe br_netfilter
# ls /usr/lib/cni/
# mkdir -p /opt/cni/bin
# ln -s /usr/lib/cni/* /opt/cni/bin/
# echo "net.bridge.bridge-nf-call-ip6tables = 1" >> /etc/sysctl.d/kubernetes.conf
# echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.d/kubernetes.conf
# echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/kubernetes.conf
# cat /etc/sysctl.d/kubernetes.conf
# nano /etc/containerd/config.toml
  se presente una riga di disabled_plugins commentarla
# cat /etc/containerd/config.toml
# echo 'KUBELET_EXTRA_ARGS="--cgroup-driver=cgroupfs"' >> /etc/default/kubelet
# cat /etc/default/kubelet
# echo '{ "exec-opts": ["native.cgroupdriver=systemd"] }' >> /etc/docker/daemon.json
# cat /etc/docker/daemon.json
# systemctl daemon-reload && systemctl restart docker
# systemctl restart containerd
# hostnamectl
```
In caso di errori sui plugin di Kubernetes visualizzati con il comando `journalctl -u kubelet -f` bisogna eseguire i comandi:
```
# journalctl -u kubelet -f
# kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
# cp /opt/cni/bin/flannel /usr/lib/cni
# kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml
# cp /opt/cni/bin/calico-ipam /usr/lib/cni
# cp /opt/cni/bin/calico /usr/lib/cni
```
Con questo ultimo comando è possibile recuperare il nome dell'host, indispensbile per i successivi passi, è possibile modificarlo con il comando
```
# hostnamectl set-hostname nomehost
```
Per avviare e configurare il servizio è necessario lanciare il comando
```
# kubeadm init --control-plane-endpoint=cirilla --upload-certs --pod-network-cidr=10.244.0.0/16
```
Per inizializzare un cluster e configurare una rete Container Network Interface (CNI):
```bash
$ mkdir -p $HOME/.kube
$ cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ chown $(id -u):$(id -g) $HOME/.kube/config
$ kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
$ kubectl taint nodes --all node-role.kubernetes.io/control-plane-	
$ kubectl taint nodes --all node.kubernetes.io/disk-pressure-
$ kubectl get nodes	
```

Il cluster è ora pronto. Per aggiungere nodi worker, per esempio è possibile eseguire il comando `kubeadm join` per la gestione dei nodi. Una sequenza utile per l'avvio di un servizio è:
```bash
$ kubectl apply -f deployment.yml 
$ kubectl apply -f service.yml
```
Per rimuovere i servizi è possibile usare i comandi:
```bash
$ kubectl delete all -l app=esempio01
$ kubectl delete all -l app=esempio01
$ kubeadm reset
```
Mentre i log e i dettagli possono essere recuperati con i comandi:
```bash
$ kubectl get all -l app=esempio01

$ cat /var/log/syslog | grep kubelet
$ kubectl get nodes	
$ kubectl get pods
$ kubectl get events -A
$ kubectl get events --sort-by='.lastTimestamp'
$ kubectl describe node | grep -i capacity -A 5
$ kubectl logs -f deployment/esempio01

$ journalctl -u kubelet -f
```

Un esempio di avvio di un server Nginx su un nodo dedicato:
```bash
$ kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml
$ kubectl get nodes
$ kubectl create deployment nginx --image=nginx
$ kubectl expose deployment nginx --type=NodePort --port=80
$ kubectl get deployment nginx
$ kubectl get service nginx
$ curl http://<node-ip>:<node-port>
  
$ kubectl delete deployment nginx
$ kubectl delete all -l app=nginx
$ kubectl get all -l app=nginx
```


### Minikube
**Minikube** è uno strumento che permette di eseguire un cluster Kubernetes locale su una singola macchina, ideale per un ambiente di sviluppo e/o di test, è possibile usarlo per provare applicazioni Kubernetes senza dover configurare un vero cluster cloud o on-premise su Server fisici molto grandi e costosi.


Per installare minikube conviene usare il pacchetto disponbile da google, la sequenza di istruzioni da eseguire è
```
# curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
# sudo dpkg -i minikube_latest_amd64.deb
# minikube version
# sudo chmod 666 /var/run/docker.sock
# docker version --format {{.Server.Os}}-{{.Server.Version}}:{{.Server.Platform.Name}}
# minikube start --memory=4096 --cpus=2
# minikube start --memory=4096 --cpus=2 --force
  http://localhost:9000/
# minikube status
# minikube stop
```
da notare che esistono diverse guide con diverse sorgenti, conviene sempre controllare il [sito ufficiale](https://minikube.sigs.k8s.io/docs/start/).


Per avviare un cluster esistono diversi modi, si riportano alcuni esempi:
- Avvio di un server nging 
  ```bash
  $ minikube start --driver=docker --memory=2048 --cpus=2
  $ kubectl create deployment nginx --image=nginx
  $ kubectl get pods
  $ kubectl expose deployment nginx --type=NodePort --port=80
  $ kubectl get services
  $ curl http://$(minikube ip):$(kubectl get service nginx -o jsonpath='{.spec.ports[0].nodePort}')
  $ kubectl delete service nginx
  $ kubectl delete deployment nginx
  $ minikube stop
  ```
- Avvio di un sever nging con file servide dedicato
  - File `nginx-service.yaml`
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: nginx
    spec:
      type: NodePort
      ports:
      - port: 80
        targetPort: 80
        nodePort: 30042   # 👈 Porta esterna (deve essere tra 30000-32767)
      selector:
      app: nginx
    ```
  - Comandi per la creazione
    ```
    minikube start --driver=docker --memory=2048 --cpus=2
    kubectl create deployment nginx --image=nginx
    kubectl apply -f nginx-service.yaml
    curl http://$(minikube ip):$(kubectl get service nginx -o jsonpath='{.spec.ports[0].nodePort}')
    kubectl delete service nginx
    kubectl delete deployment nginx
    minikube stop
    ```

    
Per la creazione di servizi con kubectl sviluppati in Java e Python si rimanda alle varie guide:
- Microservizi sviluppati con Java Spring Boot
  ```
  https://github.com/alnao/JavaSpringBootExample  
  ```
- Microservizi sviluppati con Python
  ```
  https://github.com/alnao/PythonExamples/tree/master/Docker
  ```


Da notare che assieme a minikube conviene usare anche **freelens**: un'estensione di Minikube che permette di ispezionare e gestire facilmente i servizi, le risorse e i log del cluster Kubernetes in locale, con FreeLens è possibile visualizzare dashboard, analizzare pod e debuggare applicazioni senza dover usare molti comandi a terminale. L'installazione è molto semplice utilizzando snap con il comando
```bash
$ snap install freelens --classic
```
La configurazione è praticamente automatica per il server in locale, per server remoti la configurazione può essere complicata perchè regolata dal file
```
~/.kube/config
```
si rimanda alle varie guide in internet per la configurazione di questo files (*a me non ha mai funzionato*).


### Helm
**Helm** è un package manager per Kubernetes, simile a apt o yum nei sistemi Linux. Consente di installare, configurare e gestire facilmente applicazioni su un cluster Kubernetes. Gli **Helm Charts** sono pacchetti predefiniti che descrivono come un'applicazione deve essere distribuita.
Installare e configurare heml non è una cosa semplice, qui si riportano i passi più importanti. Per l'installazione si può configuare una sorgente: 
```
# curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
# sudo apt-get install apt-transport-https --yes
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
# apt-get update
# apt-get install helm
```


### Portainer
**Portainer** è una piattaforma leggera, open-source, progettata per semplificare la gestione di ambienti Docker, Docker Swarm e Kubernetes attraverso una interfaccia grafica *web-based*. Consente di controllare, monitorare e configurare container, immagini, volumi, reti e stack, senza necessità di ricorrere esclusivamente alla riga di comando. L’uso di Portainer consente di:
- Ridurre la complessità operativa nella gestione dei container
- Visualizzare lo stato dell’infrastruttura Docker/Kubernetes in tempo reale
- Creare, modificare e rimuovere risorse: in pochi clic (container, immagini, stack, reti, volumi)
- Gestire stack Docker Compose: tramite un'interfaccia web
- Controllare più ambienti: (locali e remoti) da un'unica dashboard


Per installare Portainer si può usare lo stesso docker, con i comandi:
```bash
$ docker volume create portainer_data
$ docker run -d -p 9001:9000 --name portainer -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```
Oppure basta aggiungere un `--restart=always` per averlo disponibile ad ogni avvio del sistema. Una volta installato l'interfaccia web è disponibile all'indirizzo `http://localhost:9001` (in questo esempio è stata scelta la porta 9001 perchè la 9000 potrebbe essere già occupata). Al primo avvio, verrà richiesto di configurare un utente amministratore e selezionare l’ambiente Docker da gestire.


Portainer supporta **Kubernetes** a partire dalla versione 1.11 in poi ed è in grado di collegarsi a un cluster Kubernetes locale oppure a cluster remoti (su cloud o in infrastrutture on-premise) fornendo una dashboard semplificata per workload, namespace, pod, ingress, storage, ecc. È possibile installare Portainer direttamente nel cluster tramite Helm o manifest YAML:
```bash
$ kubectl apply -n portainer -f https://downloads.portainer.io/ce2-17/portainer.yaml
```
È possibile aggiungere un ambiente Kubernetes remoto in Portainer con un *Agent remoto Portainer* da installare nel cluster remoto per facilitare la connessione oppure con Kubeconfig: fornendo manualmente un file kubeconfig con credenziali e endpoint API.


## Cloud
Debian offre integrazione nativa con i principali provider cloud come AWS, Azure e Google Cloud, grazie a pacchetti ufficiali e strumenti CLI facilmente installabili tramite il gestore di pacchetti APT. Le immagini Debian sono disponibili nei marketplace dei cloud più diffusi, consentendo il deploy rapido di macchine virtuali, container e servizi gestiti direttamente dall’infrastruttura cloud. Debian supporta strumenti multi-cloud come Terraform, Ansible e rclone, permettendo l’automazione, la gestione e la sincronizzazione di risorse cloud in modo sicuro e standardizzato.



**Google Cloud SDK** mette a disposizione un repository ufficiale per l'installazione dei componenti:
```
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update && sudo apt install google-cloud-cli
```

**OpenStack** è una piattaforma di cloud computing open source che permette di creare e gestire cloud privati e pubblici, fornendo un'alternativa libera ai servizi cloud proprietari come AWS, Azure o Google Cloud. OpenStack è particolarmente popolare in ambito enterprise e tra i service provider che vogliono mantenere controllo completo sulla propria infrastruttura cloud.
```
# apt update
# apt install software-properties-common
# echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu jammy-updates/yoga main" | sudo tee /etc/apt/sources.list.d/openstack.list
# git clone https://opendev.org/openstack/devstack
# cd devstack
# ./stack.sh

# Oppure installazione manuale dei componenti
# apt install nova-compute nova-api keystone glance-api neutron-server
```

### AWS

Per chi usa il cloud **AWS** è indispensabile usare i comandi da riga di comando Command Line interface **AWS-CLI** e **AWS-SAM**, entrambi sono facilmente configurabili in pochi istanti grazie ai tool messi a disposizione direttamente da AWS. L'installazione della CLI è facilissima e basta seguire i passi descritti nella documentazione ufficiale:
```
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ unzip awscliv2.zip
# ./aws/install
$ aws --version
```
In caso di errore di questo ultimo passaggio basta aggiungere al file .bashrc il path /usr/local/bin/ dove viene installato il CLI di AWS. Per configurare il profilo bisogna prima creare un utente di tipo programmatico con la key nel servizio IAM di AWS, poi basta lanciare il comando:
```bash
$ aws configuration --profile nomeUtente
```
per configurare un profilo, in questi passi saranno richieste le due chiavi dell'utente, la zona di default (come eu-west-1) e il formato delle risposte (come json). Una volta configurato la CLI, per provare il corretto funzionamento e collegamento basta lanciare il comando:
```bash
$ aws s3 ls
```
per visualizzare l'elenco dei bucket presenti nel servizio S3 nella region impostata di default in fase di configurazione. L'elenco dei comandi specifici della CLI è disponibile negli articoli dedicati al servizio AWS.


Per avere una lista di tutte le risorse disponibili nel cloud si può lanciare lo script
```
https://github.com/alnao/AwsCloudFormationExamples/blob/master/aws_panoramic.bash
```


Per quanto riguarda il gruppo di comandi della CLI dedicati ai servizi serverless, chiamati **CLI-SAM**, si necessita di una installazione dedicata come indicato nel [sito ufficiale](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html), che elenca i seguenti comandi:
```
# wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
# unzip aws-sam-cli-linux-x86\_64.zip -d sam-installation
# ./sam-installation/install
$ sam --version
```
Una guida completa di SAM può essere trovata al sito ufficiale mentre esempi di utilizzo di questo mando si possono trovare nella sezione di AWS del sito alnao.it.


L'installazione di **SLS** (detta anche serverless-cli) si basa sul sistema di pacakge NPM e bisogna lanciare il comando di installazione del pacchetto dedicato:
```bash
$ npm install -g serverless
```
e poi bisogna configurare le credenziali programmatiche di accesso con il comando:
```bash
$ serverless config credentials --provider aws --key <key> --secret <secret> --profile serverless-admin
```
Per verificare che sia tutto configurato correttamente basta lanciare il comando:
```bash
$ servless
```
oppure:
```bash
$ sls
```


#### Gestione EC2 con Debian 12

Il cloud AWS mette a disposizione molte immagini **AMI** con il sistema operativo Debian12, la lista può essere recuperata in molti siti ufficiali oppure lanciando il comando AWS-CLI:
```bash
$ aws ec2 describe-images --owners aws-marketplace --filters "Name=name,Values=*debian-12*" --query 'Images[*].[ImageId,Name,CreationDate]' --output table
$ aws ec2 describe-images --owners aws-marketplace --filters "Name=name,Values=*lamp*debian-12*" --query 'Images[*].[ImageId,Name,CreationDate]' --output table
$ aws ec2 describe-images --owners aws-marketplace --filters "Name=name,Values=*node*debian-12*" --query 'Images[*].[ImageId,Name,CreationDate]' --output table
```


Per avviare una istanza con una specifica AMI si può usare il comando:
```bash
$ aws ec2 run-instances --image-id ami-XXXXXXXXXXXXXXXXX --instance-type t2.micro --key-name your-key-pair --security-group-ids sg-XXXXXXXXXXXXXXXXX --subnet-id subnet-XXXXXXXXXXXXXXXXX --count 1
# Creare un volume e aggiungerlo all'istanza
$ aws ec2 create-volume --volume-type gp2 --size 20 --availability-zone us-east-1a
$ aws ec2 attach-volume --volume-id vol-XXXXXXXXXXXXXXXXX --instance-id i-XXXXXXXXXXXXXXXXX --device /dev/sdf
# Creare una AMI a partire da una istanza
$ aws ec2 create-image --instance-id i-XXXXXXXXXXXXXXXXX --name "My-Debian-AMI" --description "AMI personalizzata basata su Debian"
# Descrivere una instanza
$ aws ec2 describe-instance-status --instance-ids i-XXXXXXXXXXXXXXXXX
# Creare una metrica Cloudwatch per il monitoraggio della istanza
$ aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value=i-XXXXXXXXXXXXXXXXX --start-time $(date -u +"%Y-%m-%dT%H:%M:%SZ" --date "1 hour ago") --end-time $(date -u +"%Y-%m-%dT%H:%M:%SZ") --period 300 --statistics Average
```


Una volta avviata una istanza è possibile collegarsi e configurarla, qui riportati alcuni dei principali comandi:
```bash
$ ssh -i /path/to/your-key-pair.pem admin@your-instance-public-ip
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y apache2 nginx mysql-server php
```


Per potersi collegare ovviamente bisogna ricordarsi di aprire la porta SSH-332
```bash
# Permettere accesso SSH da qualsiasi IP
$ aws ec2 authorize-security-group-ingress --group-id sg-XXXXXXXXXXXXXXXXX --protocol tcp --port 22 --cidr 0.0.0.0/0
# Permettere accesso SSH solo da un IP specifico
$ aws ec2 authorize-security-group-ingress --group-id sg-XXXXXXXXXXXXXXXXX --protocol tcp --port 22 --cidr IP_ADDRESS/32
# Permettere accesso SSH da un range di IP
$ aws ec2 authorize-security-group-ingress --group-id sg-XXXXXXXXXXXXXXXXX --protocol tcp --port 22 --cidr 192.168.1.0/24
```


### Azure
**Azure** è la piattaforma cloud di Microsoft che offre servizi di computing, storage, networking e intelligenza artificiale, permettendo di distribuire e gestire applicazioni e infrastrutture su scala globale attraverso datacenter distribuiti worldwide.L'integrazione con Debian si realizza tramite Azure CLI (installabile via apt), Azure PowerShell e SDK specifici per vari linguaggi di programmazione.
Per installare la Azure-CLI in Debina è disponibile uno script automatico messo a disposizione dalla [guida ufficiale](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest), tuttavia questo usa il comando `sudo`, se non disponibile è possibile procedere manualmente con tutti i passi per l'installazione configurando il repository specifico:
```
# apt-get update
# apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
# mkdir -p /etc/apt/keyrings
# curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
# chmod go+r /etc/apt/keyrings/microsoft.gpg
# AZ_DIST=$(lsb_release -cs)
# echo $AZ_DIST
# echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
# cat  /etc/apt/sources.list.d/azure-cli.sources
	verificare che non ci siano spazi, con il copia incolla è possibile
# apt-get update
# apt-get install azure-cli
```
Dopo l'installazione è possibile verificare il corretto funzionamento della cli ed è possibile effettuare la login con i comandi
```
$ az --version
$ az login
```
questo aprirà la videata di login in un browser. Dalla login sarà possibile eseguire comandi della AZ-CLI come
```
$ az vm list --output table
$ az storage account list --query "[].{Name:name, Location:location, Kind:kind}" --output table
```


### Terraform
Terraform è uno strumento open source per l'automazione della creazione, gestione e aggiornamento di infrastrutture cloud tramite codice dichiarativo: è possibile definire risorse cloud, server, reti e servizi in file di configurazione leggibili e versionabili. Questo approccio, chiamato Infrastructure as Code (IaC), permette di automatizzare la creazione, modifica e distruzione delle risorse in modo sicuro e ripetibile. Terraform supporta numerosi provider, tra cui AWS, Azure, Google Cloud e molti altri, rendendolo estremamente versatile. 


L’installazione su Debian è semplice e richiede pochi passaggi configuratondo un repository specifico:
```
# apt update
# apt install -y gnupg software-properties-common curl
# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# apt update
# apt install terraform
$ terraform -v
```
Grazie a questo comando sarà possibile scrivere un file di configurazione con estensione .tf e, con i comandi terraform init e terraform apply, si può avviare la gestione automatizzata dell’infrastruttura. 


Terraform si integra perfettamente con AWS grazie al provider AWS ufficiale che supporta centinaia di servizi, dalle istanze EC2 ai database RDS, dai bucket S3 alle funzioni Lambda. L'utilizzo di Terraform con AWS permette di gestire l'intera infrastruttura cloud attraverso file di configurazione dichiarativi, garantendo consistenza, versionamento e possibilità di replicare ambienti identici con il semplice comando:


```bash
$ terraform apply
```


## Android

Esistono molti metodi per eseguire la cattura di un sistema esterno Andoid, è possibile persino prendere il controllo, il sistema più famoso è **scrcpy** che permette di catturare il display di un altro dispositivo. Si può installare tramite il sistema snap con il comando:
```bash
$ snap install scrcpy
```
Oppure installare il pacchetto direttamente da GitHub:
```
# sudo apt install ffmpeg libsdl2-2.0-0 adb wget gcc git pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libswresample-dev libusb-1.0-0 libusb-1.0-0-dev
# git clone https://github.com/Genymobile/scrcpy
# cd scrcpy
# ./install_release.sh
$ scrcpy --version
$ adb devices
```
Se il disposibito è correttamente collegato e configurato l'ultimo comando visualizza il dispositivo disponibile, per avviare il sistema di condivisione basta lanciare il programma o il comando
```bash
$ scrcpy
```
Prima di eseguire questo processo bisogna ricordarsi che è necessario attivare la modalitatà *developer* sul sistema android cliccando sette volte sul "build number" nelle impostazioni del dispositivo ("about device" in alcune versione) e successivamente bisogna bisogna attivare anche l'opzione "USB debugging", senza questa configurazione non il programma adb non visualizza il dispositivo e non è possibile condividere le videate dei dispositivi.


Tramite il programma è possibile condividere la camera, registrare video/audio e altre operazioni, si riportano alcuni esempi:
```bash
$ scrcpy --video-source=camera
$ scrcpy --audio-source=mic # or --audio-source=output
$ scrcpy --video-source=camera --no-audio # audio isn't forwarded
$ scrcpy --record=file.mp4
$ scrcpy --no-audio --record=file.mp4 # to only record the video
$ scrcpy --no-video --audio-codec=raw --record=file.wav # to only record the audio
$ scrcpy --new-display=1920x1080 --start-app=org.videolan.vlc
```
Si rimanda alla documentazione ufficiale per i dettagli di tutti i comandi e i dettagli.


## Blockchain

⚠️🔶 $\textcolor{orange}{\textsf{Nota importante}}$: Non condividere mai chiavi private, seed phrase o file di wallet con nessuno (né online né offline), non copiarli in chat o screenshot e non fare operazioni “a caso”, perché basta un errore o una fuga di credenziali per perdere definitivamente l’accesso ai fondi e quindi soldi reali. 🔶⚠️


**MetaMask** è un wallet non-custodial per blockchain EVM (es. Ethereum) disponibile come estensione browser e app mobile, usato per gestire account, chiavi e firme delle transazioni.  È spesso la “porta di ingresso” per interagire con dApp e smart contract, perché inietta un provider Web3 nel browser e consente di autorizzare operazioni con conferma esplicita dell’utente. In sviluppo si usa anche per collegarsi a reti locali (Hardhat/Ganache) o testnet, importando account di test e verificando comportamenti di firma e invio transazioni. Per installarlo e configurarlo è consigliato usare il plugin di Chrome.


**Hardhat** è un framework di sviluppo per smart contract Solidity basato su Node.js, pensato per compilare, testare, fare debug e deploy in modo ripetibile. Include (o integra facilmente) una rete locale di sviluppo e strumenti di introspezione, consentendo test automatizzati e simulazioni di scenari complessi prima del deploy su testnet/mainnet. È molto usato in progetti moderni perché si integra bene con TypeScript, ethers.js e plugin per coverage, gas reporting e deploy scripts.


**Truffle** è una suite “storica” per lo sviluppo di smart contract che fornisce scaffolding di progetto, compilazione, migrazioni (deployment) e test. Organizza i deploy tramite script di **migrations** e gestisce l’ABI/artefatti per interazioni client, rendendo semplice portare un contratto da locale a testnet.  È spesso usato insieme a Ganache e richiede configurazioni di rete e account nel file di progetto, tipicamente `truffle-config.js`. Per l'installazione basta lanciare i comandi:
```bash
npm install -g truffle
truffle init
```


**Ganache** è una blockchain locale (EVM) per sviluppo e test: crea un ambiente isolato con account pre-caricati e fondi “finti” per provare deploy e transazioni senza costi reali. Consente di ispezionare blocchi, transazioni, log degli eventi e stato degli account in modo immediato, rendendo più semplice il debugging di smart contract e dApp. Si usa spesso come rete RPC locale per Truffle (e talvolta per MetaMask) quando vuoi un ambiente prevedibile e riproducibile.


**Electrum** è un wallet Bitcoin leggero (SPV) che permette di gestire BTC senza dover scaricare l’intera blockchain, basandosi su server Electrum per sincronizzazione e query. Nel contesto Debian è utile come componente “operativo” per Bitcoin (gestione fondi e transazioni), distinto dagli strumenti EVM per smart contract (Hardhat/Truffle/Ganache). Per l'installazione si può seguire la [guida ufficiale](https://electrum.org/#download), infatti basta lanciare i comandi:
```
# sudo apt-get install python3-pyqt6 libsecp256k1-dev python3-cryptography
# wget https://download.electrum.org/4.6.2/Electrum-4.6.2.tar.gz
# wget https://download.electrum.org/4.6.2/Electrum-4.6.2.tar.gz.asc
# gpg --verify Electrum-4.6.2.tar.gz.asc
# tar -xvf Electrum-4.6.2.tar.gz
# python3 Electrum-4.6.2/run_electrum
```


Il **Web3** è l’idea di un web in cui l’utente non si limita a consumare servizi centralizzati, ma può possedere asset digitali (token/NFT), interagire con applicazioni decentralizzate (dApp) e validare operazioni tramite crittografia e smart contract, riducendo (in parte) la dipendenza da intermediari. In ambiente Web3 si usa JavaScript principalmente per:
- connettersi a un endpoint **RPC** (locale o remoto),  
- leggere stato e eventi da smart contract (**read**),  
- inviare transazioni firmate (**write**) tramite un wallet/provider.
Come prerequisto c'è l'uso di `npm` e `node` e l'installazione delle librerie con il comando `npm install web3 ethers`.


Uno script di esempio di utilizzo con `geth` per leggere alcune informazioni:
```javascript
const fs = require('fs');
const { Web3 } = require('web3');
const keyfile = fs.readFileSync('/home/ubuntu/mychain/keystore/UTC--<nome-nel-keystore>').toString();
const password = '<la-tua-password>';
const web3 = new Web3();
const account = web3.eth.accounts.decrypt(JSON.parse(keyfile), password);
account.then(e => console.log(e) );
console.log('Private key:', account.privateKey);
console.log('Address:', account.address);
// per lanciare questo script si esegue il comando: "node web3.js"
```


# I comandi della shell

Questo articolo vuole essere un riassunto il più possibile completo e chiaro riguardo ai comandi di GNU Liunx e le varie possibilità di utilizzo della shell.

La shell bash mette a disposizione una serie di scorciatoie che è possibile usare da riga di comando:

- tasto TAB espande il nome di un file o di un comando
- ```!!``` ri-esegue l'ultimo comando eseguito
- ```!n``` riesegue l'ennesimo comando presente nella storia, dove 'n' e' il numero del comando da rieseguire
- ```!stringa``` riesegue l'ultimo comando che inizia con i caratteri specificati in stringa
- ```!stringa:p``` visualizza l'ultimo comando che inizia con i caratteri specificati in stringa
- ```!?comando?``` ricerca il comando specificato tra punti interrogativi
- ```history``` visualizza l'elenco di tutti i comandi eseguiti
- ```CTRL-U``` cancella tutta la riga dalla posizione del cursore all'inizio della riga
- ```CTRL-K``` cancella tutta la riga dalla posizione del cursore alla fine della riga
- ```CTRL-W``` cancella una parola dalla posizione del cursore all'inizio della riga
- ```ALT-D``` cancella una parola dalla posizione del cursore alla fine della riga
- ```CTRL-A``` sposta il cursore all'inizio della riga
- ```CTRL-E``` sposta il cursore alla fine della riga
- ```ALT-F``` sposta il cursore alla fine della parola successiva (F sta per forward)
- ```CTRL-B``` sposta il cursore all'inizio della parola precedente (B sta per backward)
- ```CTRL-T``` inverte gli ultimi due caratteri a sinistra del cursore (T sta per transpose)
- ```ALT-T``` inverte le ultime due parole a sinistra del cursore
- ```ALT-U``` trasforma in maiuscolo la parola su cui si trova il cursore (U sta per uppercase)
- ```ALT-L``` trasforma in minuscolo la parola su cui si trova il cursore (L sta per lowercase)

## Configurazione del Path e alias

Nei sistemi basati su GNU Linux, tutte le shell hanno un **path** base spesso detto semplicemente path utilizzato per abbreviare i comandi ed evitare all'utente di dover inserire il path base ogni volta che esegue un comando; per esempio il comando cp, utilizzato per copiare files o cartelle, si trova quasi sempre nella cartella ```/bin/``` e, per evitare che l'utente inserisca il path ogni volta, viene impostato nel path base la cartella bin così la shell cerca i comandi inseriti dall'utente anche in quella cartella. In poche parole il path base è l'elenco delle cartelle dove la shell deve cercare un comando inserito dall'utente, questo elenco è modificabile e personalizzabile: un utente può aggiungere e togliere cartelle da questo elenco visto che questo valore è salvato in una variabile d'ambiente chiamata
```
$PATH
```
e il cui contenuto può essere visualizzato con il comando:
```bash
$ echo $PATH
```
e si visualizza l'elenco delle cartelle in sequenza con il separatore due-punti, per esempio:
```
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```
Se si vuole aggiungere all'elenco una cartella basta lanciare il comando
```bash
$ export PATH=$PATH:/cartella/da/aggiungere
```
ma eseguendo questo comando la modifica sarebbe solo temporanea fino al successivo riavvio del sistema, per rendere definitiva la modifica al path base bisogna modificare il file
```
~/.bashrc
```
aggiungendo lo stesso comando, in questo modo verrà eseguito ad ogni login dell'utente.

Gli alias sono dei comandi personalizzati che la shell bash permette di creare a piacimento dell'utente, questo può essere una chiamata ad un comando standard GNU Linux o ad un comando eseguibile (come uno script sh). Un semplice esempio è creare un nuovo alias che cancella i file di una determinata cartella basta lanciare il comando:
```
alias cancella="rm -fr /mnt/Dati/toDel/*"
```
poi nella bash basta lanciare il comando cancella per eseguire l'alias che eseguirà il comando indicato. La definizione di alias viene però persa al riavvio del sistema e/o alla log-out dell'utente, per rendere permanente un comando occorre modificare il file:
```
~/.baschrc
```
che si trova dentro la cartella home dell'utente (~), quindi capite che ogni utente può avere i propri alias compreso l'utente root, si può aggiungere in questo file una riga per ogni alias (meglio alla fine del file), per esempio (se non esistono già) si possono aggiungere queste righe:
```
alias ls='ls --color=auto'
alias cancella="rm -fr /tmp/* "
```
dopo aver salvato il file, basterà che scriviate sul terminale il nuovo alias affinché venga eseguito il comando, si può utilizzare questa semplice procedura potete crearvi tutti i comandi che vi servono, comprese alias che richiamino script sh oppure programmi eseguibili non standard della shell bash.

## Operazioni su files

Esistono dei comandi specifici per ogni esigenza: se è essere necessario rinominare un gruppo di file dentro una cartella specifica, per farlo è possibile con uno semplice script per la shell Bash per evitare di dover ripetere l'operazione per ogni file, per esempio per modificare l’estensione di tutti i file si può usare:
```
$ for i in *.from; do mv $i $(basename $i .from).to; done
```
oppure lo script:
```
for file in *.from; do
mv $file ${file%.from}.to
done
```
In alternativa allo script in bash, esiste un comando molto più veloce e sicuro, mmv (Multiple Move) che serve a spostare o copiare file multipli e che possano essere raggruppati con un carattere jolly, questa azione viene effettuata in modo sicuro, ovvero non ci sono cancellazioni di file inaspettate dovute a collisioni dei nomi dei file di destinazione con nomi di file già esistenti, inoltre non ci sono problemi nel caso in cui i nomi dei file contengano spazi. Un esempio di utilizzo è:
```bash
$ mmv 'aaa*bbb?' 'pinco#1pallino#2'
```
e con questo comando vengono rinominati tutti i file contenenti le stringe "aaa" e "bbb" e terminanti con un carattere e verrà dato il nome "pinco" + ciò che trova l'asterisco + "pallino" + ciò che trova il punto di domanda. Un esempio più semplice:
```bash
$ mmv '*.ps' '#1.eps'
```
per rinominare tutti i file da .ps a .eps, per maggiori informazioni e una guida completa potete vedere il comando man di mmv. Il metodo più semplice rimangono i programmi di gestione file del desktop che tutti quanti usano mmv ma basta un semplice click per eseguire il comando, è possibile provare in Dolphin, Konqueror, Total Commander o qualsiasi altro filemanager presente nel sistema Debian.


## Manipolazione video

Per la manipolazione di file video si possono usare diversi comandi, il principale è **ffmeg** che permette di manipolare file video da riga di comando con una sintassi molto complessa, si rimanda al sito ufficiale per tutti i dettagli e l'elenco di tutte le funzionalità messe a disposizione da questo tool.
Le principali operazioni disponibili sono:
- Ruotare un video (per esempio se ripreso in verticale):
  ```bash		
  $ ffmpeg -i input.mp4 -vf "rotate=45*(PI/180)" output.mp4
  ```
- Tagliare un video da un punto ad un altro indicando il minutaggio di partenza e di fine taglio:
  ```bash
  $ ffmpeg -i input.mkv -ss 00:00:00 -t 00:02:30 -acodec copy -vcodec copy output.mkv
  ```
- Unire più files in uno unico file, con questo modo i video sorgenti possono avere dimensioni e risoluzioni diverse, convertendo tutto in MP4 poi in TS per poterli unire nonostante le dimensioni diverse:
  ```bash
  $ ffmpeg -i file1.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts fileInt1.ts
  $ ffmpeg -i file2.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts fileInt2.ts
  $ ffmpeg -i file3.ogv -vcodec libx264 "file3.mp4"
  $ ffmpeg -i file3.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts fileInt3.ts
  $ cat fileIntermediate3.ts  fileIntermediate1.ts fileIntermediate2.ts > output.ts
  $ ffmpeg -i "concat:fileInt1.ts|fileInt2.ts|fileInt3.ts" -c copy -bsf:a aac_adtstoasc mergedVideo.mp4
  ```

## Il bootloader Grub

Durante l'installazione al passo Copia del sistema base e impostazioni finali è stato installato nel proprio sistema il sistema **Grub**, questo è il componente della piattaforma GNU Linux che avvia il sistema operativo all'accensione del sistema: dopo l'accensione infatti compare con una schermata che permette di avviare il sistema GNU Linux in diverse modalità ed eventualmente sistemi operativi diversi se sono installate diverse versioni del KernelLinux o altri sistemi operativi, un utente non esperto deve evitare di eseguire modifiche lasciando i valori di default ma un utente più esperto potrà avviare il sistema ottimizzato a seconda delle proprie esigenze.

New grub theme for debian 12! So hyped for debian 12 "bookworm"! : r/debian
Questo pacchetto è importante perché permette di installare più sistemi operativi nello stesso sistema e poi scegliere quale avviare al momento dell'accensione (chiamata appunto boot del sistema oppure bootloader), in tutti gli altri sistemi operativi (come MS Windows e MacOX) questo componente non è presente per questo un utente non abituato a Grub non riesce a capirne l'utilità, è persino possibile installare più versioni di Debian o diverse distribuzioni nel sistema e poi gestirne l'avvio di sistemi operativi con Grub. Per gli utenti Debian di oggi, Grub viene installato durante la fase di installazione del sistema base e viene auto-configurato quindi l'utente non deve inserire nessuna configurazione: l'auto-configurazione rileva la presenza di altri sistemi operativi e li inserisce nell'elenco di quelli che Grub può avviare, ovviamente se il sistema operativo è stato installato dopo l'installazione di Grub bisogna rilanciarne la configurazione.

Il menù di avvio viene regolato dal file
```
/boot/grub/grub.cfg
```
ma non bisogna MAI modificarlo a mano visto che ci sono una serie di comandi che permettono di modificare le configurazioni, come per esempio lo sfondo e il carattere usato infatti di default viene usato uno sfondo semplice e un tema base. Per maggiori dettagli sulla configurazione del bootloader vi rimando al sito ufficiale oppure ad una guida italiana. Il problema principale di Grub è che, se si cambiano i componenti del sistema come gli HardDisk, può succedere che rimanga disallineato rispetto all'effettiva architettura del sistema, per ripristinare il bootloader bisogna seguire una guida molto chiara dove sono spiegati tutti i passi per il ripristino e la riattivazione, in particolare il comando
```
# grub-install --root-directory=/mnt /dev/sdX
```
ripristina la versione di Grub2 nel sistema, ovviamente i parametri mnt e sdX devono essere modificati con la configurazione del sistema.


Se è necessario aggiungere un sistema operativo non presente su Grub è possibile lanciare il comando
```
# sudo update-grub
```
Tuttavia alcuni sistemi operativi recenti sono bloccati di default, se non presenti bisogna modificare il file di configurazione:
```
/etc/default/grub
```
aggiungendo, o decommentando la riga:
```
GRUB_DISABLE_OS_PROBER=false
```
Se questa configurazione non è attiva (quindi impostata su "true" o assente), GRUB non rileverà automaticamente gli altri sistemi operativi installati sul computer.


## Gestione del gestino

La gestione del **cestino** viene gestita dai vari Desktop (GNOME, KDE o XFCE), e come per altri sistemi, anche in Debian il cestino in realtà è una semplice cartella particolare dove vengono parcheggiati temporaneamente i file in attesa di una cancellazione definitiva, in realtà il Kernel di GNU Linux non gestisce nativamente il cestino, infatti se un utente usa i comandi:
```bash
$ rm
$ rmdir
```
la cancellazione di file o delle cartelle è definitiva e il file non viene spostato in nessun cestino temporaneo quindi bisogna sempre prestare attenzione quando si usano questi comandi. Bisogna sempre tenere conto che il cestino dei Desktop può lasciare della sporcizia nei sistemi, cioè il cestino potrebbe non essere svuotato oppure capita che alcuni desktop non eseguano la cancellazione definitiva ma postano i file in un altra cartella nascosta nonostante il lancio della funzione di svuota il cestino, questa sporcizia può essere lasciata in una cartella specifica che potete trovare al path:
```
/home/nomeutente/.local/share/Trash/file/
```
che dovrebbe essere controllata e svuotata periodicamente con il comando
```bash
$ rm -rf ~/.local/share/Trash/files/*
```
per esempio è possibile inserire questo comandi nello script rc.local per svuotare il cestino (in maniera definitiva) ad ogni avvio del sistema. Se avete dei dischi montati con il comando mount, i vari desktop manager e i programmi di gestione dei file come Dolphin creano delle directory Trash (cestino) all'interno dei volumi montati, per esempio
```
/mnt/Dati/.Trash-1000/files
```
e anche in questo caso basta pulire queste cartelle a mano oppure semplicemente svuotare il cestino dal desktop.


## Il comando Sudo

Il comando **sudo** consente agli utenti senza privilegi di amministratore, di eseguire i comandi come super-utente senza dover effettuare la login come super-utente e senza conoscere la password dell'utente amministratore, in alcune distribuzioni derivate da Debian come Knoppix o Ubuntu questo comando è impostato di default perché non viene usato l'utente root mentre per chi usa Debian o altre distribuzioni GNU Linux questo comando è sconsigliato ma è possibile configurare il comando sudo, di default questo comando non viene installato durante la fase di installazione del sistema base e per averlo a disposizione basta installare il pacchetto sudo, con il comando:
```
# apt-get install sudo
```
per poi lanciare il comando
```
# visudo
```
e inserire alla fine del file la riga
```
nomeutente ALL=(ALL:ALL) ALL
```
dove ovviamente nomeutente è l'username dell'utente da abilitare per questo comando, questo comando va a scrivere un file sudoers che contiene le impostazioni del comando. Ogni volta che viene lanciato il comando sudo viene chiesta una password, che non è la password dell'utente root, ma è la password dell'utente, l'uso di sudo in Debian può diventare utile per chi vuole scrivere script (in sh per esempio) utilizzando comandi che solo il super-utente può lanciare, un esempio classico è la modifica veloce del file fstab, usando invece un semplice script in sh la cosa si fa molto più veloce e interessante, infatti basta creare un file, dandogli estensione sh (solo per comodità perché come sempre visto le estensioni non sono significative) e scrivere al suo interno le righe:
```
#!/bin/sh
sudo kwrite /etc/fstab
```
purtroppo questo non funziona al meglio perché richiede la password dell'utente che lancia lo script, per risolvere il problema dell'inserimento della password basta inserire il comando echo che simula la digitazione di caratteri nel sistema:
```
#!/bin/sh
echo password | sudo -S kwrite /etc/fstab
```
e lo script digiterà automaticamente la password al posto dell'utente, in questo modo si ha a disposizione uno script per eseguire il comando sudo che digita automaticamente la password. Se la installazione del sistema Debian viene avviata dalla versione live, il comando sudo viene installato di default e non viene impostata la password dell'utenza root, per impostarla basta lanciare il comando:
```bash
$ sudo passwd root <nuovapassword>
```
questo perché in quasi tutte le live il comando sudo viene usato al posto dell'utenza root e questo viene ereditato nelle installazioni che vengono avviate da sistemi live.


## Comandi per il controllo del sistema

Esistono dei comandi specifici e dedicati al controllo di parti specifiche del sistema, questo articolo vuole essere un riassunto incompleto di questa categoria di comandi per Gnu Linux. Da ricordare che quasi tutte questi sistemi possono essere sostituiti da WebMin, pannello di controllo completo e facile da usare molto più semplice di tanti programmi divisi che possono risultare complessi da imparare ed usare.

Esistono molti programmi per la gestione dell'intero sistema e che permettono di monitorare le risorse e lo stato del proprio sistema, soprattutto se state usando Debian come server: nella shell potete usare il programma top, utilissimo programma che permette di monitorare tutti processi attivi sul sistema, l'elenco delle funzionalità viene elencata semplicemente premendo il tasto "h". Se utilizzate un desktop, potete provare a configurare i vari widget di controllo sulla barra delle applicazioni e potete provare il programma Monitor di sistema che trovate sul menù Sistema, tramite questo programma potete monitorare memoria e processore, avete anche la possibilità di vedere ed eventualmente uccidere i vari processi e programmi in esecuzione nel vostro sistema. Un programma consigliato è **PhpSysInfo**, per funzionare necessita il demone web Apache e dopo aver installato l'omonimo pacchetto, basta accedere all'indirizzo:
```
http://localhost/phpsysinfo/
```
tramite queste viste di tipo web, il programma permette di recuperare tutte le informazioni utili sul vostro sistema, dalle periferiche al processore, dalla ram agli harddisk e monitorare i livelli di utilizzo.

Per la gestione e il monitoraggio dei processi in esecuzione su un sistema GNU Linux esiste una lunghissima lista di comandi, l'elenco di tutti i processi attivi ed in esecuzione è visualizzabile con il comando ps ma viene quasi sempre usato con il parametro aux che filtra tutti i processi attualmente attivi sul proprio sistema, quindi basta lanciare il comando
```
$ ps aux
```
Per avere un task-manager sulla shell basta si può usare il programma **top** che mostra visione in tempo reale del sistema compreso l'utilizzo delle risorse come la CPU e la memoria, il comando service permette di gestire i vari demoni attivi, come il sendmail o apache, per lo stato basta lanciare il comando
```
# service nomedemone status
```
mentre per le varie operazioni basta usare il parametro "stop" oppure "start" per fermare o far partire un servizio.

Il comando **kill** consente di interrompere l'esecuzione di un processo conoscendo il numero PID del processo da fermare mentre killall permette di bloccare l'esecuzione di un processo utilizzando il suo nome e non attraverso il suo PID, per chi usa un desktop manager può usare il comando **xkill** che permette di uccidere un programma "visuale" in esecuzione sul server X facendo click sulla finestra del programma con il puntatore del mouse che assume la forma di un teschio simile al classico Jolly Roger dei pirati.

Per la gestione della memoria RAM, è possibile usare il comando **free** per avere una visione completa della situazione e che offre inoltre dettagli sulla memoria libera nella partizione di swap, utilizzata come supplemento alla memoria RAM disponibile sul sistema, è suggerito l'uso dei parametri "-l" che visualizzano lo stato della memoria e "-k" che visualizza l'output in KByte oppure "-m" che visualizza l'outout in MByte. Per la gestione dei dischi esiste il comando df che permette di eseguire un'operazione simile a free ma sui dispositivi di archiviazione: il suo scopo è infatti quelli di fornire informazioni sullo stato dell'hard disk del computer in uso e di ogni altro file system montato (pen drive, hard disk esterni e qualsiasi altra periferica esterna montata). Il comando df può essere eseguito sia senza alcun dispositivo target che seguito dal percorso di determinati file system: nel primo caso mostra lo spazio libero su ogni file system montato, nel secondo invece si limita a quelli selezionati manualmente.


## Configurazione di rete

Esistono diversi tool per configurare del demone di rete: editare i singoli file di configurazione, usare comandi shell come **ifconfig**, usare gli strumenti con interfaccia grafica oppure l'uso di web webmin: GNU Linux e Debian mettono a disposizione moltissimi comandi per la gestione della rete, in particolare si può fare qualsiasi cosa anche senza ambiente grafico o Desktop, ovviamente bisogna ben sapere cosa fare e quindi conoscere tutte le teorie sulla rete, i protocolli (IP/TCP) e le impostazioni di sicurezza. In questo documento elenco solo alcuni comandi base che possono essere utili a tutti gli usi, i principali file di configurazione del demone di rete sono:
 
- ```/etc/sysconfig/network``` contiene le principali configurazioni per il Networking
- ```/etc/hosts``` contiene il mapping fra indirizzi e hostname ed alias. Segue un esempio
- ```/etc/services``` contiene il mapping tra i numeri di porta e i nomi dei servizi

Mentre i principali comandi comandi lanciabili della shell sono:

- ```ip addr``` visualizza tutte le interfacce di rete attive e le relative impostazioni
- ```ifconfig eth2 192.168.0.56 netmask 255.255.255.0``` configura l'interfaccia di rete eth2 con indirizzo ip indicato
- ```route -n``` visualizza informazioni di routing evitando di risolvere gli ip
- ```route add -net 0.0.0.0/0 gw 192.168.0.1``` imposta 192.168.0.1 come default gateway
- ```/etc/init.d/network start``` script di avvio del demone networking

per il firewall viene usato il demone **IPTables**: si tratta di uno dei migliori firewall attualmente disponibili non solo per ambienti GNU Linux, interamente configurabile tramite riga di comando, l’elenco delle policy presenti è disponibile tramite:
```
# iptables -L
```
Mentre per modificare le configurazioni del firewall si usano dei parametri particolari del comando:
```
# iptables -A INPUT -p [PROTOCOLLO] --dport [PORTA] -j ACCEPT
```
dove PROTOCOLLO è il tipo di protocollo da abilitare (udp oppure tcp). Volendo,è possibile anche aprire alcune porte solo a determinati IP, tramite il passaggio di un apposito parametro seguito dall’IP o dal range di IP, in questo modo:
```
# iptables -A INPUT -p [PROTOCOLLO] --dport [PORTA] -s 192.168.1.0/24 -j ACCEPT
```
in questo modo verrà abilitato il traffico proveniente dagli IP del tipo 192.168.1.X sulla porta selezionata mentre per abilitare un solo IP è necessario inserirlo per intero (al posto dello zero). Per monitorare una eventuale rete wireless c'è a disposizione il comando wavemon che mostra la banda, la qualità del segnale, statistiche e le informazioni base, programma molto utile se si deve monitorare la rete senza fili da riga di mando. Non i dilungo molto in questi discorsi visto che non è il mio campo e conviene sempre avere sottomano WebMin o i tool grafici dei vari desktop che risultano sempre più comodi, come firestarter per la configurazione del firewall. Può inoltre capitare di dover impostare un limite all'uso della rete, cioè impostare che un sistema utilizzi al massimo un valore costante di banda in download o upload, per questo si può usare il comando **wondershaper** installabile dal gestore dei pacchetti e poi da riga di comando basta lanciare il comando
```bash
$ wondershaper -a nomeInterfaccia -d limiteDowlonad -u limiteUpload
```
per esempio:
```bash
$ wondershaper -a enp3s0 -d 10000 -u 6500
```
da notare che i limiti sono in Kbps.


## Gestione dei backup

Qualsiasi uso si faccia di un sistema informatico è sempre importante disporre di un sistema di backup ed eventualmente il restore dei dati, grazie ai tanti cloud come Dropbox o Google-Drive è possibile fare tutto tramite internet in maniera veloce, nel mondo GNU Linux esistono molti strumenti che servono proprio per eseguire i backup dei sistema, una lista incompleta di strumenti disponibili su Debian:

- **amanda**: Advanced Maryland Automatic Network Disk Archiver cioè un sistema di archiviazione dei dischi
- **backupninja**: sistema di meta-backup leggero ed estensibile
- **bacula**: backup, ripristino e verifica in rete
- **duplicity**: backup automatici incrementali
- **dump**: lo storico programma per eseguire backup e dump dei dischi
- **xfsdump**: programma per eseguire backup e dump dei dischi

E' possibile anche costruire un mini script personalizzato, scritto in linguaggio sh, per la copia di backup dei file base, questo script più essere utile per salvare solamente le configurazioni e non tutto il sistema. Per prima cosa per un backup delle configurazione bisogna salvare i file di sistema che possono essere modificati come visto nei precedenti capitoli e poi si elencano alcune dei principali componenti che è possibile salvare in un backup:

- La configurazione del browser Iceweasel se usato (come segnalibri, cronologia, password e cookies) nella cartella /home/nomeutente/.mozilla/firefox/
- La posta di Icedove se usata: tutte le mail e tutte le impostazioni nella cartella /home/nomeutente/.mozilla-thunderbird/
- La cartella di Chrome se usato, se il sistema di sincronizzazione con google-drive è attivo questa cartella può non essere compresa in un eventuale backup, nella cartella /home/nomeutente/.config/google-chrome
- Tutta la cartella home di ogni utente se ci sono dati interessanti
- Se si usa il MySql/MariaDb come demone per lo sviluppo non bisogna dimenticarsi di comprendere nel
proprio backup anche i database usati, l'esportazione dei dati viene eseguita con il comando:
```
$ mysqldump --database nomedatabase > nomefile.sql -u root -p password
```
(dove poi bisogna inserire la password di root o dell'utente indicato), viene eseguito in salvataggio nel file sql di tutto il db compresa la struttura e gli indici. Per eseguire il ripristino si può usare il comando da riga di comando oppure si può usare più comodamente un tool per l'importazione dello script di backup.

Il kernel mette a disposizione anche il comando **dd** che è possibile usare per copiare una intera partizione che poi conviene comprimere per evitare di occupare troppo spazio con il bakcup:
```
dd if=/dev/partizione bs=32M | gzip -c > /mnt/Dati/FileBackukp.dd.gz
```


## Gestione delle macchine virtuali
Per GNU Linux esistono diversi sistemi di virtualizzazione, lo storico sistema nativo è chiamato **Qemu** poi evoluto nel progetto **Kdm** la cui interfaccia utente è la **Virsh** ed esistono moltissime guide, si rimanda alla documentazione ufficiale per maggiori dettagli, link da inserire tuttavia la configurazione e creazione con Qemu è considerata obsoleta in quanto nelle ultime versioni di Debian non si usa praticamente mai questo tipo di configurazione.

Per quanto riguarda il programma **VMware** è possibile scaricarlo dal sito ufficiale, il file messo a disposizione è nel formato bundle, come già visto più volte l'estensione è solo una descrizione, infatti questo è uno script auto-installante, prima però di lanciare l'installazione bisogna verificare l'installazione di alcuni pacchetti:
```
# apt-get install gcc-6-locales gcc-6-cross-base linux-headers-X.Y.Z-A-amd64 build-essential
```
e poi procedere con l'installazione vera e propria con i comandi
```
# chmod +x VMware-Player*.bundle
# ./VMware-Player*.bundle
```
questo processo installa il programma e crea la voce di menù nel desktop, il programma poi verifica le dipendenze necessarie e visualizza un messaggio di errore all'avvio che indica i pacchetti mancanti (per esempio il pacchetto linux-headers alla versione richiesta da VmWare).

Per quanto riguarda il programma **VirtualBox** non esiste un repository aggiornato per Debian ma solo per la versione per Debian 10 considerata obsoleta. Il programma comunque può essere scaricato dal sito del programma dalla versione per tutte le distribuzioni GNU Linux ed installata facilmente con pochi comandi:
```
# apt install lsb-release
# echo "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main contrib" | tee /etc/apt/sources.list.d/backports.list
# apt install fasttrack-archive-keyring
# echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib" | sudo tee /etc/apt/sources.list.d/fasttrack.list
# echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib" | sudo tee -a /etc/apt/sources.list.d/fasttrack.list
# apt update
# apt install virtualbox
# apt install virtualbox-guest-x11
```
Da notare che esiste anche la possibilità di scaricare manualmente il pacchetto di installazione dal sito ufficiale con i comandi:
```
# apt install build-essential linux-headers-amd64
# wget https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1.22-144080-Linux_amd64.run
# chmod +x VirtualBox*
# ./VirtualBox*
```
Il pacchetto è costantemente in aggiornamento quindi bisogna sempre controllare l'ultima versione disponibile dal sito ufficiale di VirtualBox per rimanere aggiornati.


## Come creare live 
, per esempio eseguendo il comando:
```bash
$ dd if=/mnt/Virtuali/debian-live-12.10.0-amd64-gnome.iso of=/dev/sdc bs=4M status=progress conv=fsync
```


## Creazione di un servizio
Per avviare un servizio personalizzato all'avvio del tuo sistema Debian è possibile creare un servizio manualmente, configurandolo con precisione in base alle tue esigenze specifiche. Per esempio in un sistema *Docker* è possibile creare un sistema di pulizia automatica delle risorse Docker non utilizzate. Questo è fondamentale per prevenire l'accumulo di immagini orfane, container fermi, volumi e network inutilizzati, che possono consumare molto spazio su disco e risorse di sistema. Inizialmente, l'obiettivo era automatizzare i comandi `docker container prune`, `docker image prune`, `docker volume prune`, `docker network prune` e `docker image prune -a`. Questi comandi sono essenziali per liberare spazio e possono essere combinati con il flag `-f` (o `--force`) che permette di eseguire la pulizia senza interazione.


L'obbiettivo è far in modo che la pulizia venga eseguita automaticamente all'avvio del sistema, è sconsigliato l'uso di crontab per la sua minore robustezza in ambienti di sistema ed è sempre sconsigliato il metodo legacy di *rc.local*. La soluzione più moderna e affidabile è **Systemd**, il servizio `docker-cleanup.service` è stato creatp per eseguire uno script Bash contenente i comandi di pulizia Docker.


Esempio del file `/usr/local/bin/docker-cleanup.sh`:
```
#!/bin/bash

# Aggiungi un piccolo ritardo per assicurarti che Docker sia completamente avviato
sleep 10

# Esegui i comandi di pulizia
#/usr/bin/docker container prune -f &
#/usr/bin/docker image prune -f &
#/usr/bin/docker volume prune -f &
#/usr/bin/docker network prune -f &
#/usr/bin/docker image prune -a -f &
/usr/bin/docker stop $(docker ps -aq)
/usr/bin/docker rm $(docker ps -aq)
/usr/bin/docker rmi $(docker images -q)
/usr/bin/docker volume rm $(docker volume ls -q)
/usr/bin/docker network rm $(docker network ls -q)

# Oppure, se preferisci il comando unificato:
# /usr/bin/docker system prune -a -f --volumes

# Potresti voler registrare l'output per debug
echo "Docker cleanup completed at $(date)" >> /var/log/docker_cleanup.log
```
Il file di configurazione `/etc/systemd/system/docker-cleanup.service`
```
[Unit]
Description=Docker Cleanup Service
After=docker.service network-online.target
Wants=docker.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/docker-cleanup.sh
#RemainAfterExit=yes
# Non usare RemainAfterExit=yes se vuoi che Systemd lo consideri completato e non lo tenga "attivo"
User=root  # O l'utente che ha i permessi per eseguire Docker
Group=root # O il gruppo che ha i permessi per eseguire Docker

[Install]
WantedBy=multi-user.target
```
I comandi finali per configurare il servizio che venga eseguito l'avvio del sistema sono:
```
chmod +x /usr/local/bin/docker-cleanup.sh
systemctl daemon-reload
chmod 666 /var/log/docker_cleanup.log 
systemctl enable docker-cleanup.service
systemctl start docker-cleanup.service
systemctl status docker-cleanup.service
journalctl -xeu docker-cleanup.service
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
