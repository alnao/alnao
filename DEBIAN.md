
# Debian 12 Handbook


<img src="https://www.debian.org/Pics/debian-logo-1024x576.png" width="200"> 


*writted by AlNao*


In questa pagina sono elencati tutti gli articoli riguardo a GNU Linux Debian alla versione 12 chiamata **Bookworm**.


E' garantito il permesso di copiare, distribuire e/o modificare questo documento in base ai termini della GNU Free Documentation License, Versione 1.2 o ogni versione successiva pubblicata dalla Free Software Foundation. Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation.

# Indice
- [Introduzione](#Introduzione)
- [Come installare Debian 12](#Come-installare-Debian-12)
- [Come gestire i file e le partizioni](#Come-gestire-i-file-e-le-partizioni)
  - [Gestione dei permessi](#Gestione-dei-permessi)
  - [Il mounting](#Il-mounting)
- [Come gestire i pacchetti Debian e il pannello di controllo](#Come-gestire-i-pacchetti-Debian-e-il-pannello-di-controllo)
  - [Il pannello di controllo WebMin](#Il-pannello-di-controllo-WebMin)
- [Come gestire i desktop e le applicazioni](#Come-gestire-i-desktop-e-le-applicazioni)
  - [Gestione e installazione applicazioni](#Gestione-e-installazione-applicazioni)
  - [Editor di testo](#Editor-di-testo)
  - [Compressione ZIP e simili](#Compressione-ZIP-e-simili)
  - [Browser e mail](#Browser-e-mail)
  - [Skype e Discord](#Skype-e-Discord)
  - [Appliazioni multimediali](#Appliazioni-multimediali)
  - [Dropbox](#Dropbox)
  - [Giochi e Steam](#Giochi-e-steam)
- [Come gestire i demoni di Debian](#Come-gestire-i-demoni-di-Debian)
  - [Sistema di stampa CUPS](#Sistema-di-stampa-CUPS)
  - [Condivisioni di rete con SSH e Samba](#Condivisioni-di-rete-con-SSH-e-Samba)
  - [I RunLevel](#I-RunLevel)
  - [Schedulazioni con Cron](#Schedulazioni-con-Cron)
  - [Controllo remoto](#Controllo-remoto)
- [Programmazione in Debian](#Programmazione-in-Debian)
  - [C e C++](#C)
  - [Python](#Python)
  - [LaTeX](#LaTeX)
  - [Notify e Zenity](#Notify-e-Zenity)
  - [LAMP](#LAMP)
      - [Apache](#Apache)
      - [MySql](#MySql)
  - [Node e NPM](#Node-e-NPM)
  - [Java e Tomcat](#Java-e-Tomcat)
  - [GIT](#GIT)
  - [Visual Studio Code](#Visual-Studio-Code)
  - [Postman](#Postman)
  - [PostgreSQL](#PostgreSQL)
  - [MongoDB](#MongoDB)
  - [AWS](#AWS)
      - [Gestione EC2 con Debian 12](#Gestione-EC2-con-Debian-12)
  - [Docker](#Docker)
    - [Esempio con Pgadmin4](#Esempio-con-Pgadmin4)
    - [Creazione ed avvio di una immagine](#Creazione-ed-avvio-di-una-immagine)
    - [Docker compose](#Docker-compose)
    - [Kubernetes](#Kubernetes)
  - [Android]
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


Questo manuale viene aggiornato dal 2006, anno di scrittura della prima versione della *mitica* Debian 3.1 Sarge, ogni due anni esce una versione nuova del sistema operativo Debian, questo comporta una revisione completa di tutti gli argomenti trattati. Questa è la versione della versione 12.1, le precedenti vesioni erano in formato PDF e nel sito web [alnao.it](https://www.alnao.it/).

Questo documento nasce dalla personale esigenza di avere un registro delle attività eseguite negli anni per la gestione dei sistemi GNU Linux e Debian, sia in ambito professionale sia in ambito personale. La necessità di riordinare il contenuto di grossi blocchi di appunti sparsi e raccolte di pagine web mi ha portato a scrivere un vero documento ordinato che negli anni si è evoluto visti i numerosi e frequenti aggiornamenti. In maniera molto ambiziosa l'ho chiamato documento e manuale, visto che ha anche di condivisione delle mie personali esperienze e conoscenze, seguendo proprio lo spirito base del mondo Open-source e GNU Linux. Rispetto alle precedenti versioni, questa versione è scritta senza sotto-sezioni e con articoli che parlano di singolo argomento in maniera completa. Ho sempre cercato il tempo per scrivere e per correggere gli errori di grammatica e di battitura di cui questo documento è pieno, cerco anche di essere chiaro e non ripetitivo ma non sempre trovo il tempo e le energie per fare tutto e poi sistemare tutto, non avendo nessun scopo di guadagno mi auguro che il lettore comprenda che questa è un documento amatoriale e che non pretenda troppo da questo manuale, ovviamente le cose scritte sono (quasi) sempre verificate anche se ovviamente si possono trovare guide con maggiori dettagli. Essendo un documento amatoriale ed essendo un testo scritto nei miei ritagli di tempo libero senza l'uso di nessun aiuto automatico come le IA, mi auguro che il lettore non abbia la pretesa che questo manuale descriva con precisione il modo migliore per installare e configurare un sistema perfettamente funzionante. 

In questo documento viene esposto, in maniera più oggettiva possibile, il concetto che GNU Linux è un sistema operativo e Debian una distruzione disponibile, questo documento ha lo scopo di descriverne il processo di installazione e configurazione.  Questo manuale NON contiene slogan del tipo "perchè usare Linux", "open source è meglio" oppure "Linux è meglio di altri sistemi operativi", questi argomenti da bar vengono lasciati a chi è più competente in materia di chiacchiere inutili. Tecnicamente c'è molta di differenza tra un sistema operativo classico (come MS Windows e/o Apple Mac OS) e quello che viene comunemente chiamato Linux: siamo abituati a dire giustamente che MS Windows è un sistema operativo mentre il pacchetto MS Word compreso nel pacchetto MS Office è un programma, GNU Linux invece comprende entrambe le parti, esiste il cuore centrale di GNU Linux, chiamato Kernel Linux che può essere definito come il sistema operativo (cioè l'insieme di tutti quei programmi essenziali al funzionamento del sistema base), nei sistemi GNU Linux sono compresi anche tutti i programmi di uso più comune, come quelli per l'ufficio, la navigazione web, giochi, grafica, ecc..., al termine di una installare di un sistema GNU Linux l'utente si ritrova installati tutti i programmi base e, dai DVD o dai Mirror presenti su internet, può scaricare altri programmi senza dover cercare su altri siti, questa filosofia di unire sistema operativo e programmi è stata molto rimarcata in questi anni, basti pensa che i Mirror Debian contengono oltre 50.000 pacchetti e circa 10.000 programmi diversi.

In un pc o in un notebook, è possibile installare GNU Linux anche se è già presente un altro sistema operativo senza grossi problemi e i due sistemi possono essere installati in parallelo, alcune distribuzioni permettono persino di installare i due sistemi nella stessa partizione di disco. Le distribuzioni di GNU Linux sono community o aziende che preparano DVD oppure Mirror Web dove scaricare il sistema di installazione più velocemente, ogni distribuzione ha le proprie caratteristiche ma bisogna sempre ricordare che il cuore del sistema operativo Kernel Linux è sempre lo stesso. In questo documento si parla tipicamente solo della distribuzione Debian, ma leggendo questa guida potrete trovare spunti per qualsiasi distribuzione derivata come Ubuntu mentre per distribuzioni non derivate molti comandi non possono essere usati. Nel mio caso ho scelto di usare Debian perchè dopo vari tentativi, ho valutato la scelta tecnica migliore, fortunatamente dal 2006 ad oggi è stata costantemente aggiornata e supportata così ho dovuto solo tenermi al passo con gli aggiornamenti e non ho dovuto studiarmi un sistema operativo da zero.
Le versioni di Debian sono divise tra la categorie di stable, testing e unstable; come dice il nome stesso, sono le varie fasi dei vita pacchetti: un pacchetto prima viene inserito nella versione chiamata unstable, poi passa nella testing e, quando viene valutato stabile senza anomalie, un pacchetto viene inserito nella successiva versione stabile di Debian, solamente le versioni stabili vengono numerate mentre alla versione “testing” viene assegnato il numero e il nome della successiva versione stabile mentre la versione “unstabile” non ha un numero di versione. Ad ogni versione viene assegnato anche un nome ispirato ai mitici personaggi del film Toys Story, la versione unstable porta sempre il nome Sid che era il nome del bambino che nel film si divertiva a rompere i giocatoli del protagonista.

Per chiarezza di esposizione e per garantire anche precisione delle descrizioni, in tutto questo documento saranno adottate le convenzioni classiche usate in quasi tutti i documenti e i siti:

- Viene usato il carattere ```#``` per indicare un comando eseguito da un utente con privilegi di amministratore di sistema (il super utente root).
- Viene usato il carattere ```$``` per indicare un comando eseguito da un utente non amministratore (un utente non root per esempio quello creato in fase di installazione).
- Viene usato lo stile ```macchina di scrivere``` per indicare messaggi mostrati a video dal sistema, i caratteri inseriti da tastiera e i nomi dei file, facendo sempre attenzione alla distinzione fra lettere minuscole e maiuscole.
- Viene usato lo stile **Grassetto** quando si indicano, per la prima volta, nomi di programmi o dei pacchetti di particolare importanza.
- Viene usato lo stile *corsivo* quando si vogliono evidenziare commenti personali o note non ufficiali.
- Vengono usati dei riquadri oppure il $\textcolor{orange}{\textsf{testo in rosso}}$ quando si vogliono inserire delle note importanti che meritano maggiore attenzione dall'utente.

Dopo la scrittura di ogni comando è sottintesa la pressione del tasto invio (enter).

Questi standard possono essere non convenzionali ad un utente alle prime armi ma scopriremo subito che i caratteri ```#``` e ```$``` vengono usati dal sistema per distinguere la shell di utenti amministratori (root) e utenti normali. Si da per scontato che il lettore abbia la possibilità di collegarsi a internet con una linea abbastanza veloce da poter scaricare i DVD di Debian e che possa scaricare aggiornamenti e pacchetti non compresi nei DVD. Si assume anche che il lettore disponga di un masterizzatore DVD per masterizzare il DVD di installazione, che abbia già il DVD pronto oppure una chiavetta USB vuota. 

Un utilizzatore di GNU Linux deve imparare fin da subito a prestare attenzione a come vengono scritti e inseriti nomi, perché i sistemi basatati su GNU Linux sono sempre case-sensitive, cioè fanno distinzione tra caratteri maiuscoli e minuscoli: durante la lettura di questo manuale bisogna sempre prestare attenzione a come sono scritti i caratteri e fare sempre attenzione a cosa si digita con la tastiera.

# Come installare Debian 12

La fase di installazione di un sistema operativo è sicuramente una delle fasi può complesse, in questo capitolo sono descritte tutte le fasi passo dopo passo ma grazie al programma grafico di installazione questa è molto semplice e veloce. Tale guida è valida anche per le precedenti versioni di Debian e anche per le successive, infatti dalla mitica versione 3.1 di Debian, chiamata Sarge, il programma di installazione ha subito poche variazioni. Una guida ufficiale per l'installazione può essere trovata nel sito ufficiale di Debian, questo capitolo vuole esserne un riassunto semplice ma completo. Molte distribuzioni di GNU Linux sono gratuite e possono essere scaricate direttamente da internet senza problemi, all'interno del sito ufficiale di Debian www.debian.org è possibile trovare tutte le immagini del DVD di installazione e tutte le informazioni sul sistema operativo; è possibile trovare i DVD di Debian anche pubblicati su riviste o manuali. Per scaricare il DVD per l’installazione basta andare nel sito, entrare nella sezione "Download" o "Getting Debian" e cliccare sul link per il download del file ISO, la versione consigliata è quella di tipo "installazione via rete" chiamata "netinst" ma è possibile scegliere altri tipi di pacchetti nel link "Other Releases". E' possibile scaricare le immagini ISO di grandi dimensioni anche via applicativi peer-to-peer come BTorrent (oppure KTorrent per chi usa già GNU Linux).

$\textcolor{orange}{\textsf{Nota importante}}$: Scaricare l'immagine ISO di Debian da un sistema Torrent (o da qualsiasi altro sistema di peer-to-peer) non è illegale in quanto Debian è free e coperto da licenza GNU che permette il download e l’uso delle immagini. Scaricare film, musica, software con piattaforme peer-to-peer può essere illegale se i contenuti scaricati sono coperti copyright e/o coperti da licenza proprietaria.

E' disponibile nel sito anche una versione "Live" di Debian, cioè una versione che non necessita di una installazione ma può essere avviata dal dispositivo (USB o DVD).all'interno di questa versione è presente il programma di installazione che presenta gli stessi passi descritti per la versione di installazione normale, anche nel caso della versione live è necessario creare un dispositivo da avviare dal BIOS del sistema, si rimanda alla documentazione ufficiale per maggiori informazioni riguardo a questa versione.

Per avviare il programma di installazione bisogna averlo disponibile in un DVD o in una chiavetta USB, nel primo caso si può usare un qualsiasi programma di masterizzazione per copiare il file ISO nel DVD, nel secondo caso bisogna usare programmi specifici disponibili seguendo la guida dal sito ufficiale. In entrambi i casi si tratta di un disco auto-avvianti funzionano solo se il BIOS del sistema è configurato, in questo caso bisogna entrare nel tool di configurazione del bios e impostare il boot nel dispositivo dove è presente il programma di installazione (nella prima videata di accensione di un sistema è presente una scritta del “Press XX to enter in the setup”).

La prima schermata del processo di intallazione l'utente deve scegliere quale tipo inserire, la scelta è tra:

- versione grafica: consigliata se non si hanno configurazioni particolari da impostare
- vestione testuale: consigliata solo per utenti esperti
- versione avanziata: consigliata solo a chi ha bisogno di inserire configurazioni particolari
- versione accessibile e dark: versione grafica ad alto contrasto studiata apposta per gli ipovedenti
- versione live: se presente nel tipo di installer scelto, si avvia la versione live, con questa versione nulla viene installato nel sistema

Qualunque sia il livello di chi installa Debian è consigliata la versione grafica base a meno he non siano necessari configurazioni particolari indispensabili. 

Il programma di installazione prevede alcuni passi che sono riassunti in:
- lingua e tipo di tastiera: l'utente deve inserire la lingua di sistema e il tipo di tastiera, di default è impostato l'inglese ma se si ha la tastiera con le accenti del nostro paese bisogna inserire la tastiera italiana
- nome host e nome dominio: due nomi simbolici per identificare il computer e la rete, se non si dispone di un dominio di rete questi nome sono solo simbolici
- configurazione di rete: se è stata avviata la procedura avanzata viene richiesto l'inserimento degli indirizzi di rete (Indirizzo IP, Subnet Mask e Gateway), se si è scelta la versione grafica standard questo passo è saltato in quanto vengono inseriti dei valori di default grazie al DHCP se presente.
- password root: password principale dell'utente root
- nuovo utente: nome e password del primo utente non amministratore, è "obbligatorio" creare un utente e non usare mai root se non strettamente necessario
- impostazione dischi: l'utente deve selezionare il disco dove installare il sistema operativo, se si dispone di un sistema nuovo si può usare l'opzione automatica, se invece si dispone di dischi con dei dati già presenti o altri sistemi operativi è consigliato usare la procedura manuale e bisogna selezionare il disco dove installare il sistema operativo (partizione indicata con / ), alla fine il programma di installazione chiede una verifica e una ulteriore conferma. Successivamente alla conferma delle partizioni il programma prepara le partizioni formattandole e copiando il sistema base. 
  - $\textcolor{orange}{\textsf{Nota importante}}$: le operazione di creazione e modifica delle partizioni del vostro disco HardDisk potrebbe causare la perdita dei dati all'interno del vostro sistema, è sempre raccomandato eseguire una copia backup dei dati prima di eseguire l'installazione di Debian e la creazione delle partizioni dedicate.
- mirror rete: il programma permette di attivare gli aggiornamenti automatici, selezionando questa opzione il sistema installato risulterà aggiornato alla versione più recente, la scelta consigliata è di attivare i mirror di rete selezionando quello ufficiale che viene proposto di default, si può notare che successivamente verrà installato il Kernel alla versione **linux-image 6.1**
- raccolta dati: il programma permette di attivare un programma statistico con il quale Debian raccoglie le informazioni di utilizzo del sistema, per questioni di privacy è sconsigliato attivare questa opzione
- selezione software: in questo passo l'utente sceglie quale Desktop installare nel sistema, è consigliato installare almeno i tre sistemi base (Gnome, Kde, Xfce) così l'utente può provare il più adatto alle esigenze, dopo questa scelta vengono installate tutte le applicazioni dei rispettivi sistemi selezionati (selezionando i tre principali saranno più di 2381 pacchetti da installare). Nella selezione è sconsigliato attivare l'installazione del web server e del server ssh.
- gestore del login: di default è selezionato il gestore "GDM LightDM", è sconsigliato modificare questa opzione se non strettamente necessario
- gestore di avvio: di default viene installato il gestore Grub, solo nella versione avanzata è possibile modificare le impostazioni base

Nella versione grafica base il sistema viene riavviato senza necessità di inserire altro.

Al primo avvio la schermata di caricamento è quella del bootloader Grub che è stata configurata nell'ultimo passo del programma di installazione, se presente un solo sistema operativo compare solo l’opzione di Debian ma se presenti più sistemi operativi compare la lista dei sistemi disponibili con la possibilità di scegliere quale avviare muovendovi nel menù con le frecce della tastiera. Se disponibili più versioni del Kernel Linux installate nel sistema Debian, compare la lista delle versioni. Una volta selezionata una opzione nel sistema, il sistema avvia tutto il Kernel Linux e i programmi necessari, al termine del caricamento compare la videata grafica di login, questa videata è chiamata GDM (Gnome Desktop manager) che è il componente che permette la login su un desktop: nella videata basta inserire l’username e password dell’utente creato durante la fase di installazione e si accederà al desktop Gnome che di default viene installato e configurato, un utente alle prime armi deve avete la pazienza di aprire i menù del desktop per famigliarizzare con il sistema.

Tutte le fasi e i dettagli del programma di installazione sono ben documentati nella guida disponibile nel sito ufficiale e in caso di necessità particolari è possibile consultare la pagina specifica delle FAQ. Una ulteriore fonte di informazioni è la pagina wiki dedicata al processo di installazione.

# Come gestire i file e le partizioni

Dopo aver completato tutti i passi del programma di installazione, il sistema è già quasi completo: di default nell'installazione base è compreso almeno un Desktop comprendente tutte le parti dell’ambiente grafico e sono compresi anche una serie di applicativi che possono essere trovati sul menù principale. Risulta impossibile usare GNU Linux senza avere qualche base sistemistica e un po’ di manualità su file e cartelle come la gestione i diritti di lettura e scrittura su file e cartelle. Una prima nozione da aver sempre presente è che in tutti i sistemi GNU Linux la differenza tra maiuscole e minuscole è rilevante: nei comandi e nei file è rilevante la presenza di caratteri maiuscoli e bisogna scrivere sempre con attenzione i nomi.

Una nozione fondamentale che un utente di GNU Linux deve avere sempre presente è che tutto è un file cioè il Kernel Linux infatti vede e gestisce tutto come un file: le cartelle, le periferiche come le stampanti, memorie fisse e persino i processi in esecuzione sono interpretati come file che il FileSystem gestisce e amministra. A differenza di altri FileSystem, in GNU Linux le estensioni non sono rilevanti, spesso capiterà di trovare file con estensioni “strane” ad un utente non abituato a tale libertà: un esempio classico è il file sources.list che conterrà una lista di sorgenti come dice il nome e l'estensione: spesso infatti viene usata l’estensione per evidenziare se il file ha un contenuto specifico come liste o configurazioni. Esistono anche file senza estensione come il file fstab, per i sistemi basati su Unix e GNU Linux l’estensione di un file è solo una parte del nome. I file il cui nome inizia per . (punto) sono file nascosti, cioè tipicamente i file manager non vedono questi file a meno di comandi specifici, questi nomi vengono usati dai programmi per creare cartelle e file di configurazioni ma di non dare la possibilità all'utente di modificarli *per errore*.

Lo standard per il file system usato in tutti i sistemi GNU Linux si chiama FSSTND, che impone delle direttive per l'organizzazione dell'albero delle directory nei sistemi: viene usato per la facilità del porting del software per GNU Linux e l'amministrare dei sistemi, dato che tutto si trova nel posto designato per qualsiasi distribuzione che usa questo stardard. Per essere precisi, non c'è nessuna autorità che impone di uniformarsi a questo schema, ma è molto raro trovare distribuzioni che non rispettano. L'albero delle directory completo è concepito in modo che possa essere diviso in parti più piccole, ciascuna sulla sua partizione o nel suo disco se necessario, per ottimizzare i dischi e ridurre le dimensioni delle partizioni. L'albero delle directory è stato strutturato in modo che funzioni bene in una rete di sistemi condivisi su dispositivi a sola lettura come DVD o in reteNFS. La struttura del filesystem si basa su una radice che viene chiamata root e viene sempre indicata con il carattere
```
/
```
questa cartella è specifica per ciascun sistema e rappresenta l'intero sistema: contiene tutti i file necessari per avviare il sistema e per portarlo ad uno stato tale da poter gestire tutte le altre memorie e tutti i dispositivi. Si può affermare, anche se in maniera un po' superficiale, che la root sostituisce quello che nei sistemi MS Windows è il "Risorse del computer", infatti in Linux non potete trovare i dischi (C,D,E, ecc..) ma si possono trovare le principali sottodirectory:

- ```/bin``` Contiene i programmi di sistema utilizzati sia dall'amministratore che dai normali utenti, come ad esempio: ls, cat, cp
- ```/boot``` Contiene tutto quello che è necessario per eseguire il processo di boot del kernel (l'immagine vmlinux e la initrd), configurata in fase di installazione di GRUB
- ```/dev``` Contiene i riferimenti a tutti i dispositivi e le periferiche (HarkDisk, CdRom, stampanti, rete, ecc...)
- ```/etc``` Contiene i files di configurazione degli applicativi e i demoni presenti nel sistema
- ```/home``` Contiene le home directory degli utenti, cioè le informazioni e i file di ogni utente
- ```/lib``` Contiene le librerie necessarie al boot del sistema e all'esecuzione dei programmi
- ```/mnt``` Inizialmente è vuota, come standard viene usata per effettuare il collegamento (mount) di tutte le unità di memoria presenti (HardDisk, cdrom, memorie usb, ecc.. ), talvolta è possibile trovare anche la cartella /media che tipicamente viene usata solo per i dispositivi rimovibili (CdRom, Floppy, USB Disk)
- ```/opt``` Dovrebbe essere vuota inizialmente, in passato veniva usata per gli applicativi del sistema base, oggi viene usata da alcuni applicativi proprietari come google chrome oppure i programmi di AWS
- ```/proc``` Contiene i riferimenti ai programmi in esecuzione (i processi in esecuzione vengono trattati come file)
- ```/root``` La home directory dell'utente root
- ```/sbin``` Contiene i programmi di sistema (system binaries) utilizzati dall'amministratore
- ```/srv``` Contiene alcuni file di configurazione
- ```/sys``` Contiene dei file di sistema
- ```/tmp``` Cartella dei file temporanei (ogni volta che si spegne il pc questa cartella viene svuotata)
- ```/usr``` Contiene le applicazioni (non di sistema) installate nel sistema
- ```/var``` Contiene vari files di sistema come i log e le carelle della posta

## Gestione dei permessi

Nei sistemi Unix e GNU Linux esistono tre tipi di diritti su un file: scrittura, lettura ed esecuzione rispettivamente identificati con la lettera r, w e x. Ogni file, quindi ogni cosa nel sistema, appartiene all'utente che ha creato quel file che ha sempre i tutti i diritti su quel file. Per ottenere i diritti su un file basta eseguire il comando sulla shell:
```
$ ls -la
```
che elenca i diritti in una schermata simile a questa:
```
drwxr-xr-x 2 alnao alnao 4096 2 feb 14:09 DIR1
-rw------- 1 alnao alnao 2615 2 feb 16:28 file1
-rw-r--r-- 1 alnao alnao 1162966 2 feb 19:50 file2
-rwxr-xr-x 1 alnao alnao 1162966 2 feb 19:50 file3
```
la prima riga descrive una directory, la si può riconoscere dal fatto che la prima lettera è una d, i successivi tre caratteri sono indicati i diritti sull'utente che ha creato quel file, il secondo gruppo di tre si riferisce agli utenti dello stesso gruppo dell'utente creatore del file, mentre l'ultima tripletta descrive i diritti di tutti gli altri utenti. Se è presente la lettera significa che il diritto è attivo mentre se c'è il trattino vuol dire che il diritto che dovrebbe essere presente non è attivo. Da notare che l'utente root root ha sempre tutte le autorizzazioni quindi riuscirà sempre a leggere e a scrivere su tutti i file e su tutte le cartelle. Per cambiare i diritti su un file si può usare il comando chmod. Da notare che il diritto x sostituisce l'estensione su altri sistemi: le estensioni non hanno significato e per capire se un file è eseguibile o meno bisogna osservare questo diritto in ogni singolo file.

Alcune delle configurazioni base devono essere eseguite da riga di comando che in informatica viene comunemente chiamata shell e, più in particolare, nei sistemi GNU Linux è disponibile il tipo chiamato bash, non bisogna fare confusione: con shell si intende una riga di comando mentre bash è l’interprete dei comandi, in questo manuale faremo sempre riferimento a bash e non verranno introdotte altre tipi di shell anche se in altri manuali potete trovare guide più complete di bash e di altri tipi di shell per GNU Linux. Tipicamente nelle architetture basate sul KernerLinux con la bash sono disponibili 8 “canali” detti anche tty (abbreviazione di TeleTYpewriter), nei sistemi basati su GNU Linux il primo canale è usato dal KernelLinux e in questo canale compaiono i messaggi del sistema mentre il server grafico tipicamente si trova nel settimo canale, dalla versione 10 di Debian il server grafico viene caricato sempre dal secondo canale mentre nel primo c'è una seconda versione del server grafico se si vuole utilizzare la funzionalità multiutente; è possibile passare da un canale ad un altro con la sequenza di tasti ALT + CTRL + F1 dove l’F1 è il numero del canale (ovviamente per il settimo canale si può usare F7).

## Il mounting

Una delle esigenze primarie di ogni utente è quello di poter accedere ai propri dati che sono salvati nei vari dischi, gli utenti di altri sistemi operativi sono abituati a identificare le memorie fisiche con delle lettere come C, D, E, ecc... mentre nei sistemi GNU Linux la gestione delle partizioni e delle periferiche di memoria è completamente diversa: la gestione viene chiamata **mounting** (in Italiano spesso viene tradotto con montaggio), nome che deriva dal comando mount che viene utilizzato per eseguire le configurazioni, infatti le memorie vengono viste dal Kernel Linux come un normale file dentro alla cartella /dev/ e, attraverso il comando mount, si possono collegare ad una cartella per permettere l’accesso al contenuto della memoria. I file che si trovano dentro alla cartella dev non rappresentano tutta la memoria fisica ma rappresentano una partizione: se in una memoria ci sono più partizioni significa che sono presenti più file che devono essere montati separatamente. Tipicamente questi file hanno il nome del tipo hda1, sda1, sda2, sdb1 dove la prima lettera del nome rappresenta il tipo (per esempio h=Eide, s=Sata), la seconda lettera è sempre d che significa DISK mentre la terza lettera è un incrementale se ci sono più dispositivi dello stesso tipo (se ci sono due HardDisk il primo sarà “a” mentre il secondo sarà “b”), il numero finale rappresenta il numero della partizione all'interno della stessa memoria fisica.


Per poter recuperare l'elenco delle partizioni e la struttura delle memorie si può usare il programma gparted dal desktop da installare oppure con il comando
```
# fdisk -l
```
Questi programmi presentano l’elenco di tutte le partizioni e, se possibile, anche il tipo, con gparted è anche possibile modificare le partizione e formattarle. Nei desktop recenti, il mount risulta automatico, per esempio con un programma come Dolphin, l'elenco dei dispositivi sono elencati nelle finestre divisi per memorie fissi e i dispositivi mobili come le chiavette USB. Per poter eseguire il mount manualmente, bisogna disporre di una cartella vuota che sarà la destinazione dell’operazione di montaggio, come default viene usata una sotto-cartella di /mnt . Per esempio si può creare una cartella a mano da un file manager oppure da riga di comando con le istruzioni:
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
dove nella riga sono elencati in ordine: il punto di mount (sorgente e destinazione), il tipo di partizione anche se è sconsigliato l'uso del comando auto e i vari parametri della partizione, nel nostro esempio umask=000 oppure rw indicano che la partizione è in scrittura e lettura. Per le partizioni di formato GNU Linux come ext non serve indicare l’umask.

Per le chiavette USB o memorie rimovibili si configura la riga:
```
/dev/sdd1 /mnt/Usb auto user,suid,dev,exec,umask=000,rw,noauto 0 0
```
con il parametro noauto si indica che il mount non deve essere eseguito automaticamente all'avvio del sistema ma deve essere caricato manualmente quando la memoria esterna viene inserita. Per rendere effettive le modifiche del file fstab bisogna riavviare il sistema. Per definire le partizione nel file di configurazione è possibile mappare il riferimento dentro la cartella dev oppure è possibile usare il riferimento UUID, cioè il riferimento assoluto ID che il sistema assegna ad ogni partizione, per visualizzare i riferimenti nel proprio sistema si può usare il comando:
```
# blkid
```
e poi è possibile modificare il file fstab con la riga:
```
UUID=1234-5678 /mnt/Dati tipo parametri 0 0
```
questo metodo è consigliato rispetto all'uso del DEV in quanto alcuni sistemi posso cambiare riferimenti alla risorse ogni riavvio del sistema. Nelle ultime versioni di Debian questa operazione viene eseguita durante la fase di installazione e, una volta terminata l'installazione del sistema base, è possibile vedere il file già ben configurato con tutti i parametri. Da notare che i lettori DVD/CD vengono montate nella cartella media per separare le memorie fisse da quelle rimovibili tuttavia questo non è uno standard ma solo un dettaglio presente in Debian.

Modificare lo schema delle partizioni è una operazione complessa alto rischio di perdita di dati; la mia esperienza mi ha portato a non modificare mai le partizioni dei dischi se su questo è installato il sistema operativo o se ci sono dati importanti, quando si deve modificare una qualsiasi partizione contenente dati, conviene sempre eseguire una copia di backup di tutte le partizioni comprese quelle non modificate. Le cose si complicano ancora di più quando nello stesso disco ci sono più partizioni di tipo diverso come quelle di MsWindows (con filesystem di tipo NTFS o FAT32) e partizioni GNU Linux (con filesystem di tipo le Ext3 o Ext4), questo perché i programmi di partizionamento di un sistema operativo difficilmente trattano al meglio le partizioni degli altri sistemi con l'ovvio rischio di perdere partizioni che un programma non riconosce, per evitare questi contrasti fra sistemi operativi si possono usare programmi specializzati che cercano di gestire al meglio le partizioni di tutti i tipi, su Debian è disponibile il programma GParted per permette di gestire e modificare la struttura delle partizioni dei dischi.


Per la gestione delle partizioni di tipo **swap**, è possibile confiurare le partizioni fisiche le file `fstab` come le normali partizioni, per esempio la riga:
```
/dev/sda2 none swap sw 0 0
```
Per visualizzare l'elenco delle partizioni swap si possono usare i comandi del sistema operativo:
```
swapon --show
free -h
df -h
```
Le ultime versione del Kernel Linux permettono di creare e montare dei file come fossero delle partizioni swap, per creare e montare il file si possono essere eseguire i comandi:
```
fallocate -l 1G swapfile
ls -lh swapfile
chmod 600 swapfile
mkswap swapfile
swapon swapfile
```
infine è possibile inserire la configurazione nel file `fstab` impostando il path assoluto del file swapfile creato, per esempio con il comando
```
echo '/path/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

Il parametro di configurazione `swappiness` indica al sistema operativo quanto spesso eseguire l'operazione di trasferimento dalla memoria RAM verso lo spazio swap, è una percentuale da zero a cento e di default è impostata a sesanta, può essere verificata e modificata con i comandi:
```
$ cat /proc/sys/vm/swappiness
# sysctl vm.swappiness=10
# nano /etc/sysctl.conf
```


# Come gestire i pacchetti Debian e il pannello di controllo

Per utilizzare al meglio i sistemi Debian è indispensabile conoscere la gestione dei pacchetti: i pacchetti sono un insieme di file organizzati e compressi in directory in modo che possano essere installati nel sistema velocemente e con ordine; esistono molti modi di compilare e preparare i pacchetti, Debian ha imposto da anni un suo standard che è facilmente riconoscibile per i file di estensione deb mentre altre distribuzioni possono avere altri formati come rpm. Uno dei motivi per cui Debian è molto famosa è proprio per la gestione eccellente dei pacchetti perché, pur contando oltre 25.000 pacchetti ufficiale, esiste un repository centrale che gestisce le le dipendenze in modo semplice e ordinato: ogni pacchetto ha una versione e una lista di dipendenze infatti ogni pacchetto al suo interno ha l'informazione di quali pacchetti sono necessari e con i quali entra in conflitto, per esempio il pacchetto "apache2-mpm-prefork" dipende dal pacchetto "apache2.2-common" e entra in conflitto con il pacchetto "apache2-mpm", tutto questo dipende anche delle versioni, cioè ogni pacchetto è segnato anche da una versione, per esempio nel mio sistema è installato il pacchetto "apache2-mpm-prefork" alla versione 2.2.8-3: questo vuol dire che il pacchetto è alla versione 2.2.8 ma è la terza compilazione del pacchetto. Per fortuna i programmi che andremo ad usare gestiscono automaticamente con ordine e precisione i pacchetti quindi l'utente non deve mai preoccuparsi di risolvere le dipendenze.

La gestione dei pacchetti Debian nel sistema si basa sul componente DPKG (abbreviazione di Debian PacKaGe): è usato per installare, disinstallare ed ottenere informazioni sul singolo pacchetto in formato standard deb. Questo è un tool di basso livello e viene sempre affiancato da APT (che è l'abbreviazione di Advanced Packaging Tool) che è il gestore standard di pacchetti software della distribuzione Debian. Con APT è possibile anche configurare diversi mirror-sorgenti di pacchetti (sorgenti remote in internet, cdrom, DVD). Tutti i comandi dei due programmi sono:

- ```# apt-get update aggiorna``` la lista dei pacchetti dopo la configurazione di un nuovo mirror
- ```# apt-get install nomepacchetto``` installa il pacchetto nel sistema, scegliendo l'ultima versione disponibile ed risolvendo le dipendenze in maniera automatica (installando i pacchetti necessari e togliendo i pacchetti in conflitto)
- ```# apt-get remove nomepacchetto``` rimuove il pacchetto e tutti i pacchetti che dipendono da esso
- ```# apt-get --purge remove nomepacchetto``` rimuove il pacchetto e tutti i pacchetti che dipendono da esso compresi anche tutti i file di configurazione eventualmente presenti
- ```# apt-get upgrade``` aggiorna tutti i pacchetti se sono disponibili aggiornamenti e verifica tutte le dipendenze delle nuove versioni
- ```# apt-get clean``` cancella tuti i file temporanei di apt-get cioè i file deb scaricati e già installati
- ```# apt-get install -f``` verifica che tutti i pacchetti siano installati e configurati correttamente, in caso di errori sistema automaticamente le dipendenze
- ```# dkpg --configure -a``` come il precedente ma funziona anche in casi estremi e risolve tutti i problemi di conflitto tra i pacchetti
- ```# dpkg-reconfigure pacchetto``` riconfigura un pacchetto già installato
- ```# dpkg -i pacchetto``` installa un pacchetto da un file deb
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
In precedenti versioni di questo documento si indicava all'utente di modificare manualmente i file di list per inserire i mirror manualmente, questa operazione manuale è stata sostituita da operazioni più semplici che verranno introdotte man mano che sarà necessario installare pacchetti specifici non compresi nei mirror ufficiali di Debian che sono inseriti in automatico all'installazione del sistema base. I programmi di gestione APT & DPKG non sono stati studiati per essere interfacciati graficamente, quindi sono stati sviluppati e sono presenti in Debian diversi strumenti grafici che permettono di gestire i pacchetti attraverso una interfaccia grafica che può risultare più intuitiva all'utente meno esperto: il più importante programma per desktop per la gestione dei pacchetti è Synaptic che spesso si può trovare nei menù anche con il nome in italiano di Gestore pacchetti, la potenza di questo programma è la semplicità d'uso rispetto ad altri programmi simili come Aptitude e Adept che sono molto più poveri di funzioni. Con Synaptic è possibile vedere la lista dei pacchetti divisi in sezione per argomento (sistema, grafici, editor,...), per stato (installati, aggiornabili, non installati, corrotti), per origine (DVD, debian.org, ecc...) e la possibilità di cercare i pacchetti con una semplice ricerca testuale sui nomi e sulle descrizioni dei pacchetti stessi. La comodità principale di questo programma è la possibilità di gestire gli aggiornamenti del sistema con un semplice click su pulsante.

## Il pannello di controllo WebMin

Nei sistemi Debian è possibile trovare diversi programmi che permettano la configurazione del sistema, nei vari menu dei desktop si possono trovare diverse voci all'interno della categoria Strumenti di sistema però per GNU Linux è stato sviluppato un potentissimo programma per il controllo generale: **WebMin** che prevedete moltissimi moduli al proprio interno e permette all'utente di amministrare tutti i componenti del sistema, uno dei grandi vantaggi di questo pacchetto è che si tratta di una applicazione web quindi viene usata tramite browser anche da remoto. Rispetto alle precedenti versioni, WebMin non è più all'interno dei mirror ufficiali di Debian e quindi bisogna configurare una sorgente esterna con i comandi:
```
# apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl 
# apt-get install libpam-runtime libio-pty-perl apt-show-versions python3 apt-transport-https
# apt-get install wget net-tools ufw
# cd /etc/apt/sources.list.d/
# echo "deb http://download.webmin.com/download/repository sarge contrib" > webmin.list
# wget http://www.webmin.com/jcameron-key.asc
# apt-key add jcameron-key.asc 
# apt-get update 
# apt-get install webmin
# ufw allow 10000/tcp
# ufw reload
# ufw enable
```
con questi comandi abbiamo installato dei pacchetti propedeutici, abbiamo scaricato il file list del mirror e la sua chiave di sicurezza, poi con il comando di apt abbiamo aggiornato l'elenco dei pacchetti e installato il programma, al termine è necessario configurare la rete visto che il programma utilizza la porta 10.000 dei sistemi. Dopo l'installazione è possibile già vedere se è disponibile e funzionante con il comando:
```
# systemctl status webmin
```
Se non dovesse essere avviato è possibile lanciare lo start con il comando:
```
# systemctl start webmin
```
Per poter accedere al pannello di controllo basta lanciare da un browser l'url:
```
https://localhost:10000/
```
nei comandi indicati c'è anche la configurazione del firewall ufw che bloccherebbe l'applicazione trattandosi di una applicazione di rete sulla porta 10000. All'interno delle ultime versioni di Webmin, c'è la possibilità di collegarsi alla console shell con l'icona >_ presente nel menù di sinistra al tab "dashbord" questo permette di usare il terminale da remoto anche se io lo ritengo molto scomodo.

$\textcolor{orange}{\textsf{Nota importante}}$: WebMin è uno strumento molto potente ma anche troppo! Bisogna sempre prestare attenzione alle configurazioni eseguite e controllare più volte le operazioni potenzialmente distruttive per il sistema.

Il programma di installazione prevede la creazione di un primo utente che viene utilizzato al primo accesso, attraverso i vari tool di controllo disponibili è possibile creare e configurare altri utenti se necessario con la possibilità di raggrupparli e gestire l'accesso. Il gestore della login che compare all'avvio del sistema grafico si chiamata **GDM** (abbreviazione di Gnome Desktop Manager) esistono anche altri gestori ma è sconsigliato l'utilizzo per utente non esperti. Per gestire gli utenti è possibile usare i vari programmi disponibili nei browser ma è consigliato usare WebMin appena installato visto che ha una interfaccia molto semplice e intuitiva per la gestione degli utenti e dei gruppi. Il pannello di controllo WebMin è molto utile anche per la gestione di tutte le parti di un sistema: lo schedulatore di sistema CronTab, le configurazioni di rete, la gestione dei backup, il monitoraggio dei log e i demoni/server come sarà descritto in una sezione dedicata. In realtà è iii sconsigliato iii per alcuni temi specifici come la gestione delle partizioni (molto meglio Gparted) e tutto quello che ha a che fare con l'hardware e i dispositivi esterni.

# Come gestire i desktop e le applicazioni

Nel mondo GNU Linux il principale server grafico è **X-WindowSystem** (spesso abbreviato con X), questo gestire l'interfaccia utente e bisogna ricordare che non esiste un unico desktop: esistono diversi desktop che possono essere installati ed usati parallelamente, infatti esiste la possibilità di passare da un desktop ad un altro selezionando il nome nella schermata di login all'avvio del sistema; tutte le applicazioni possono essere eseguite da qualsiasi tipo di desktop. I principali desktop per GNU Linux basati sul server grafico X sono: **GNOME**, **KDE** e **XFCE** mentre quelli leggeri e studiati per essere veloci sono MATE e LXDE, è consigliato la prova di tutti i cinque appena elencati in modo che un utente possa scegliere il più consono. In tutte le architetture basate sul KernerLinux, nella bash sono disponibili 8 “canali” detti anche tty (abbreviazione di TeleTYpewriter), nei sistemi basati su GNU Linux il primo canale è usato dal KernelLinux e in questo canale compaiono i messaggi del sistema mentre il server grafico e il desktop si trova nel settimo canale, dalla versione 10 di Debian il server grafico viene caricato sempre dal secondo canale mentre nel primo c'è una seconda versione del server grafico se si vuole utilizzare la funzionalità multiutente; è possibile passare da un canale ad un altro con la sequenza di tasti ALT + CTRL + F1 dove l’F1 è il numero del canale (ovviamente per il settimo canale si può usare F7).

Il più famoso desktop per il mondo GNU Linux è **GNOME** che di default viene attivato in fase di installazione di Debian, il gestore è ornami riconosciuto come il miglior gestore con un numero lunghissimo di applicazioni disponibili, le principali saranno elencate in questa sezione. Rispetto ad altri desktop, Gnome mette a disposizione alcune estensioni molto comode integrate nel sistema che possono essere facilmente installate dall'applicazione Estensioni oppure andando sul sito
```
extensions.gnome.org
```
Le più famose ed usate sono elencate nel sito stesso e sono: Application Menu, Removable drive, Window list, User themes, Sound & Input, Traiyicons, App icons taskbar e Just Perfection. Inoltre è disponibile anche una applicazione personalizzazioni studiata per permettere agli utenti di modificare l'aspetto grafico del desktop.

## Gestione e installazione applicazioni

Uno degli errori più frequenti degli utenti comuni è pensare che non esistono applicazioni per il normale utilizzo di un computer, la verità è l'esatto opposto: esistono migliaia di applicazioni che rendono i sistemi GNU Linux completi e perfettamente utilizzabili. Basta infatti aprire il programma di gestione dei pacchetti **Synaptic** e usare la funzionalità di raggruppamento per categoria per rendersi conto delle migliaia di applicazioni disponibili nei repository Debian: oltre alla numerosità delle applicazioni, grazie a Synaptic, è possibile sfruttare la gestione dei pacchetti di Debian per evitare il problema delle dipendenze quindi un utente non deve preoccuparsi di nulla e non deve nemmeno preoccuparsi del desktop utilizzato. Tutti i pacchetti disponibili sui server mirror di Debian sono totalmente gratuiti e scaricabili dai mirror internet, su altri mirror non ufficiali è possibile scaricare altri programmi gratuitamente, per esempio il mirror di Google permette il download e l'installazione del browser Chrome. Purtroppo non esiste un elenco completo ed ufficiale di tutti i programmi disponibili, questo perché i programmi vengono creati quotidianamente e certi progetti chiudono per l’insuccesso di una applicazione o la sua scarsa utilità.

In aggiunta al repository ufficiale Debian e ai repository proprietari, come quello di Google, è possibile usare anche il gestore **snapd**: un servizio web che mette a disposizione pacchetti scaricabili e funzionanti. Il consiglio è di usare questo servizio solo per quelle applicazioni o quei pacchetti che non si trovano nei repository ufficiali Debian ed è quello che verrà fatto in seguito. Per installare Snapd basta installare il pacchetto snapd, da non confondere con il pacchetto snap che invece riguarda una applicazione scientifica. Una volta installato il pacchetto è possibile vedere l'elenco dei pacchetti installati sul sistema con Snapd con il comando:
```
$ snap list
```
correttamente senza la lettere d finale in quanto il pacchetto ha la lettere finale per indicare che si tratta di un demone mentre il comando è senza la finale. Per installare un programma con questo servizio basta usare il comando:
```
$ snap install nomeprogramma
```
l'elenco di tutte le migliaia di programmi disponibili si trova nel sito ufficiale snapcraft.io, un esempio di applicazione consigliata su questo sistema è Spotify.

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

Gli utenti di GNU Linux devono aver confidenza con i file di testo per modificare alcuni vari file di configurazione, anche se può sembrare antiquato agli utenti meno esperti, in realtà è molto più semplice e veloce di quanto possa sembrare. Sui sistemi basati su Debian è possibile trovare facilmente alcuni editor di testo più o meno complicati a seconda delle esigenze: per la shell da riga di comando esistono i famosi (e storici) programmi vim e emacs, forse troppo complicati per utenti poco esperti, i programmi più semplici da usare da riga di comando sono pico e nano che risulta molto semplice da usare visto che con la pressione del tasto CTRL è possibile cambiare dalla modalità editor a menù e viceversa. Negli ambienti grafici desktop sono disponibili molti programmi, tipicamente ogni desktop ha il proprio programma di default ma nessuno vieta di usare altri programmi anche di altri desktop, per esempio il programma di default di KDE è **kEdit** ma è possibile usare anche i programmi di GNOME come **gEdit** oppure **mousepad**. Tuttavia il programma più completo è Kate che, oltre ad essere un semplice editor di testo, può essere usato per programmare grazie al suo plugin di riconoscimento dei linguaggi di programmazione oppure può essere usato per la scrittura di documenti. Come già visto più volte, i file possono avere nomi ed estensioni ad apparenza strani' e molti file di testo non hanno estensione il classico txt che di solito si trova su altri sistemi operativi, dobbiamo sempre tenere a mente che sui sistemi basati su GNU Linux le estensioni non hanno molto valore se non per pura naming-convention o estetica: molti file hanno estensione conf e tipicamente si trovano nella cartella /etc o una sottodirectory ma alcuni file hanno nomi non parlanti o posso essere senza estensione come il file fstab. Da snapd è possibile scaricare il famoso Notepad++ oppure nei repository ufficiali è possibile selezionare jEdit, questi due programmi sono i più famosi e potenti programmi per la modifica di file dei testo.

Per esplorare e navigare tra le varie cartelle del sistema, oltre che alla riga di commando, è possibile utilizzare i tanti programmi file manager, tipicamente ogni Desktop ha il proprio file manager di default e spesso in un desktop è possibile trovarne anche più di uno, il programma predefinito sul Desktop KDE è **Konqueror** e può essere usato anche in altri desktop, nonostante sia vecchio è ancora usatissimo come file exploper ed è stato migliorato molto tanto da diventare uno dei miglioro programmi per muoversi tra le varie cartelle del sistema. La potenzialità maggiore è quella di poter visualizzare l’albero delle cartelle, inoltre nelle versioni più recenti sono stati integrati anche un visualizzatore di immagini, un piccolo editor di testo e il sistema veloce per gestire i file archivi (come zip e tar). Altra applicazione da provare è **dolphin** che presenta una interfaccia molto semplice e veloce, pur non disponendo di plugin, rimane il più intuitivo programma per navigare tra le cartelle, anche in questo programma sono disponibili i plugin per visualizzare l'albero delle cartelle, ovviamente questo è compatibile con tutti i Desktop e permette anche di avere una shell in basso alla finestra che segue l'utente nella navigazione dell'utente nelle cartelle. Ovviamente un utente può benissimo usare un qualsiasi altro programma disponibile sui Desktop oppure basta aprire Synaptic per installarne decine, lo storico commander può essere trovato con il nome di Midnight Commander oppure Gnome Commander.

## Compressione ZIP e simili

Gli standard di compressione del mondo GNU Linux si chiamano tar, gz e bz, ma possono essere usati anche altri formati come i più famosi zip e rar, per riconoscere in quale formato è compresso un file basta guardare l’estensione del file, da notare che le estensioni possono essere composte: per esempio un file può avere estensione nomefile.tar.gz oppure il semplice nomefile.zip. Visto che il formato rar è un algoritmo proprietario e non free, per poterlo usare è necessario installare i pacchetti rar, rar-2.80, unar e unace-nonfree che potete trovare nei repository "non free" nel mirror.

Per usare lo standard TAR da riga di comando, i principali comandi sono:
```
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

Per chi usa invece un desktop ci sono varie possibilità, il migliore programma che avete a disposizione è un programma chiamato Gestore di archivi che potete trovare sul menù Accessori di tutti i desktop (potete trovarlo anche con il nome file-roller), con questo semplice programma potete creare, comprimere e decomprimere file compressi in tutti i formati. Se invece usate Konqueror o Dolphin, potete usare il sistema integrato per la gestione dei sistemi di compressione chiamato ark che deve essere installato dal gestore dei pacchetti Synaptic e vi permetterà di gestire tutti i formati con pochi click: basta cliccare con il tasto destro del mouse su file o directory per avere la funzionalità "Comprimi" o su un singolo file compresso per avere la funzionalità di decompressione.

## Browser e mail

Nel mondo GNU Linux e Debian potete trovare moltissimi programmi per la navigazione internet e la gestione delle mail, il browser più famoso in assoluto per GNU Linux è **Firefox** che è installato di default su tutte le distribuzioni Debian recenti. E' consigliato di installare da Synaptic anche il pacchetto flashplayer-mozilla se necessario avere il plugin per l’esecuzione dei flash e di installare il pacchetto totem-mozilla per la visualizzazione di video e filmati direttamente sul browser. Sui sistemi GNU Linux potete usare anche altri programmi come Amaya, Konqueror ed Epiphany.

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


## Skype e Discord

I migliori programmi per le chat e l’instant messaging per GNU Linux sono Pidgin (ex Gaim), kMess e aMSN. Per installare il programma Skype nel sistema basta scaricare e installare il pacchetto con i comandi:
```
# wget https://go.skype.com/skypeforlinux-64.deb
# wget apt install skypeforlinux-64.deb
```
però è possibile usare anche altri VoIP-client come Ekiga, WengoPhone e Asterisk.

Per installare l'applicazione Discord basta scaricare il pacchetto dal sito ufficiale, con i comandi:
```
# wget "https://discordapp.com/api/download?platform=linux\&format=deb" -O discord.deb
# dpkg -i discord.deb
```

## Appliazioni multimediali

Anche per quanto riguarda la multimedialità nei sistemi GNU Linux sono presenti moltissimi programmi, non solo per la visualizzazione dei video ma anche per l'editing video e sono disponibili plugin per tutti i formati; inoltre in tutte le distribuzioni sono presenti i programmi e i driver per vedere la TV con il computer, ovviamente questo è possibile se, nel proprio pc, è presente un dispositivo di acquisizione TV come le chiavette USB. Prima di tutto bisogna scaricare ed installare i Codec, cioè le librerie necessarie per poter codificare i vari formati, per questa installazione basta usare Synaptic e controllare che i seguenti pacchetti siano già installati nel vostro sistema:
```
libavcodec57
libavdevice57
libdvdnav4
libdvdread4
mpeglib (se presente)
libavformat57
libxvidcore4
```
La base del sistema audio è il sottosistema ALSA, responsabile di tutti i suoni prodotti dal sistema, ad oggi non ci sono più problemi per la compatibilità con le varie schede audio delle tante marche di computer quindi automaticamente il sistema installerà ALSA e vi installerà anche una serie di pacchetti per l'uso della stessa scheda, compreso il programma per gestire i volumi e la riproduzione dei suoni base, è possibile trovare la lista dei programmi nella categoria Multimedia. Per la visualizzazione dei video c'è l'imbarazzo della scelta: il più famoso è **Totem**, lettore molto semplice e comodo, in tutti i desktop è il programma di default. La lista dei player di file multimediali è lunghissima ed eviterò di annoiare il lettore (come sempre ho cercato di fare in questo documento), sono elencati solo i programmi degni di nota:

- **VLC** famoso player gratuito disponibile anche su altre piattaforme
- Codeine programma molto semplice e con le scalette di produzione
- KPlayer simile a Totem anche se incompleto in alcuni punti
- Amarok programma per ascoltare musica avendo la possibilità di creare una playlist
- Kaffeine buon programma per ascoltare musica
- MPlayer player di video

Per poter visualizzare i filmati nel formato di **RealPlayer** bisogna scaricare e installare il pacchetto disponibile sul sito RealPlayer, esistevano delle librerie che permettevano la visione dei file RealPlayer anche su Totem e su tutti i player di Linux ma sono stati rimossi perché non rispecchiamo le linee guida di Debian. Chi dispone di una scheda di acquisizione TV di tipo DDT (digitale terrestre) può tranquillamente vedere i canali: Debian contiene dei programmi per guardare la tv e registrare i propri programmi preferiti, una lista parziale dei programmi a disposizione come XawTV, XdTV, Kplayer e MythTV. Per GNU Linux esistono anche una lunga lista di programmi per la manipolazione e l'editing audio e video che si basano tutti sui comandi da riga di comando convert, i quattro programmi principali sono Sweep, Kwave, Audacity e **Avidemux**, i primi tre sono utili per modificare file audio come mp3, il quarto è un semplice programma che serve per modificare, concatenare i file video, in particolare Avidemux è un programma molto utile anche perché è compatibile con tutti i formati se i codec sono installati nel sistema.

Per Debian è disponibile anche il famoso programma **OBS**, questo permette di eseguire registrazioni video e di eseguire streaming su alcune piattaforme come Twitch. Il programma è disponibile nel repository ufficiale di Debian con il nome di obs-studio. Per chi volesse creare il proprio DVD può provare ad usare il programma mandvd, questo programma permette di aggiungere i tuoi video al progetto del DVD, assegnare un immagine per creare il tasto di selezione di ciascun video, creare dei video slideshow delle tue foto (con o senza musica di sottofondo); alla fine del progetto, si converte il tutto nella classica struttura DVD, e si sceglie se masterizzare il progetto con K3B oppure creare un immagine ISO, scelta utile in caso ci sia la necessita di fare più copie. Per chi volesse invece rippare un DVD può usare dvdriv, un piccolo programma di utilità che permette la copia di DVD su Linux.

Per **Spotify** è consigliato l'uso del gestore snapd
```
snap install spotify
```
Su Synaptic potete trovare un elenco completo di tutte le applicazioni disponibili su Debian per la visualizzazione e l'editing di immagini e foto, dovete tenere presente anche che ogni desktop manager ha il proprio programma di visualizzazione delle immagini, è consigliato provare tutti i programmi già disponibili prima di scegliere un uno specifico. Per prima cosa dovete sapere che lo standard di GNU Linux per le immagini è il png anche se potete trovare e usare tranquillamente i formati jpg o gif. Tra i programmi per la modifica delle immagini è disponibile il famoso programma **GIMP (GNU Image Manipulation Program)**, che è il più famoso programma di GNU Linux per la modifica delle immagini e uno dei più usati al mondo visto che è disponibile su tutte le piattaforme ed è completamente gratuito, le ultime versioni sono veramente all'altezza dei rivali. Per la grafica 3D è disponibile il famoso **Blender** anche se, in questo caso, conviene usare la versione su Snapd in quanto è una versione più recente; mentre è possibile usare Dia che permette di creare diagrammi di flusso, circuiti elettrici, grafici UML, diagrammi di rete, diagrammi E-R ed altri ancora.

All'interno dei desktop manager principali è possibile trovare installati automaticamente dei PDF reader però si possono installare programmi evoluti come kPDF e pdfedit, questo secondo permette di modificare file in formato PDF.

Senza alcun dubbio **K3B** è la migliore applicazione per GNU Linux per la masterizzazione di CD-ROM e DVD, sorprende sempre la velocità e la semplicità d'uso di questa applicazione anche se per masterizzare è possibile scegliere anche altri programmi come GnomeBaker, Nero for GNU Linux, oppure i comandi da riga di comando cdrecord e growisofs mentre per creare dischi-video potete provare VCDImager.

## Dropbox

Per i servizi **Dropbox** esiste il pacchetto dedicato ufficiale, purtroppo non è nei repository ufficiali è necessario scaricare il pacchetto manualmente perché non esiste repository dedicato, per l'installazione veloce basta eseguire il comando di installazione
```
dpkg -i nomePacchetto.deb
```
al termine dell'installazione dovrebbe aprirsi automaticamente un browser per la autenticazione e la configurazione della cartella base del sistema di dropbox, al termine bisogna comunque riavviare il sistema per vericare che il sistema di sincronizzazione venga attivato. Se si usa il browser GNOME è necessario installare la estensione topicons plus e il pacchetto libclouldproviders0 per visualizzare l'icona di dropbox nella barra del sistema.

Per il controllo remoto dei sistemi è possibile usare i vari programmi e protocolli: con i sistemi GNU Linux si usa il protocollo specifico RDC con i vari programmi di gestione come KRDC, è possibile usare anche i protocolli di Microsoft per collegarsi a sistemi Windows sempre con il programma KRDC.

## Giochi e Steam

A differenza di quello che si pensa, GNU Linux ha una grandissima varietà di giochi ed è ormai superfluo dire che questi giochi possono funzionare indipendentemente dal desktop usato, questa lista comprende passatempi, come solitari e arcade, oppure giochi più complicati, come gare d'auto e sparatutto, non poteva mancare anche una versione di Mame, il famoso emulatore di ROM di giochi delle vecchie console, ricordando che è illegare giocare con ROM se non si possiede il gioco originale. Una lista completa di tutti i giochi disponibili è disponibile nel sito ufficiale tra cui è necessario citare i migliori: Urban terror, Nequiz, OpenArena, Warzone 2100, Super Tux e Super Tux Kart, FreeCiv e FreeDoom.

Il gioco **Minecraft** è disponibile per GNU LINUX: dal sito ufficiale è possibile scaricare che risulta molto veloce, una volta scaricata la versione basta lanciare il pacchtto-jar auto-installante per avere il gioco disponibile nel proprio sistema. Il pacchetto di Minecraft è disponibile per l'installazione anche da Snapd.

Cedega è stato un progetto per far funzionare giochi e programmi compilati per Microsoft Windows sui sistemi GNU Linux, il progetto era a pagamento acquistabile direttamente dal sito ufficiale, purtroppo da qualche anno il progetto è stato abbandonato e non è più consigliato usare tale programma.

Per i sistemi GNU Linux e Debian è disponibile l'installer del launcher **Steam** scaricabile da snap con il solito comando
```
# snap install steam
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
#rm -r /home/alnao/.local/share/Trash/files/*
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
ufw allow 3389/tcp
```
Come client è possibile utilizzare il programma Remmina, grazie al quale è possibile utilizzare il protocollo RDP per collegarsi ad un server remoto.


# Programmazione in Debian

Il tema della programmazione è il tema principale di scrive questa serie di articoli e saranno presentati vari articoli riguardo a questo scottante tema. In questo non sono esposte le varie teorie sulla programmazione e non è nemmeno una guida ai vari linguaggi di programmazione ma vengono solo presentati strumenti e comandi che un programmatore ha a disposizione per lavorare e iii divertirsi iii (perché dovrebbe essere anche un divertimento), sono presenti semplici esempi di codice nei vari linguaggi di programmazione solo per le verifiche base.

La base della programmazione è la scelta dell'ambiente di sviluppo: anche i più semplici editor testuali come Gedit e Mousepad mettono a disposizione la formattazione automatica dei vari linguaggi di programmazione riconoscendo dal tipo di file il tipo di linguaggio mentre per la compilazione la riga di comando è sempre disponibile, tuttavia è possibile scegliere SDK per velocizzare la fase di sviluppo, per esempio è possibile usare Eclipse, MsCode e Atom a seconda del linguaggio di programmazione usato.

I linguaggi nativi con cui è scritto GNU Linux e la maggior parte dei programmi disponibili sono il C e il C++: la maggior parte delle funzionalità del sistema operativo KernelLinux sono scritte in questi linguaggi ed è possibile trovare molta documentazione a riguardo in internet, tuttavia negli ultimi anni, con la diffusione dei nuovi linguaggi di programmazione, è possibile lavorare in Java, in Perl o in Python con la massima compatibilità delle API del sistema operativo.

Oltre ai tradizionali linguaggi di programmazione è possibile scrivere semplici script per la shell in un linguaggio unico nel suo genere: sh (abbreviazione di Bourne shell e Scripting basH) il più importante linguaggio di scripting interpretato partendo da un file con estensione sh che deve avere le proprietà di esecuzione, è sempre possibile assegnare la proprietà di file eseguibile con il comando chmod:
```
$ chmod a+x file.sh
```
Spesso questi script vengono usati per creare funzioni di installazione, oppure per semplificare la vita ad un utente creando dei veri e propri piccoli programmi per la gestione del sistema (per esempio gli script per l’avvio e l’arresto di un demone o di un singolo programma). I file di script si possono riconoscere semplicemente perché iniziano per con:
```
#!
```
che indica al kernel che lo script è direttamente eseguibile, e lo si fa immediatamente seguire a quel simbolo il nome della shell o del programma da eseguire, per esempio il più usato è sh e tutti gli script iniziano con la prima riga
```
#!/bin/sh
```
In questo tipo di script, oltre a tutti i comandi della shell, è possibile usare le variabili utilizzando il suffisso $ e con i simboli ```$#``` si indicano i parametri arrivati da riga di comando oppure $- indicano le opzioni della shell oppure $$ indicano il pid del processo, per l'elenco completo delle variabili disponibili è possibile cercare nelle varie guide on-line. Per interagire da riga di comando l'utente si può utilizzare il comando read per permettere all'utente di inserire dei valori da tastiera, per esempio un semplice programma:
```
#!/bin/sh
echo "Inserisci una frase \c"
read param
echo param=$param
```
Si rimanda alla documentazione ufficiale per maggiori riguardo al tema dello script sh.


## C

I linguaggi **C** e il **C++** sono i due linguaggi base di tutto il mondo GNU Linux, chiunque voglia scrivere e/o modificare programmi deve conoscere un po' di questi linguaggi.

Il compilatore principale e più usato è g++ (g plus plus), che si trovare anche con il nome di gpp nell'elenco pacchetti. Il compilatore viene sempre installato in automatico nell'installazione del sistema base e non può essere tolto perché serve a moltissime applicazioni e risulta spesso indispensabile per il funzionamento del sistema base. Esistono due metodi principali per eseguire la compilazione di un file C/C++: via terminale oppure utilizzare un ambiente di sviluppo integrato, per poter compilare dei sorgenti è consigliabile installare il pacchetto build-essential infatti, dopo averlo installato, potete tranquillamente scrivere il vostro codice in un editor di testo qualunque, come Gedit, poi salvarlo con estensione .cpp per poi eseguire i comandi:
```
$ g++ nomef.cpp
```
comando che lancia la compilazione del file .cpp e, se la compilazione non da errori, genera un file chiamato a.out che è il nostro eseguibile, per lanciarlo basta eseguire
```
$ ./a.out
```
ed ecco il nostro programma in esecuzione nel terminale.

Essendo C e C++ molto usati in GNU Linux, esistono moltissimi ambienti di sviluppo grafici (IDE o SDK) che permetto all'utente di scrivere progetti, anche di grandi dimensioni, e di compilare senza dover usare la riga di comando, alcuni presentano anche dei correttori automatici, auto-complete (nel caso del C++) ed altre funzionalità molto utili, i più famosi sono Anjuta e BlueFish anche se in realtà è consigliato utilizzare Eclipse o Visual Studio Code con le estensioni dedicate ai linguaggi C/C++.


## Python

Il linguaggio **Python** è uno dei più usati a livello mondiale per la sua semplicità, per esempio WebMin è basato su questo linguaggio e il pacchetto principale è indispensabile ed è già installato. Per installare il pacchetto di enviroment e di sviluppo per eseguire script scritti nel linguaggio python basta lanciare il comando di installazione del pacchetto venv (abbreviazione di vistual-environment):
```
apt-get install python3-venv
```
Si può testare l'ambiente di sviluppo con i comandi che creano un semplice file e lo eseguono:
```
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
```
$ latex miodocumento.tex
```
Il risultato saranno alcuni file (con estensione .aux, .log, .idx) e viene generato anche un file con estensione e formato DVI, questo file può essere letto direttamente tramite il programma di visualizzazione documenti oppure può essere aperto grazie all'interprete di Konqueror, se si desidera invece ottenere un file PostScript, bisogna, dopo aver prodotto il DVI, lanciare il comando
```
$ dvips -t -o miodocumento.ps miodocumento.dvi
```
che permette di ottenere il file PostScript con estensione ps ma bisogna tener presente che è necessario aver installato un interprete PostScript come GhostScript. Per ottenere un documento in formato PDF bisogna processare il file sorgente con il comando
```
$ pdflatex miodocumento.tex
```
Un'altra opzione è quella di usare l'utilissimo programma Kile: il miglior programma per GNU Linux per scrivere documenti in linguaggio LaTeX: consigliato e indispensabile per chi vuole scrivere documenti di grandi dimensioni, da usare anche la possibilità di creare dei progetti in modo tale da dividere i documenti in file più piccoli e più semplici da gestire, notare anche che con la seconda barra in alto si evita di dover andare a scrivere i comandi sulla shell ma basta fare un click con il mouse.

*La versione PDF di questo documento è scritta in LaTeX utilizzando l'editor Kile*


## Notify e Zenity

Se si utilizza un sistema con un gestore desktop è possibile usare dei comandi base per visualizzare dei messaggi tramite notifiche o tramite piccole finestre di dialogo, per esempio per visualizzare una notifica nel desktop basta lanciare il comando
```
$ notify-send 'Titolo' 'Messaggio'
```
e comparirà una notifica nel desktop (ogni desktop manager visualizza la notifica in maniera diversa).

Per quanto riguarda le finestre di dialogo, se si vuole visualizzare una finestra nella shell (e non nel desktop) si può usare il comando whiptail, per esempio:
```
$ whiptail --title "Esempio" --msgbox "Messaggio nella shell" 8 78
```
Mentre per visualizzare finestre di dialogo esiste il programma base xmessage, per esempio:
```
$ xmessage -center "Messaggio da visualizzare"
```
oppure è possibile usare il programma grafico evoluto zenity, permette di visualizzare finestre informative e anche domande, per esempio

La sintassi dei comandi prevede anche la possiblità di personalizzare il messaggio visualizzato e il tipo di finestra:
```
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
apt-get install apache2 mariadb-client mariadb-server php8.2 php8.2-mysql libapache2-mod-php8.2
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
```
$ mysql_secure_installation
```
oppure impostando manualmente le password principali con i comandi dalla console mysql:
```
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
```
$ mysql
> USE test;
> SHOW TABLES;
> CREATE TABLE prova (Nome char(120), Sito char(120));
> INSERT INTO prova (Nome,Sito) VALUES ('Alberto Nao','www.alnao.it');
> SELECT * FROM prova;
```
Con questi comandi è stata creata una piccola tabella nel database test, inserita una riga sulla tabella e l'ultima query visualizza la riga appena inserita, in questo modo sono state eseguite tutte le istruzioni base del demone MySql. Per quanto riguarda l'applicazione-sito PhpMyAdmin, dalla versione 10 di Debian, non è più disponibile nei Repository ufficiali e deve essere scaricato manualmente dal sito ufficiale e posizionato in una cartella per poi lanciare i comandi di configurazione (per la configurazione dei permessi e del apache.conf). In alternativa all'ormai obsoleto PhpMyAdmin è consigliabile usare programmi più evoluti per la gestione del database come **MySql-Workbench**, per installarlo basta usare il repository snap e lanciare il comando:
```
snap install mysql-workbench-community
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
```
echo '<?php phpinfo(); ?> ' > /var/www/html/test.php
```
che risulta disponibile nel server apache. I moduli php sono installabili dal gestiore dei pacchetti e l'elenco dei moduli installati sono consultabili con il comando
```
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


## Node e NPM

Per guardo riguarda la programmazione di applicazioni web **Node.js** e **NPM** hanno cambiato il mondo facilitando il lavoro degli sviluppatori: Node.js è lo strumento che consente agli sviluppatori di eseguire script al di fuori del browser web mentre NPM è il gestore di pacchetti per la gestione dei moduli Nodejs. L'installazione di questi due tool in una distribuzione Debian è facile e prevede l'installazione di due pacchetti
```
apt-get install nodejs npl curl -y
```
Al termine dell'instazzione è sempre necessario impostare i permessi in modo che qualunque utente possa installare moduli con Npm, questi permessi possono essere assegnati con i comandi
```
# mkdir /usr/local/lib/node_modules
# chmod 777 /usr/local/lib/node_modules
# chmod 777 /usr/local/bin/
# node export NODE_OPTIONS=--openssl-legacy-provider
```
Esistono molte guide che descrivono il processo di installazione di nuove versioni da repository esterni che spesso sono più aggiornate ma per un ambiente di sviluppo stabile è consigliato l'uso dei repository ufficiali. Per creare e provare una applicazione basata sulla libreria Angular basta lanciare i comandi:
```
$ npm install -g @angular/cli
$ ng new prova
$ cd prova
$ ng serve
```
Mentre per testare il funzionamento di un piccolo progetto basato sul framework React è possibile creare un progetto con:
```
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
```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
per poi usare GIT per scaricare e inviare file basta lanciare i comandi:
```
git clone https://gitlab.com/name/name.git
cd name
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```
è possibile anche usare il plugin dedicato di Eclipse o Visual Studio Code per la gestione dei repository e la gestione dei commit/push. Inoltre esistono dei piccoli grandi tool grafici come git-cola o gitg, sono sicuramente da provare ed è da notare anche la simpatica descrizione del gitCola in Synaptic. Guide complete di GIT sono disponibili nelle pagine dedicate a JavaEE con Eclipse e Angular.


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

Per quanto riguarda il **MongoDB** l'installazione è un attimo più complicata perché si deve scaricare da un repository proprietario e non da quelli ufficiali di Debian.
```
# apt-get install dirmngr gnupg apt-transport-https software-properties-common ca-certificates
# curl -fsSL https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
# add-apt-repository 'deb https://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main'
# apt-get update
# apt-get install mongodb-org
# systemctl enable mongod --now
# mongo --eval 'db.runCommand({ connectionStatus: 1 })'}
```
poi bisogna subito configurare la rete per permettere l'accesso, il file di configurazione è
```
/etc/mongod.conf
```
nel quale bisogna verificare le configurazioni base di accesso:
```
bindip = 127.0.0.1,indirizziIpCheUsanoMongo
#port = 27017
#auth=true
```
se modificato il file di configurazione, bisogna successivamente riavviare il server con il comando:
```
# systemctl restart mongod
```
Per l'accesso da riga di comandi è disponibile una console, un semplice esempio di utilizzo di questo comando:
```
$ mongo
> use collectiondemo
> db.elenco.insert({nome:"Alberto"})
> db.elenco.find()}
```
Un tool grafico per poter usare mongo è Robomongo che purtroppo non è disponibile nei pacchetti pronti per debiam ma deve essere scaricato un file installer in formato tar.gz dal sito ufficiale
```
https://robomongo.org/download
```
dove è possibile trovare la guida per l'installazione e la configurazione del tool.


## AWS

Per chi usa il cloud **AWS** è indispensabile usare i comandi da riga di comando Command Line interface **AWS-CLI** e **AWS-SAM**, entrambi sono facilmente configurabili in pochi istanti grazie ai tool messi a disposizione direttamente da AWS. L'installazione della CLI è facilissima e basta seguire i passi descritti nella documentazione ufficiale:
```
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ unzip awscliv2.zip
# ./aws/install
$ aws --version
```
In caso di errore di questo ultimo passaggio basta aggiungere al file .bashrc il path /usr/local/bin/ dove viene installato il CLI di AWS. Per configurare il profilo bisogna prima creare un utente di tipo programmatico con la key nel servizio IAM di AWS, poi basta lanciare il comando:
```
$ aws configuration --profile nomeUtente
```
per configurare un profilo, in questi passi saranno richieste le due chiavi dell'utente, la zona di default (come eu-west-1) e il formato delle risposte (come json). Una volta configurato la CLI, per provare il corretto funzionamento e collegamento basta lanciare il comando:
```
$ aws s3 ls
```
per visualizzare l'elenco dei bucket presenti nel servizio S3 nella region impostata di default in fase di configurazione. L'elenco dei comandi specifici della CLI è disponibile negli articoli dedicati al servizio AWS.

Per quanto riguarda la CLI-SAM, la versione CLI dedicata ai servizi serverless, i passi da seguire per l'installazione sono:
```
# wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
# unzip aws-sam-cli-linux-x86\_64.zip -d sam-installation
# ./sam-installation/install
$ sam --version
```
Una guida completa di SAM può essere trovata al sito ufficiale mentre esempi di utilizzo di questo mando si possono trovare nella sezione di AWS del sito alnao.it.

L'installazione di SLS (detta anche serverless-cli) si basa sul sistema di pacakge NPM e bisogna lanciare il comando di installazione del pacchetto dedicato:
```
$ npm install -g serverless
```
e poi bisogna configurare le credenziali programmatiche di accesso con il comando:
```
$ serverless config credentials --provider aws --key <key> --secret <secret> --profile serverless-admin
```
Per verificare che sia tutto configurato correttamente basta lanciare il comando:
```
$ servless
```
oppure:
```
$ sls
```
Alcuni esempi di utilizzo di SLS sono disponibili sulla pagina dedicata al cloud AWS.


### Gestione EC2 con Debian 12

Il cloud AWS mette a disposizione molte **AMI** (immagini) con il sistema operativo Debian12, la lista può essere recuperata in molti siti ufficiali oppure lanciando il comando AWS-CLI:
```
aws ec2 describe-images --owners aws-marketplace --filters "Name=name,Values=*debian-12*" --query 'Images[*].[ImageId,Name,CreationDate]' --output table
aws ec2 describe-images --owners aws-marketplace --filters "Name=name,Values=*lamp*debian-12*" --query 'Images[*].[ImageId,Name,CreationDate]' --output table
aws ec2 describe-images --owners aws-marketplace --filters "Name=name,Values=*node*debian-12*" --query 'Images[*].[ImageId,Name,CreationDate]' --output table
```


Per avviare una istanza con una specifica AMI si può usare il comando:
```
aws ec2 run-instances --image-id ami-XXXXXXXXXXXXXXXXX --instance-type t2.micro --key-name your-key-pair --security-group-ids sg-XXXXXXXXXXXXXXXXX --subnet-id subnet-XXXXXXXXXXXXXXXXX --count 1
# Creare un volume e aggiungerlo all'istanza
aws ec2 create-volume --volume-type gp2 --size 20 --availability-zone us-east-1a
aws ec2 attach-volume --volume-id vol-XXXXXXXXXXXXXXXXX --instance-id i-XXXXXXXXXXXXXXXXX --device /dev/sdf
# Creare una AMI a partire da una istanza
aws ec2 create-image --instance-id i-XXXXXXXXXXXXXXXXX --name "My-Debian-AMI" --description "AMI personalizzata basata su Debian"
# Descrivere una instanza
aws ec2 describe-instance-status --instance-ids i-XXXXXXXXXXXXXXXXX
# Creare una metrica Cloudwatch per il monitoraggio della istanza
aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value=i-XXXXXXXXXXXXXXXXX --start-time $(date -u +"%Y-%m-%dT%H:%M:%SZ" --date "1 hour ago") --end-time $(date -u +"%Y-%m-%dT%H:%M:%SZ") --period 300 --statistics Average
```


Una volta avviata una istanza è possibile collegarsi e configurarla, qui riportati alcuni dei principali comandi:
```
ssh -i /path/to/your-key-pair.pem admin@your-instance-public-ip
sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2 nginx mysql-server php
```


Per potersi collegare ovviamente bisogna ricordarsi di aprire la porta SSH-332
```
# Permettere accesso SSH da qualsiasi IP
aws ec2 authorize-security-group-ingress --group-id sg-XXXXXXXXXXXXXXXXX --protocol tcp --port 22 --cidr 0.0.0.0/0
# Permettere accesso SSH solo da un IP specifico
aws ec2 authorize-security-group-ingress --group-id sg-XXXXXXXXXXXXXXXXX --protocol tcp --port 22 --cidr IP_ADDRESS/32
# Permettere accesso SSH da un range di IP
aws ec2 authorize-security-group-ingress --group-id sg-XXXXXXXXXXXXXXXXX --protocol tcp --port 22 --cidr 192.168.1.0/24
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

Per scaricare e avviare una immagine contenente un demone bisogna identificare la sua immagine e lanciare i comandi:
```
# mkdir ~/dockerPgadmin4
# cd ~/dockerPgadmin4
# docker pull dpage/pgadmin4
# docker run -p 5050:80 -e "PGADMIN_DEFAULT_EMAIL=postgres" -e "PGADMIN_DEFAULT_PASSWORD=password" -d dpage/pgadmin4
# docker-compose up -d
# docker ps
```
in questa sequenza di comandi si è scaricato e attivato il docker PgAdmin4 sul demone locale con la configurazione delle porte, ovviamente bisogna prestare attenzione che non siano già occupate da altri server, in particolare potrebbe essere necessario aprire le porte del firewall locale per le porte con i comandi:
```
# /usr/sbin/iptables -I INPUT 1 -i eth0 -p tcp --dport 5432 -j ACCEPT
# /usr/sbin/service iptables save
# /usr/sbin/iptables --list
```
e sul server PostgreSql è necessario aggiungere la riga
```
listen_addresses = '*'
```
se non presente nel file di configurazione
```
/etc/postgresql/11/main/postgresql.conf
```
e aggiungere la porta
```
host all all 0.0.0.0/0 md5
```
nel file di configurazione
```
/etc/postgresql/11/main/pg_hba.conf
```
e poi riavviare il server con
```
# /etc/init.d/postgresql restart
```
alla fine è possibile collegarsi al PgAdmin4 via web all'indirizzo
```
http://localhost:5050/browser/
```
e nella login bisogna inserire username e password indicati in creazione del docker, per collegarsi al PostgreSql bisogna configurare l'indirizzo IP (il valore localhost non sempre funziona) e selezionando la voce "SSL Compression". Per fermare una esecuzione dell'immagine bisogna lanciare il comando:
```
# docker stop NUMERO
```
dove il NUMERO è il valore ritornato dal comando ps che mostra l'elenco di tutti i docker attivi nel demone.


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
```
docker build -t nome-immagine .
docker images
docker run nome-immagine
```
Mentre è possibile "entrare" direttamente nell'immagine con il comando 
```
docker run -it mia-immagine /bin/bash
```
Il comando **docker exec** serve per eseguire un comando all'interno di un container Docker già in esecuzione . È particolarmente utile quando vuoi interagire con un container attivo senza doverlo fermare o riavviare. La sintassi è:
```
docker exec [OPZIONI] NOME_CONTAINER COMANDO [ARGOMENTI]
```
come per esempio
```
docker exec -it NOME_CONTAINER /bin/bash
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

Per installare **Kubernetes**, detto anche *K8S*, è necessario aver installato il sistema Docker che deve essere funzionante. L'installazione di Kubernets non è semplicissima visto che il demone non è compreso nei repository ufficiali e ci sono molte versioni incompatibili tra loro, è infatti configurabile da sorgente esterna, per esempio usando la versione 1.32 stabile:
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
Per il corretto funzionamento di Kubernets è fondamentale disattivare il sistem swap del sistema operativo con i comandi:
```
# swapoff -a
# sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```
Inoltre è necessario eseguire una serie di configurazioni in alcuni files di sistema:
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
Per avviare e configurare il servizio è necessario lanciar eil comando
```
# kubeadm init --control-plane-endpoint=cirilla --upload-certs --pod-network-cidr=10.244.0.0/16
```
Per inizializzare un cluster e configurare una rete Container Network Interface (CNI):
```
$ mkdir -p $HOME/.kube
$ cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ chown $(id -u):$(id -g) $HOME/.kube/config
$ kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
$ kubectl taint nodes --all node-role.kubernetes.io/control-plane-	
$ kubectl taint nodes --all node.kubernetes.io/disk-pressure-
$ kubectl get nodes	
```

Il cluster è ora pronto. Per aggiungere nodi worker, per esempio è possibile eseguire il comando `kubeadm join` per la gestione dei nodi. Una sequenza utile per l'avvio di un servizio è:
```
# kubectl apply -f deployment.yml 
# kubectl apply -f service.yml
```
Per rimuovere i servizi è possibile usare i comandi:
```
# kubectl delete all -l app=esempio01
# kubectl delete all -l app=esempio01
# kubeadm reset
```
Mentre i log e i dettagli possono essere recuperati con i comandi:
```
# kubectl get all -l app=esempio01

# cat /var/log/syslog | grep kubelet
# kubectl get nodes	
# kubectl get pods
# kubectl get events -A
# kubectl get events --sort-by='.lastTimestamp'
# kubectl describe node | grep -i capacity -A 5
# kubectl logs -f deployment/esempio01

# journalctl -u kubelet -f
```

Un esempio di avvio di un server Nginx su un nodo dedicato:
```
# kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml
# kubectl get nodes
# kubectl create deployment nginx --image=nginx
# kubectl expose deployment nginx --type=NodePort --port=80
# kubectl get deployment nginx
# kubectl get service nginx
# curl http://<node-ip>:<node-port>
	
# kubectl delete deployment nginx
# kubectl delete all -l app=nginx
# kubectl get all -l app=nginx
```


## Android

Esistono molti metodi per eseguire la cattura di un sistema esterno Andoid, è possibile persino prendere il controllo, il sistema più famoso è **scrcpy** che permette di catturare il display di un altro dispositivo. Si può installare tramite il sistema snap con il comando:
```
snap install scrcpy
```
Oppure installare il pacchetto direttamente da GitHub:
```
sudo apt install ffmpeg libsdl2-2.0-0 adb wget gcc git pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libswresample-dev libusb-1.0-0 libusb-1.0-0-dev
git clone https://github.com/Genymobile/scrcpy
cd scrcpy
./install_release.sh
scrcpy --version
adb devices
```
Se il disposibito è correttamente collegato e configurato l'ultimo comando visualizza il dispositivo disponibile, per avviare il sistema di condivisione basta lanciare il programma o il comando
```
scrcpy
```
Prima di eseguire questo processo bisogna ricordarsi che è necessario attivare la modalitatà *developer* sul sistema android cliccando sette volte sul "build number" nelle impostazioni del dispositivo ("about device" in alcune versione) e successivamente bisogna bisogna attivare anche l'opzione "USB debugging", senza questa configurazione non il programma adb non visualizza il dispositivo e non è possibile condividere le videate dei dispositivi.


Tramite il programma è possibile condividere la camera, registrare video/audio e altre operazioni, si riportano alcuni esempi:
```
scrcpy --video-source=camera
scrcpy --audio-source=mic # or --audio-source=output
scrcpy --video-source=camera --no-audio # audio isn't forwarded
scrcpy --record=file.mp4
scrcpy --no-audio --record=file.mp4 # to only record the video
scrcpy --no-video --audio-codec=raw --record=file.wav # to only record the audio
scrcpy --new-display=1920x1080 --start-app=org.videolan.vlc
```
Si rimanda alla documentazione ufficiale per i dettagli di tutti i comandi e i dettagli.


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
```
$ echo $PATH
```
e si visualizza l'elenco delle cartelle in sequenza con il separatore due-punti, per esempio:
```
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```
Se si vuole aggiungere all'elenco una cartella basta lanciare il comando
```
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
```
$ mmv 'aaa*bbb?' 'pinco#1pallino#2'
```
e con questo comando vengono rinominati tutti i file contenenti le stringe "aaa" e "bbb" e terminanti con un carattere e verrà dato il nome "pinco" + ciò che trova l'asterisco + "pallino" + ciò che trova il punto di domanda. Un esempio più semplice:
```
$ mmv '*.ps' '#1.eps'
```
per rinominare tutti i file da .ps a .eps, per maggiori informazioni e una guida completa potete vedere il comando man di mmv. Il metodo più semplice rimangono i programmi di gestione file del desktop che tutti quanti usano mmv ma basta un semplice click per eseguire il comando, è possibile provare in Dolphin, Konqueror, Total Commander o qualsiasi altro filemanager presente nel sistema Debian.


## Manipolazione video

Per la manipolazione di file video si possono usare diversi comandi, il principale è **ffmeg** che permette di manipolare file video da riga di comando con una sintassi molto complessa, si rimanda al sito ufficiale per tutti i dettagli e l'elenco di tutte le funzionalità messe a disposizione da questo tool.
Le principali operazioni disponibili sono:
- Ruotare un video (per esempio se ripreso in verticale):
  ```		
  ffmpeg -i input.mp4 -vf "rotate=45*(PI/180)" output.mp4
  ```
- Tagliare un video da un punto ad un altro indicando il minutaggio di partenza e di fine taglio:
  ```
  ffmpeg -i input.mkv -ss 00:00:00 -t 00:02:30 -acodec copy -vcodec copy output.mkv
  ```
- Unire più files in uno unico file, con questo modo i video sorgenti possono avere dimensioni e risoluzioni diverse, convertendo tutto in MP4 poi in TS per poterli unire nonostante le dimensioni diverse:
	```
	ffmpeg -i file1.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts fileInt1.ts
	ffmpeg -i file2.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts fileInt2.ts
	ffmpeg -i file3.ogv -vcodec libx264 "file3.mp4"
	ffmpeg -i file3.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts fileInt3.ts
	cat fileIntermediate3.ts  fileIntermediate1.ts fileIntermediate2.ts > output.ts
	ffmpeg -i "concat:fileInt1.ts|fileInt2.ts|fileInt3.ts" -c copy -bsf:a aac_adtstoasc mergedVideo.mp4
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
```
$ rm
$ rmdir
```
la cancellazione di file o delle cartelle è definitiva e il file non viene spostato in nessun cestino temporaneo quindi bisogna sempre prestare attenzione quando si usano questi comandi. Bisogna sempre tenere conto che il cestino dei Desktop può lasciare della sporcizia nei sistemi, cioè il cestino potrebbe non essere svuotato oppure capita che alcuni desktop non eseguano la cancellazione definitiva ma postano i file in un altra cartella nascosta nonostante il lancio della funzione di svuota il cestino, questa sporcizia può essere lasciata in una cartella specifica che potete trovare al path:
```
/home/nomeutente/.local/share/Trash/file/
```
che dovrebbe essere controllata e svuotata periodicamente con il comando
```
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
```
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
```
$ wondershaper -a nomeInterfaccia -d limiteDowlonad -u limiteUpload
```
per esempio:
```
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



# AlNao.it
Nessun contenuto in questo repository è stato creato con IA o automaticamente, tutto il codice è stato scritto con molta pazienza da Alberto Nao. Se il codice è stato preso da altri siti/progetti è sempre indicata la fonte. Per maggior informazioni visitare il sito [alnao.it](https://www.alnao.it/).




## License
Public projects 
<a href="https://it.wikipedia.org/wiki/GNU_General_Public_License"  valign="middle"><img src="https://img.shields.io/badge/License-GNU-blue" style="height:22px;"  valign="middle"></a> 
*Free Software!*

E' garantito il permesso di copiare, distribuire e/o modificare questo documento in base ai termini della GNU Free Documentation License, Versione 1.2 o ogni versione successiva pubblicata dalla Free Software Foundation. Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation.

