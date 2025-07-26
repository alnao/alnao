  # Css & Bootstrap notes 

*writted by AlNao*


# Indice
- [Css3](#Introduzione-a-Css3)
  - [Cosa è il Responsive web design](#Il-Responsive-web-design)
  - [Come gestire dispositivi mobili con Media queries e viewport](#Come-gestire-dispositivi-mobili-con-Media-queries-e-viewport)
  - [Come creare una pagina response](#Come-creare-una-pagina-response)
  - [Come gestire il layout con il box modeling](#Come-gestire-il-layout-con-il-box-modeling)
  - [Come gestire pseudo-classi e pseudo-elementi](#Come-gestire-pseudo-classi-e-pseudo-elementi)
  - [Come gestire il posizionamento con sticky e float](#Come-gestire-il-posizionamento-con-sticky-e-float)
  - [Come gestire le dimensioni e le posizioni degli oggetti](#Come-gestire-le-dimensioni-e-le-posizioni-degli-oggetti)
  - [Come creare Liste e DataList con CSS](#Come-creare-Liste-e-DataList-con-CSS)
  - [Come gestire inserimento di valori in form](#Come-gestire-inserimento-di-valori-in-form)
  - [Come gestire trasformazioni e transazioni con animazioni](#Come-gestire-trasformazioni-e-transazioni-con-animazioni)
  - [Come personalizzare fogli di stile con le variabili](#Come-personalizzare-fogli-di-stile-con-le-variabili)
- [Tool e librerie](#Tool-e-librerie)
  - [Bootstrap](#Bootstrap) 
    - [Pagina base con Bootstrap](#Pagina-base-con-Bootstrap)
  - [boxicons](#boxicons)
- [Esempi di Css3](#Esempi-di-css3)
  - [Tooltip](#Tooltip)
  - [Loader](#Loader)
  - [Datepicker](#Datepicker)
  - ModalDate
  - Login with button 
  - Portafoglio: tabella di contenuti dinamica e responsive
  - Focus
  - Libro            
  - Luci e arcobaleno
  - [Broadcast](#Broadcast)
  - [WebSocket-Chat](#WebSocket-Chat)


# Introduzione a Css3

In questa pagina sono raggruppati tutti gli articoli riguardo a Css3 e Bootstrap. 

Non si tratta di un manuale o di documentazione ma di un elenco di esempi di codice o mini-guide, si rimanda alla documentazione ufficiale di Css3 e la documentazione ufficiale di Bootstrap per maggiori dettagli e approfondimenti.

Per la lettura di questi articoli è necessario avere una base completa di HTML mentre, tranne in qualche raro caso, non è neccessirio avere basi di programmazione Javascript anche se è indispensabile e inevitabile per la gestione dei casi più complessi.

Lo sviluppo di stili e siti è possibile con qualsiasi editor di testo anche se è consigliato l'uso di ambiente di sviluppo (IDE) come Visual Studio Code di Microsoft, ATOM ed Eclipse.

## Il Responsive web design

CSS ResponsiveCon responsive web design (a volte abbreviato con la sigla RWD) si descrive la tecnologia di sviluppo web per la creazione di siti web in grado di auto-adattarsi al dispositivo con il quale vengono caricati i contenuti del sito, lo scopo finale è quello di avere un unico sito web che si "disegna" a seconda del dispositivo dell'utente senza dover aver versioni diverse a seconda del dispositivo. Basta pensare al grande problema dei dispositivo mobili e alle varie tecnologie esistenti: senza responsive bisogna creare diverse versioni dello stesso codice: iPhone, ipad, android, tablet andoid, MsWindows phone e MSWindows tablet, senza contare altri dispositivi come le smart-telelevision.
 
Responsive vuole imporre uno standard di sviluppo bastato interamente su HTML5 e CSS3 con poco aiuto di Javascript e della libreria Jquery, il vantaggio di questo standard è che, ad oggi, tutti i browser sono compatibili con questi standard e ormai è diventato uno standard universamentemente usato.
 
La filosofia base di responsive è quella di usare stili diversi a seconda del dispositivo, quindi il browser caricherà CSS diversi a seconda delle caratteristiche che esso ottiene dalla finestra del programma in esecuzione (o dalla app), questa filosofia obbliga il programmatore ad ideare una griglia formata a blocchi che si spostano e si posizionano a seconda dello spazio a disposizione nel monitor (o schermo) dell'utente: ovviamente un pc ha uno schermo più largo dove ci stanno più blocchi rispetto ad un cellulare dove a fatica viene visualizzato un blocco solo, in tutta questo ovviamente testi, immagini e qualsiasi altro componente devono essere necessariamente flessibili e con larghezza fissa. Tipicamente queste strutture sono posizionati a delle determinate grandezze 320 pixel, 600 pixel, 1024 pixel oppure oltre i 1024 pixel per essere associate a rispettivamente cellulari, tablet, schermo piccolo (come i notebook) e  schermo grande.
 
Attraverso i CSS si possono studiare vari modi per modificare il posizionamento degli elementi e ordinarli a seconda delle proprie esigenze, questo perché i siti Responsive richiedono che gli elementi siano dimensionati nei fogli di stile tramite percentuali (oppure em) e non con unità assolute come pixel o punti. La complessità della tecnologia Responsive è il trovare il giusto compromesso tra contenuti e esigenze dei dispositivi mobile, perché con Responsive bisogna sempre fare un compromesso tra le possibili grandi dimensioni di un contenuto (come un testo molto lungo, immagini di grandi dimensioni o video) e i dispositivi mobili dove lo spazio a disposizione è limitato e non sempre è possibile visualizzare tutto una sola schermata.
 
Per realizzare un sito con Responsive ed avere un buon risultato bisogna prima di tutto aver presente quale risultato si vuole ottenere tenendo presente dei limiti e delle caratteristiche delle tecnologie che andremo ad usare, usando HTML e CSS si possono superare i problemi grazie a Responsive e ai breackpoint. Un breackpoint è un punto della pagina, dalla quale parte una linea orrizontale ideale lungo la quale verranno “posizionati” gli oggetti con i CSS e le queries di responsive.
 
Un semplice esempio di codice con un breackpoint è:
```
<!DOCTYPE html><html>
  <head>
    <title>www.alnao.it</title>
    <style type="text/css">
    .breackpoint { background: blue;}
    @media screen and (min-width: 480px) {
      .breackpoint { background: green; }
    }
    @media screen and (min-width: 768px) {
      .breackpoint { background: yellow; }
    }
    @media screen and (min-width: 1024px) {
      .breackpoint { background: red; }
    }
    </style>
  </head>
  <body>
    <span>Contenuto precedente</span>
    <div class="breackpoint">Responsive web design e i suoi breackpoint</div>
    <span>Contenuto successivo</span>
  </body>
</html>
```
In questo semplice esempio la classe breackpoint definisce un punto "di rottura", grazie alle media queries introdotte nel prossimo articolo è possibile definire un comportamento grafico diverso a seconda della larghezza del dispositivo, ipotizzando contenuti precedenti e successivi a questo elemento, questo diventa un punto di rottura indicato tecnicamente come "breackpoint".

## Come gestire dispositivi mobili con Media queries e viewport

Il comportamento di tutti i browser è adattare in maniera automatica le dimensioni della area di visualizzazione per posizionare al meglio gli elemento di una pagina web, tuttavia se questo avviene in uno schermo piccolo come quello di smartphone, il testo e le immagini sono talmente piccoli che necessitano di essere zooomate con tap o azioni simili. Usando una semplice pagina di esempio, il browser di un dispositivo mobile può visualizzare la pagina in due modi differenti:

Tale comportamento è dovuto alla importante differenza di risoluzione degli schermi, su uno smartphone può arrivare a 320 px mentre su monitor desktop più essere anche 2000 px. Nel momento in cui si voglia creare un sito adattivo per tutti i dispositivi bisogna evitare effetti grafici indesiderati e studiare il comportamento del viewport. Tecnicamente si può modificare il comportamento di default, spesso indesiderato, inserendo un tag meta nel codice HTML della pagina:
```
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```
per la gestione del viewport, aggiungendo questo tag alle pagine, i browser dei visitatori non avranno il comportamento indesiderato dello zoom. Maggiori dettagli si possono trovare nel sito ufficiale mozilla.

Le media queries sono una tecnica introdotta con CSS3 per la gestione dei contenuti se questo è visualizzato da dispositivi con differenti dimensioni, prima di questa tecnica era necessario caricare diverse elementi a seconda della dimensione dello schermo del visitatore. La sintassi base è l'uso della parola chiave @media seguita dall'indicazione di quale proprietà selezionare, all'interno delle parentesi graffe si indicano le classi css che devono essere applicate solo ai visitatori che soddisfano la regola:
```
@media screen and (min-width: 480px) {
.example { background: green; }
}
@media screen and (min-width: 768px) {
.example { background: yellow; }
}
@media screen and (min-width: 1024px) {
.example { background: red; }
}
```
in questo semplice esempio gli oggetti di classe example avranno sfondo verde nei dispositivi piccoli, giallo nei dispositivi medi e rossi per i dispositivi di grandi dimensioni. E' possibile usare le media queries anche nel tag link per importare o meno css specifici:
```
<link rel="stylesheet" media="screen and (color)" href="colore.css" />
```
I possibili media messi a disposizione da tutti i browser sono:

- all: il CSS si applica a tutti i dispositivi di visualizzazione
- screen: schermo di computer
- print: pagina stampata
- projection: presentazioni e proiezioni
- speech: dispositivi con sintesi vocale
- braille: supporti braille
- embossed: stampanti braille
- handheld: dispositivi mobili con schermo piccolo
- tty: dispositivi a carattere fisso
- tv: visualizzazione su schermi televisivi

E' possibile inoltre combinare le condizioni e sommarle anche se è una tecnica poso usata in quanto le media queries, come tutte le proprietà CSS, hanno il principio dell'ereditarietà e della sequenzialità: viene sempre applicata l'ultima caratteristica impostata in ordine di caricamento.
```
BODY{ 
  background: yellow;
}
@media screen and (min-width: 400px) and (max-width: 1024px) { 
  BODY{ 
   background: red;
  }
}
```
A chi non ha mai usato le media queries si lascia come esempio la possibilità di caricare una pagina con media queries con un browser di un desktop molto largo e poi ridimensionare la finestra, si noterà che le classi cambiano senza il ri-caricamento dell'intera pagina ma le classi sono applicate "run-time". Questa tecnica è usata spesso anche per mostrare e nascondere elementi a seconda della larghezza della pagina, per esempio nei dispositivi piccoli è possibile nascondere un elemento con:
```
@media only screen and (max-width: 600px) {
  div.example {
    display: none;
  }
}
```
Una guida completa e dettagliata delle Media Queries è disponibile nel sito ufficiale w3schools.

## Come creare una pagina response

Usando il Response Designe con il sistema a Box scegliendo la tecnica delle media-queries, per crare una pagina di esempio blocchi con il classico schema:

- versione internet: più righe con il primo box largo tutta la pagina, nelle successive righe i blocchi sono affiancati dove possibile
- versione tablet: i blocchi rimangono affiancati
- versione mobile: i blocchi sono uno sotto l'altro senza nessun affiancamento

Un esempio di codice che implementa questa logica:
```
<!DOCTYPE html>
<html>
 <head>
  <style>
   DIV { box-sizing: border-box;}
   body{ margin:0; padding:0; background-color:lightgreen; }
   .gliglia{margin: 0px auto; background-color:lightblue; 
     padding: 25px;}
   .grid{float: left; padding-left: 25px;position: relative;
     width: 100%;width: 100%;}
   .elemento{height:100px; background-color:gold;}
   .riga{margin-left: -25px;}
   @media only screen and (min-width: 480px) and (max-width: 599px) {
    .elem1{width: 100%;}
    .elem2{width: 100%;}
    .elem4{width: 100%;}
   }
   @media only screen and (min-width: 600px) and (max-width: 1024px) {
    .elem1{width: 100%;}
    .elem2{width: 100%;}
    .elem4{width: 50%;}
   }
   @media only screen and (min-width: 1025px) {
    .gliglia{width: 1040px;}
    .elem1{width: 100%;}
    .elem2{width: 50%;}
    .elem4{width: 25%;}
   }
   .riga:before, .riga:after{content: " "; display: table;}
   .riga:after, .gliglia:after{ clear: both;}
  </style>
 </head>
 <body>
  <div class="gliglia">
    <div class="riga">
      <div class="grid elem1">
        <p class="elemento">1 int, 1 tablet, 1 mobile</p>
      </div>
    </div>
    <div class="riga">
      <div class="grid elem2">
        <p class="elemento">1/2 int, 1 tablet, 1 mobile</p>
      </div>
      <div class="grid elem2">
        <p class="elemento">1/2 int, 1 tablet, 1 mobile</p>
      </div>
    </div>
    <div class="riga">
      <div class="grid elem4">
        <p class="elemento">1/4 int, 1/2 tablet, 1 mobile</p>
      </div>
      <div class="grid elem4">
        <p class="elemento">1/4 int, 1/2 tablet, 1 mobile</p>
      </div>
      <div class="grid elem4">
        <p class="elemento">1/4 int, 1/2 tablet, 1 mobile</p>
      </div>
      <div class="grid elem4">
        <p class="elemento">1/4 int, 1/2 tablet, 1 mobile</p>
      </div>
    </div>
  </div>
  <div class="riga"> <div class="grid elem1">footer</div></div>
 </body>
</html>
```
In questo esempio non è stato usato il tag <TABLE>, impossibile da usare con le media-queries, quindi sono usati dei tag <DIV> ai quali è stata impostata la una caratteristiche molto importante:
```
DIV { box-sizing: border-box;}
```
per poi poter usare le percentuali sulle larghezze: storicamente un elemento HTML (non solo i tag DIV) hanno una larghezza ma di default la larghezza non comprende i margini che vengono calcolati a parte, con questa proprietà la larghezza e l'altezza dei bordi viene compresa nella definizione nei CSS e si evitano sorprese: per esempio con due elementi al 50% e un po' di bordo, senza questa proprietà il secondo elementi andrebbe a capo in quanto il bordo del primo elemento porterebbe la larghezza ad almeno il 51% e non ci sarebbe abbastanza spazio, per maggiori dettagli si rimanda alla pagina W3C.

Successivamente sono stati impostati margini del BODY per eviatre di perdere spazio:
```
BODY{ margin:0; padding:0; background-color:lightgreen; }
```
La classe griglia vuole essere solo un contenitore di righe, in poche parole sarebbe il <table> della nostra struttura, non sarebbe necessario ma è sempre buona norma mettere un div contenitore per poter aggiungere impostazioni che, altrimenti, sarebbero complicate da mettere nei vari elementi della struttura, in questo esempio abbiamo definito un colore e un padding, la larghezza non è indispensabile perché se non specificata il tag DIV si "prende" tutto lo spazio che trova. La classe riga è la definizione delle caratteristiche "orrizzontali" del gruppo di elementi, si può pensare come un <TR> ma con una caratteristica diversa: questo non contiene un numero fisso di elementi. La classe grid è la più interessante dell'esempio perchè definisce che ogni elemento della griglia è fluttuante e indica che la posizione deve essere relativa (di solito è il default ma meglio ridefinirlo per evitare brutte sorprese), questo è semplicemente il contenuto di ogni elemento della griglia e in questo esempio abbiamo definito un aspetto grafico: altezza e colore per poter identificare ogni box, da non confondere il contenuto con l'elemento fluttuante: sempre meglio fare due tag per evitare conflitti tra le proprietà e i tag.

Le successive classi sono definite con le media queries e cioè pezzi di css condizionati ad alcune caratteristiche, in questo caso ci sono definiti tre blocchi con dove sono definite le stesse classi ma con valori percentuali diverse, il primo per il mobile (minimo 480 e massimo 599), il secondo per tablet (minimo 600 massimo 1024) e il terzo per i browser internet (con monitor con più di 1024 pixel):
```
@media only screen and (min-width: 480px) and (max-width: 599px) {
...
}
@media only screen and (min-width: 600px) and (max-width: 1024px) {
...
}
@media only screen and (min-width: 1025px) {
.gliglia{width: 1040px;}
...
}
```
Le ultime due righe dello stile sono le più complicate da spiegare e un occhio esperto potrebbe essere infastidito, perché sono la definizione di due condizioni sulle righe, indispensabili per evitare i problemi con gli elementi fluttuanti, la prima riga aggiunge prima e dopo un elemento di classe riga uno spazio e indica che i figli di elemento devono essere disposti a tabella, per maggiori dettagli vi consiglio di studiare la pagina W3C:
```
.riga:before, .riga:after{content: " "; display: table;}
.riga:after, .gliglia:after{ clear: both;}
```
La seconda classe invece è fondamentale, perche impone che alla fine di ogni riga (e alla fine della griglia) non ci siano altri elementi fluttuanti, con il valore both si indica al browser che non ci deve essere altro a sinistra e a destra dell'elemento quindi il browser sarà costretto a posiziona gli elementi successivi sotto, questa proprietà è spesso mal vista ma ormai indispensabile per chi vuole sviluppare uno stile responsivo, consiglio comunque la pagina W3C.

## Come gestire il layout con il box modeling

In fase di studio del layout di un sito bisogna considerare la struttura a blocchi dei siti responsive: non è possibile incastrare le componenti senza allineamenti e bisogna evitare di creare strutture a tetris, come in immagine, che potrebbero anche essere impossibili con tecnologie HTML e non possono essere facilmente adattate ai dispositivi mobili.

Durante lo studio e la progettazione di un sito responsive bisogna sempre tenere conto che gli oggetti dovranno essere visualizzati anche sui dispositivi mobili come gli smartphone e monitor molto grandi come i monitor molto grandi quindi nel disegno di un sito non si può pensare di inserire un oggetto statico ma bisogna sempre pensare alla sua rappresentazione grafica sui diversi dispositivi, allo stesso tempo bisogna cercare di non limitare troppo il “canale” internet, trovare un compromesso è possibile usando il box-modeling e lo studio degli elementi flessibili, in questo articolo sarà introdotto il primo concetto mentre il secondo sarà introdotto in futuri articoli.

Il concetto di box-modeling è uno dei punti più importanti dei fogli di stile CSS e ogni designer deve conoscere molto bene questi concetti: fin dalla prima versione dell'HTML e dei CSS ogni programmatore è sempre afflitto da dove e come posizionare gli oggetti HTML rispetto agli altri, infatti per box-modeling si intende definire le posizioni e le distanze tra i vari oggetti usando le varie proprietà di altezza, larghezza, margine, bordi e padding. Fin dalla versione 2 di CSS si è definito uno standard sui box e non è variata molto nella versione 3: ogni elemento ha un margine, un bordo, un padding, larghezza e altezza che vengono definite con proprietà specifiche:

- le proprietà di larghezza e altezza (width e height) imposta le dimensioni di elementi esclusi padding, margini e bordi che vengono sommati a posteriori. Per rendere CSS più flessibile possibile è possibile modificare l'impostazione della somma delle larghezze usando la proprietà box-sizing che può assumere due valori:
- content-box: il valore di larghezza fa riferimento all'area del contenuto (valore di default)
- border-box: il valore di larghezza fa riferimento al box nella sua interezza, comprendendo anche il padding e il bordo.

Quindi, per esempio:
```
#divProva{
  width:100px; 
  padding:2px; 
  border: 1px solid black; 
  box-sizing:border-box;
}
```
la larghezza di 100 pixel comprende anche bordi e padding.

Una delle proprietà più interessanti fin alla prima versione di CSS è la proprietà inline che gestisce la grande differenza che di default si trova tra i tag DIV e SPAN, SPAN infatti ha come valore display mentre per il tag DIV (e molti altri) il valore di default è block. Semplificando i comportamenti della proprietà: un elemento SPAN (o qualsiasi elemento con inline:display) si prenda meno spazio possibile mentre un elemento DIV (o qualsiasi elemento con inline:block) si prende tutto lo spazio disponibile sulla riga a meno che non sia indicata una larghezza con la proprietà width.

Un semplice esempio del diverso comportamento tra queste proprietà e tra i tag DIV vs SPAN:
```
<span style="background-color:red;">primo span</span>
<span style="background-color:blue;color:white;">secondo span</span>
```
mentre usando il tag DIV (o il tag P) il risultato è:
```
<div style="background-color:red;">primo div</div>
<div style="background-color:blue;color:white;">secondo div</div>
```
Il valore inline ha un grande difetto: non interpreta le proprietà larghezza (width) e altezza (height) ma le assegna in base al contenuto dell'oggetto: se abbiamo un link il cui contenuto occupa 100px in larghezza, anche impostando una larghezza maggiore, lo spazio occupato dall'elemento con inline sarà sempre di 100 pixel, questo problema può risultare scomodo negli elementi grafici dove le aree visibili o cliccabili sono maggiori di quella effettivamente occupata dal testo ma può invece essere sfruttata per evitare che certi tag aumentino le dimensioni senza controllo.

Gli elementi di tipo blocco hanno sempre la proprietà display con valore block. Sono, ad esempio, i paragrafi e tutti i tag di heading (h1, h2, h3, …), questi elementi assumono le dimensioni impostate nel CSS se specificate e, salvo utilizzo della proprietà float, non accettano altri oggetti sulla stessa riga prendendo tutto lo spazio a disposizione. Proprio per questo motivo il tag SPAN è poco usato e la proprietà inline è usata molto di rado, infatti per affiancare più elementi (come blocchi) vengono usati gli elementi fluttuanti che possono gestire le larghezze in maniera nativa.

Con le proprietà flexbox sono state introdotte alcune nuove caratteristiche per creare strutture di layout non lineari come previsto normalmente da CSS, senza i quali al programmatore rimane solo l'uso della proprietà float. Questa è stata pensata per rendere semplice la gestione di elementi interni ad un elemento contenitore e per risolvere le varie problematiche legate alla centratura degli elementi rispetto agli assi verticali e orizzontali. Per usare queste proprietà bisogna tenere conto di due aspetti costruttivi:

- un elemento contenitore che contiene gli elementi flessibili indicato con la proprietà ```display:flex```
- gli elementi flessibili dove non bisogna dedicare nessuna proprietà specifica.
- All'elemento padre si deve poi aggiungere la proprietà addizionale per indicare l'allineamento verticale con la proprietà ```align-items: center;```
- Agli elementi figli è possibile poi aggiungere delle caratteristiche ulteriore: modificare l'allineamento dello specifico elemento con la proprietà ```align-self``` e modificare l'ordine di visualizzazione con la proprietà ```order```

Un esempio pratico è:
```
<div style="display:flex;align-items: center;">
  <div style="background-color:red;">rosso</div>
  <div style="background-color:yellow;">giallo<br /> a capo</div>
  <div style="background-color:green;text-align:center;">verde</div>
  <div style="background-color:gold;order:-2;">oro con ordine</div>
  <div style="background-color:lightblue;align-self:flex-start;">azzurro</div>
<div>
```
 
## Come gestire pseudo classi e pseudo elementi

La gestione di CSS è limitata all'uso di classi assegnati a uno o più elementi di una pagina, le pseudo-classi permettono di modificare il comportamento a seconda dello stato di un elemento, la sintassi prevede l'uso di creare una classe dove oltre al nome si indica, con due-punti, il nome della pseudo-classe. Uno dei semplici utilizzi di questa tecnica è il cambiare colore di un link quando il mouse passa sopra, questo comportamento può essere regolato con l'uso della pseuso classe "hover"
```
a { color: blue; }
a:hover { color: #FF00FF; }
```
L'elenco completo di tutte le classi è disponibile al sito di mozilla  ma bisogna ricordare che non tutte le classi sono disponibili in tutti i browser.

I più comuni e più usati sono:

- ```:empty``` usato per modificare l'aspetto di elementi vuoti
- ```:focus :disabled :enabled :checked :invalid :read-only``` usati per determinare lo stato di un input e modificarne l'aspetto e il comportamento
- ```:first-child :last-child :last-of-type``` usato per modificare l'aspetto del primo o dell'ultimo figlio di un elemento
- ```:is() :not()``` usati per modificare l'aspetto di elementi con caratteristiche specifiche condizionali
- ```:nth-child() :nth-last-child() :nth-last-col() :nth-last-of-type() :nth-of-type()``` usato per modificare l'aspetto degli elementi di un gruppo
- ```:only-child``` usato per modificare l'aspetto di un oggetto se unico figlio del suo contenitore
- ```:root``` usato per modificare l'aspetto dell'oggetto principale, spesso usato per identificare il tag HTML radice di un documento

La documentazione ufficiale è disponibile, come sempre, nel sito della w3schools. In particolare il gruppo dei nth è usato per gestire i gruppo di figli come righe di una tabella, elementi di una lista o semplici elementi dentro ad un altro elemento, un uso semplice è andare posizionali, per esempio volendo colorare il quarto elemento:
```
tr:nth-child(4) td {background-color: red}
```
questa tecnica è usata per distinguere poi elementi alla posizione pari da quelli alla posizione dispari con:
```
tr:nth-child(even) tr:nth-child(2n) 
tr:nth-child(odd) tr:nth-child(2n+1)
```
Ed è possibile selezionare un elemento partendo dal fondo , per esempio per colorare di giallo il penultimo elemento di un gruppo
```
tr:nth-last-child(2) td { background-color: yellow}
```
La pseudo-classe target consente di selezionare un elemento della pagina che corrisponde ad un indirizzo: data una pagina con delle ancore al proprio interno, la pseudo-classe E:target ci consente di assegnare uno stile all'elemento di destinazione nel momento in cui è selezionato. Un esempio per comprenderne il funzionamento partendo dal codice dove al click di un link viene evidenziato in rosso il blocco sottostante:
```
<style>
  div:target {color:Red;}
</style>
<ul>
  <li><a href="#div1">Div1</a></li>
  <li><a href="#div2">Div2</a></li>
  <li><a href="#div3">Div3</a></li>
  <li><a href="#div4">Div4</a></li>
</ul>
<div id="div1"><p>Testo1 ....</p></div>
<div id="div2"><p>Testo2 ...</p></div>
<div id="div3"><p>Testo3...</p></div>
<div id="div4"><p>Testo4 .... </p></div>
```
Con le pseudo-classi logiche è possibile creare delle mini-condizioni con gli operatori is e not, per esempio è possibile usare not in combinazione con altri pseudo-classi, per esempio:
```
input:not(:disabled){color: black;}
```
per modificare l'aspetto di elemento che non hanno determinate caratteristiche. Ma è possibile usare la stessa tecnica per creare logiche sulle classi, cioè selezionare elementi che non hanno determinate classi:
```
div{color:white;}
div:not(.white) {color: black}
```
Gli pseudo-elementi son un'altra tecnica che prevede l'uso di parole chiave per modificare l'aspetto di parti di un elemento, rispetto alle pseudo classi che modificano tutto l'elemento, da CSS3 gli pseudo-elemento si differenziano dalle pseudo-classi perché si usano due caratteri di due punti :: invece che uno solo, per mantenere la retro-compatibilità con il codice esistente, i browser sono tenuti a supportare entrambe le sintassi, la più comuni sono:
```
::before
::after
::first-letter
::first-line
```
Gli pseudo-elementi sono supportati, salvo qualche dettaglio di ::before e ::after, da tutti i principali browser. Le prime due permettono di creare elementi prima o dopo un elemento, per esempio:
```
#element:before {
  content: "";
  display: block;
  width: 100px;
  height: 100px;
}
...
<div id="element">ciao</div>
```
Questo semplice esempio, prima del div, aggiunge un elemento vuoto ma di larghezza e altezza come indicato nella classe, bisogna però sempre ricordarsi di mettere la proprietà content anche se vuota in quanto omettendola alcuni browser non creano nessun elemento. Inoltre bisogna sempre ricordare che l'elemento inserito con questa tecnica è un elemento in-line per dare un volume all'elemento ma talvolta è necessario definirlo esplicitamente come un elemento a livello di blocco (con display:block). L'uso di before e after è anche condizionato dal fatto che, il contenuto che viene inserito attraverso i CSS, sarà un contenuto figlio in relazione all'elemento e ma verrà posizionato prima oppure dopo di qualsiasi altro contenuto in quell'elemento e mentre si sviluppa con questi pseudo-elementi bisogna considerare che non sono "reali" perché non fanno parte del documento DOM, quindi non bisogna mai utilizzare gli pseudo-elementi per generare contenuti dinamicamente o che siano fondamentali per l’usabilità o l’accessibilità delle pagine perché rischiano di sparire e non tutti i browser si comportano bene con questi elementi. Personalmente gli evito se posso.

# Come gestire il posizionamento con sticky e float

La principale proprietà per posizionare un elemento in una posizione fissa è sticky, questa è studiata per fissare elementi in una determinata posizione che rimarrà fissa anche in caso di scroll dall'utente e ridimensionamento.

Il principale uso di questa tecnica è la creazione di barre fisse in alto ad una pagina o in posizione finale come footer. La documentazione ufficiale è ricca di esempi che si possono riassumere con una sola classe:
```
div.sticky {
  position: -webkit-sticky; /* Safari */
  position: sticky;
  top: 0;
}
```
Un elemento con questo tipo di classe è una alternativa al posizionamento relative e fixed ma dipende solo dalla posizione della scrollbar, esso si posiziona relativamente al contenitore e viene fissato allo schermo, purtroppo Internet Explorer, Edge 15 e vecchie versioni dei browser non supportano questa proprietà mentre il browser Safari richiede l'aggiunta di una proprietù specifca con il prefisso webkit.

Fin dalla prima versione di CSS, la proprietà float è stata una delle più usate per la creazione di layout e parti di pagine, nonostante gli tanti sforzi non esiste un vero standard in quanto con l'uso di questa proprietà visto che è possibile posizionare elementi nella pagina non in maniera "sequenziale" come vorrebbe lo standard HTML, d'ora in avanti in questo articolo parleremo di elementi fluttuanti come qualsiasi tag con la proprietà float impostata con qualsiasi valore, per ogni dubbio rimando sempre alla guida W3C.

La prima caratteristica degli elementi fluttuanti è che sono impostati come block-level, in poche parole questo significa che sono elementi blocco indipendente da quello che gli sta attorno e che hanno una propria altezza e una propria altezza che viene calcolata automaticamente dal contenuto, la caratteristica principale è che il contenitore dell'elemento non si adatta a questa altezza automaticamente, cioè l'elemento verde (il contenitore) non si auto-adatta alle dimensioni dell'elemento in giallo (che è quello fluttuante contenuto), l'elemento blu (che è il successivo) si posizione dove trova posto infatti si posiziona a sinistra dell'elemento fluttuante, questo perché (come dice la parola stessa) il fluttuare crea spazi che i browser provano a riempire, per evitare questo si deve usare la proprietà clear che vedremo in seguito. Uno dei problemi più grandi degli elemento fluttuanti è che si auto-adattano in larghezza quindi può capitare di perderne il controllo, conviene sempre impostare la larghezza dell'elemento fluttuante oppure, ancora meglio, impostare la larghezza del contenuto dell'elemento, poi il fluttuante si adatta alla larghezza.

Il problema più grave che affligge grafici e programmatori web è che gli elementi fluttuanti, tendono ad uscire dal contenitore e che gli elementi successivi possono posizionarsi in posizioni non volute, per risolvere questo problema negli anni sono state create molti ipotesi e filosofie, la più comune prima dello standard CSS3 era creare dei tag div che fungessero da "interruzione di float" detta anche Clearfix, tecnica descritta nella documentazione ufficiale come un elemento invisibile che divide gli elementi evitando sovrapposizione indesiderate. Per fare questo bastava creare una classe:
```
<div style=”clear:right”> </div>
```
con questo stile si indica che questo div non deve avere elementi fluttuanti a destra e a sinistra, quindi qualsiasi elemento successivo viene disegnato come se nulla ci fosse sopra. Questo ha però un grande difetto: inserire nelle pagine HTML un tag vuoto in tutti i punti, quindi il controllo degli elementi fluttuanti non è fatto via CSS ma via HTML, cosa chiaramente non positiva per i grafici. Da notare che questo div (essendo vuoto e fluttuante) non è visibile e non crea danni alla struttura grafica della pagina. Negli anni poi ci sono molti tentativi di sistemare la cosa in maniera più elegante ma con CSS3 il problema è stato risolto definitivamente con una tecnica evoluta: l'uso della proprietà after: in c'è un tag con un figlio fluttuante basta aggiungere la caratteristica
```
.clearfix::after {
  content: "";
  clear: both;
  display: table;
}
```
per indicare che qualsiasi tag successivo al contenitore deve ignorare l'elemento fluttuante e si posiziona dopo come se "nulla fosse", da notare che abbiamo dovuto inserire uno spazio dopo per creare un elemento vuoto e mostrare la disposizione tabellare. Il nostro esempio quindi diventa:

## Come gestire le dimensioni e le posizioni degli oggetti

La gestione delle dimensioni degli oggetti è sempre stata un argomento molto delicato in HTML e in CSS, in particolare nelle pagine pensate per essere responsive dove gli oggetti si ridimensionino in base al dispositivo e allo spazio a disposizione. Oltre alle proprietà base di larghezza (width) e altezza (height), dalla terza versione di CSS sono a disposizione quattro proprietà:

- min-width larghezza minima dell’elemento
- min-height altezza minima dell’elemento
- max-width larghezza minima dell’elemento
- max-height altezza massima dell’elemento

Tutti e quattro i valori assumono valori in pixel, em, percentuale o qualunque altra unità di misura. Queste permettono di non impostare una valore fisso ma di impostare un range, i browser cercano più spazio possibile ma, se lo spazio non è sufficiente, riducono in maniera automatica le dimensioni. Un'altra tecnica per impostare le dimensioni in maniera dinamica è l'uso delle funzioni max (e le altri simili), per esempio:
```
width: max(50%,100px);
```
permette di impostare una larghezza della metà (50%) rispetto al contenitore a meno che 100 pizel siano un valore maggiore. Altro metodo molto interessante è clamp che permette di definire tre parametri: un minimo, un predefinito e un massimo, il browser poi calcolerà quale valore usare, alcuni esempi di sistemi statici o combinati con altre funzioni di CSS:
```
/* Static values */
width: clamp(200px, 40%, 400px);
width: clamp(20rem, 30vw, 70rem);
width: clamp(10vw, 20em, 100vw);
/* Calculated values */
width: clamp(min(10vw, 20rem), 300px, max(90vw, 55rem));
width: clamp(100px, calc(30% / 2rem + 10px), 900px);
```
si rimanda alla documentazione ufficiale per maggiori dettagli ed altri esempi.

Un'altra proprietà molto usata è ```inline-size``` che permette di definire le dimensioni di un elemento nella inline direction, si differenza dai classici width e height perché questa (come block-size) si devono usare per gli oggetti nella modalità inline e block, anche in questo caso si rimanda alla documentazione ufficiale per maggiori dettagli.

Le proprietà CSS gestiscono le misura assolute come inches (in), points (pt), millimetri (mm), picas (pc) ma offrono anche la la possibilità di utilizzare unità relative al contenitore (em), all'elemento (rem) e alla viewport del dispositivo (vw/vh). Provando queste unità di misura in un semplice esempio:
```
<div>
  <p>ciao em</p>
</div>
<p>ciao rem</p>
  <label>ciao vw</label>
```
```
html{
  font-size: 20px;
}
div{
  font-size: 30px;
}
div > p{
  font-size: 2em;
}
p{
  font-size: 2rem;
}
label{
  font-size: 10vw;
}
```
Il paragrafo contenuto nel div avrà un font-size finale equivalente a 2 volte il font-size definito nel div. Il secondo paragrafo avrà una grandezza finale di 40px: 2 volte la dimensione definita nell'elemento. La label sarà pari al 10% della larghezza della finestra, modificando le dimensioni del browser vedremo infatti l'altezza del carattere variare coerentemente.

Oltre alle dimensioni di un oggetto bisogna sempre ricordare che è necessario controllarne il posizionamento rispetto al contenitore (detto anche parent), la documentazione ufficiale espone tute le possiblità di posizionamento:

- static: il valore di default che posiziona gli elementi in sequenza con il "normal flow". Non è possibile modificare la posizione nemmeno con l'uso di top, left, right e bottom.
- relative: l'oggetto viene posizionato rispetto se fosse statico con in aggiunta un offset basato sui valori di top, left, right e bottom.
- absolute: l'oggetto viene posizionato rispetto al contenitore con un offset basato su top, left, right e bottom ma creando un layer aggiuntivo gestibile con la proprietà z-index
- fixed: come il precedente ma ignora fratelli con la stessa proprietà (figli dello stesso genitore)
- sticky: tecnica descritta nell'articolo "Come gestire il posizionamento con sticky e float"

Un altra proprietà molto interessante e importante con le recenti versioni di CSS è inset che permette di creare oggetti posizionati non linearmnete senza l'uso di top, left, right e bottom e evitano l'abuso dei margini, in particolare è possibile creare oggetti annidati con pochissime proprietà, si rimanda alla documentazione ufficiale per maggiori dettagli.

Volendo combinare queste tecniche per creare un footer di una pagina, impostando un elemento figlio del tag body con la proprietà fixed e impostando il valore di bottom a zero così da posizionare l'elemento in fondo alla pagina, la documentazione ufficiale presenta un bellissimo esempio dove il footer non è fluttuante (cioè non ha un float impostato):
```
<style>
.footer {
  position: fixed;
  left: 0;
  bottom: 0;
  width: 100%;
  background-color: red;
  color: white;
  text-align: center;
}
</style>
...
<div class="footer">
  <p>Footer</p>
</div>
```

## Come creare Liste e DataList con CSS

In HTML esistono due tipi di liste: quelle puntate, dette unordered list definite con il tag UL, e quelle numerate, dette ordered list definite con il tag OL. All'interno dei tag lista è possibile inserire gli elementi come list-item definite con il tag LI che può essere usato solo all'interno dei tag di tipo lista. Questi sono diventati uno standard per la visualizzazione di lista di elementi e stanno sostituendo le strutture tabellari definite con il tag TABLE e tutti gli altri tag per la visualizzazione di elementi in formato tabellare.

Nella documentazione ufficiale, esiste una sezione specifica per la personalizzazione delle liste e gli item presenti. La più semplice personalizzazione è il tipo di marker con la possibilità anche di impostare una immagine:
```
ul.circle { list-style-type: circle; }
ul.square { list-style-type: square; }
ol.roman { list-style-type: upper-roman; }
ol.alpha { list-style-type: lower-alpha; }
ul.image { list-style-image: url('sqpurple.gif'); }
```
Per la posizione di marker è sono possibili due valori: interno ed esterno
```
ul.a { list-style-position: outside; }
ul.b { list-style-position: inside; }
```
Nella programmazione recente è molto usata la tecnica di usare i tag lista senza elementi grafici rimuovendo il marker e azzerando tutti i margini:
```
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}
```
Questa tecnica è molto usata per la gestione di menu e qualsiasi lista comprese anche le visualizzazioni nelle app:

Concetto diverso è l'uso del DataList, nonostante il nome assonante riguarda un argomento diverso: il tag data list offrono la possibilità di definire un elenco di valori presentati come possibili valori di un input-text ma, a differenza del tag select, permette all'utente di inserire un valore non compreso nella lista:

La sintassi HTML è particolare in quanto il tag input permette una proprietà list:
```
<label for="browser">Choose your browser from the list:</label>
<input list="browsers" name="browser" id="browser">
<datalist id="browsers">
  <option value="Edge">
  <option value="Firefox">
  <option value="Chrome">
  <option value="Opera">
  <option value="Safari">
</datalist>
```
La documentazione ufficiale descrive una sola personalizzazione grafica: sola visibilità può essere gestita tramite CSS, tutti gli altri aspetti grafici sono gestiti dai browser, speriamo in futuro venga evoluta e vengano introdotte tecniche per una maggior personalizzazione.

## Come gestire inserimento di valori in form

Fin dalla prima versione di HTML, i programmatori hanno avuto a disposizione alcuni tag per permettere agli utenti di inserire dati o di effettuare scelte e/o selezioni: si fa sempre riferimento ai tag INPUT e SELECT per costruire pagine dinamiche con l'inserimento dei dati da inviare ad un server grazie al tag FORM e alle potenzialità del protocollo HTTP.

Con le varie versioni di HTML e CSS si sono aggiunti molte nuove possibilità di utilizzo dei tag input e alcuni nuovi attributi sono stati inseriti con la versione tre di CSS. Fin dalle prime versioni di HTML e di CSS sono disponibili:

- type il tipo di input, per esempio "text" o "checkbox"
- name il nome dell'elemento all'interno del form con l'eventuale nome del parametro inviato al server
- value il valore iniziale del campo
- readonly il campo è di sola lettura
- disabled il campo è disabilitato
- size la grandezza dell'input in caratteri
- maxlength la lunghezza massima in caratteri

Mentre sono state aggiunte diverse nuove proprietà, dalla versione 5 di HTML e dalla versione 3 di CSS sono disponibili nuove proprietà per i tag INPUT:

- autocomplete indica al browser di visualizzare o meno all'utente la finestrella per l'autocomplete, se non specificato vale di default "on" quindi viene mostrato, valore alternativo autocomplete="off"
- autofocus indica al browser di attivare l'input al caricamento della pagina tramite il focus
- form è possibile posizionare l'input fuori dal tag form e indicare tramite questa proprietà a quale/quali form questo tag appartiene
- formaction nei tag input di tipo submit indica una action alternativa a quella definita nel tag form
- formenctype nei tag input di tipo submit indica una ctype alternativa a quella definita nel tag form, per esesempio con il valore "multipart/form-data"
- formmethod nei tag input di tipo submit indica una method alternativa a quella definita nel tag form, per esempio formmethod="post"
- formnovalidate nei tag input di tupo submit indica se non eseguire le validazioni "client" al submit
- formtarget nei tag input di tipo submit indica un target alternativo a quella definita nel tag form, per esempio formtarget="_blank"
- height and width definisce le dimensioni di un input di tipo image
- list se si definisce un dominio di valori tramite il tag datalist è possibile agganciare la lista ad un input di tipo text
- min and max nei tag input di tipo number e date è possibile definire un massimo ed un minimo valore
- multiple nei tag input di tipo file è possibile indicare se si possono selezionare più file
- pattern (regexp) nei tag input di tipo text indica una regola di inserimento espressa in regexp, per esempio pattern="[A-Za-z]{3}"
- placeholder indica un test da visualizzare di "sfondo" quando il campo è vuoto, non fa parte del valore dell'input
- required indica se, in fase di validazione, l'input deve essere valorizzato
- step nei tag input di tipo number, indica il modulo di valorizzazione, per esempio se step="3" i valori possibili sono: -3, 0, 3, 6, ...

In particolare form e input sono evoluti in modo che il browser possa validare in maniera semplice i dati inseriti dall'utente senza la necessità di usare Javascript, per esempio per il tag form sono disponibili queste nuove proprietà: 

- autocomplete indica se tutti i tag all'interno del form ereditano la proprietà autocomplete, di default vale "on" quindi gli autocomplete sono attivati
- novalidate indica al browser di non eseguire la validazione "client" del form al momento del submit

Un esempio di validazione e gestione degli errori di un tag input è:
```
<input type="text" id="username" name="username"
  placeholder="Inserire l'username" 
  oninvalid="this.setCustomValidity('Username non valido')"
  oninput="setCustomValidity('')"
  autocomplete="off" 
  autofocus
  required
/>
```
In questo esempio dove è stato definito anche la proprietà oninvalid per visualizzare un messaggio di errore personalizzato quando la validazione va in errore. Per personalizzare l'aspetto grafico con CSS dei form e degli input ci sono moltissime possibilità, esistono infatti molti siti specializzati che mettono a disposizione esempi come freefrontend mentre il sito ufficiale W3C mette a disposizione alcuni esempi di input e form.

## Come gestire trasformazioni e transazioni con animazioni

Le trasformazioni e le transazioni sono delle tecniche introdotte con la terza versione di CSS che permettono di creare dinamicità in un pagine che risultano statici. Queste tecniche sono state studiate per poter permettere la definizione di animazioni senza l’ausilio di alcun linguaggio di scripting e senza conoscenze evolute di programmazione.

Secondo lo standard esistono tre tipi di tecniche che possono applicate:

- trasformazioni: permette di modificare l'aspetto grafico lasciando invariata la sua posizione e le dimensioni originali
- transazioni: permette di modificare l'aspetto grafico modificando anche posizione e/o le dimensioni
- animazioni: permette di creare trasformazioni e transazioni che variano nel tempo con dei frame-set temporali

Le trasformazioni permettono di modificare l'aspetto di un elemento, il caso d'uso più semplice è quello di modificare l'aspetto di un testo rendendolo maiuscolo:
```
p.uppercase {
  text-transform: uppercase;
}
```
Ma il linguaggio CSS prevede una proprietà specifica "transform" che permette di ruotare, deformare e scalare elementi indicando il valore di rapporto di rotazione o dimensionamento:
```
div.a {
  transform: rotate(20deg);
}
div.b {
  transform: skewY(20deg);
}
div.c {
  transform: scaleY(1.5);
}
```
Inoltre è previsto una ulteriore proprietà che permette di definire il comportamento della trasformazione indicando se si tratta di un tipo piatto, 3d o natuale.
```
transform-style: flat|preserve-3d|initial|inherit;
```
Da notare che quasi tutti i broweser accettano questo tipo di trasformazione ma a volte si comportano in maniera diversa infatti sono usate le stesse unità di misura, si rimanda alla documentazione ufficiale per tutti i dettagli di questa proprietà.  

Le transazioni sono una evoluzioni delle trasformazioni in quanto permettono anche di definire modifica alle posizioni e alle dimensioni degli oggetti, la sintassi prevista è:
```
transition: property duration timing-function delay|initial|inherit;
```
per esempio volendo modififare in maniera dinamica la larghezza di un elemento al passaggio del mouse di definiscono due classi:
```
div.trans {
  width: 100px;
  transition: width 2s;
}
  div.trans:hover {
  width: 300px;
}
```
Un altro esempio molto usato è la transazione grafica di un input al momento del focus sull'elemento: evidenziare un elemento input quando l'utente lo seleziona:
```
input[type="text"] {
  width: 100px;
  -webkit-transition: width .35s ease-in-out;
  transition: width .35s ease-in-out;
}
input[type="text"]:focus {
  width: 250px;
}
```
Anche in questo caso è consigliato consultare la documentazione ufficiale per tutti i dettagli.

Le animazioni son un tema sempre molto scottante in quando abbelliscono molto un sito ma lo rendono anche molto pensate ed è sempre difficile trovare un equilibrio. Il linguaggio permette di definire transazioni di elementi con la proprietà che definisce il comportamento principale:
```
animation: name duration timing-function delay iteration-count direction fill-mode play-state;
```
che ha molti valori necessari nella definizione:

- animation-name: specifica il nome dei keyframe
- animation-duration: specifica quanti secondi deve durare la animazione
- animation-timing-function: specifica la velocità di esecuzione
- animation-delay: specifica quando delay/ritardo deve esserci
- animation-iteration-count: specifica quante volte la animazione deve essere eseguita
- animation-direction: specifica la direzione
- animation-fill-mode: specifica il comportamento dell'elemento prima e dopo l'animazione
- animation-play-state: specifica se l'animazione è attiva o meno

L'esempio più semplice è muovere un elmento in maniera continua definendo la sua animazione i keyframe di inizio e partenza:
```
div.anima {
  animation: mymove 5s infinite;
}
@keyframes mymove {
  from {left: 0px;}
  to {left: 200px;}
}
```
Anche in questo si rimanda sempre alla documentazione ufficiale per tutti i dettagli, questa tecnica permette di creare casi d'uso più complesso come il carosello dei loghi disponibile in questo sito (in alto a destra) realizzabile combinando le animazioni con piccolo Javascript:
```
div.logo {
  width: 100px;
  height: 100px;
  background: red;
  position: relative;
  animation: fading 10s infinite;
}
@keyframes fading{
  0%{opacity:0}
  50%{opacity:1}
  100%{opacity:0}
}
```
Una cosa interssante e molto usata è usare la tecnica delle animazioni per creare effetti che creano ombre e sfondi al testo, per esempio per creare un effetto Neon colorato ad un titolo:
```
.glow {
  font-size: 80px;
  color: #fff;
  text-align: center;
  animation: glow 1s ease-in-out infinite alternate;
}
@-webkit-keyframes glow {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;
  }
  to {
    text-shadow: 0 0 20px #fff, 0 0 30px #ff4da6, 0 0 40px #ff4da6, 0 0 50px #ff4da6, 0 0 60px #ff4da6, 0 0 70px #ff4da6, 0 0 80px #ff4da6;
  }
}
```
Anche in questo caso si rimanda alla documentazione ufficiale per tutti i dettagli.

## Come personalizzare fogli di stile con le variabili

SaaS è il più famoso pre-processore per il linguaggio CSS, permette di definire temi e variabili all'interno di un progetto web in modo da rendere il CSS più semplice da sviluppare. Purtroppo il file originale non può essere usato direttamente nei siti ma deve essere tradotto in files CSS per essere usato dalle pagine HTML, a volte la fase di traduzione è impropriamente detta compilazione. Questa tecnica viene usata moltissimo nei siti di grandi dimensioni nei quali sono presenti tanti stili e classi che, inevitabilmente, usano gli stessi valori. L'esempio più classico è la definizione di un colore specifico e l'uso di questo colore non solo nei testi ma anche in bordi e altri componenti grafici del sito.

Per usare questa tecnica è necessario usare un "compilatore", il più comune pacchetto è disponibile tramite NPM e installabile con il semplice comando
```
npm install -g sass
```
E poi sarà possibile usare il traduttore con il comando
```
sass --watch style.scss style.css
```
Si rimanda alla documentazione ufficiale per tutti i dettagli riguardo ai comandi disponibili e alla sintassi prevista. Inoltre sono consigliati alcuni plugin per gli IDE, questi eseguono la traduzione in tempo reale sollevando il programmatore del click per la compilazione, il più comune è "Live Sass Compiler" per Visual Studio Code, maggiori dettagli sono disponibili al sito ufficiale.

Un semplice esempio è la definizione di alcune variabili:
```
/* Define standard variables and values for website */
$bgcolor: lightblue;
$textcolor: darkblue;
$fontsize: 18px;
/* Use the variables */
body {
  background-color: $bgcolor;
  color: $textcolor;
  font-size: $fontsize;
}
```
E dopo la conversione, il foglio di stile CSS generato è:
```
body {
  background-color: lightblue;
  color: darkblue;
  font-size: 18px;
}
```
Questa tecnica permette anche di generare stili annidati, vietati dal linguaggio CSS ma permessi da Sass, per esempio è possibile annidare i tag:
```
.content{
  background-color: $bgcolor;
  color: $textcolor;
  a{
    color: $textcolorSecondary;
  }
}
```
E il risultato della traduzione è:
```
.content {
  background-color: lightblue;
  color: darkblue;
}
.content a {
  color: yellow;
}
```
Questa tecnica è studiata per la gestione di siti di grandi dimensioni che necessitano di tanti files ed è stato previsto anche il comando di importazione di file. La sintassi è molto simile a quella usata per css, per esempio il comando di import:
```
@import 'button';
```
funziona se il file si chiama
```
_button.scss
```
Si rimanda alla documentazione ufficiale per tutti i dettagli e le regole per esempio è possibile usare import per file css, fogli esterni, url ed è possibile usare le media queries per gestire gli import di file, per esempio:
```
@import "theme.css";
@import "http://fonts.googleapis.com/css?family=Droid+Sans";
@import url(theme);
@import "landscape" screen and (orientation: landscape);
```
Si rimanda alla documentazione ufficiale anche per i dettagli riguardi ad altre funzionalità previste come la gestione delle funzioni e delle condizioni.

I moduli CSS permettono di dividere i CSS nei siti single page, l'obbiettivo è proprio evitare di aver un unico foglio di stile per un unico progetto single-page compilato ed evitare di avere namespace (o altre tecniche custom) con files divisi in più file ma importati sempre a livello globale. Usando la libreria React, se i componenti sono divisi in file jsx diversi ed se i componente importano un css specifico, questo comunque alla fine risulterà importato a livello globale creando possibili contrasti ed errori se presenti classi con lo stesso nome. La soluzione al problema è usare i moduli che la libreria e il compilatore mette a disposizione. Il primo passo è creare un file css con il nome xxxx.module.css dove il suffisso "module" nel nome file è obbligatorio. Per esempio il file sottocomponente.module.css potrebbe essere:
```
.sfondoRosso { background-color:red}
```
Nei file che hanno la necessità di usare questa classe devono importare il file module con il tipo:
```
import css from './xxxx.module.css';
```
e poi usare la classe con la sintassi
```
<div className={css.sfondoRosso}> ... </div>
```
Da questo semplice esempio si capisce subito che il riferimento alla classe non è puro ma la libreria "compila" il file Css creandone un nome univoco aggiungendo un hash per ogni classe, in questo modo se in un progetto sono presenti più classi con lo stesso nome ma su file diversi questi vengono "compilati" con nomi diversi grazie ad un hash univoco. La documentazione ufficiale di React mostra un classico esempio simile.

Attivare la libreria Sass in un progetto React è molto più semplice di quanto si possa sembrare: è come se avessero pensato tutta la libreria in modo che possa funzionare perfettamente in simbiosi. Prima di tutto bisogna installare la libreria nel progetto:
```
npm i sass
```
Dopo di che basta creare un file con estensione "scss", in questo file si può giocare a piacimento, per esempio definire una variabile base e poi usarla nel file
```
$primaryColor: white;
...
.sidebar-brand-icon {
color: $primaryColor;
}
```
Nel file principale del progetto index.js (nel file javascript e non nella pagina html) è necessario importare il modulo scss con la semplice riga:
```
import './index.scss';
```
Ovviamente questo è un esempio che semplifica molto l'uso di SASS nelle librerie javascript, si rimanda alla documentazione ufficiale per tutti i dettagli.


# Tool e librerie 

## Bootstrap
Per la pagina iniziale di Bootstrap 5 vedere la [documentazione ufficiale](https://getbootstrap.com/docs/5.0/getting-started/introduction/).

```
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Hello, world!</title>
  </head>
  <body>
    <h1>Hello, world!</h1>

    <!-- Optional JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

  </body>
</html>
```
Oppure scaricare dalla pagina [download](https://getbootstrap.com/docs/5.0/getting-started/download/).


- Per i progetti **NPM**, vedere il repository ufficiale
  ```
  https://github.com/twbs/bootstrap-npm-starter
  ```
  che a me non funziona *ma non importa*.


- Per i progetti **Angular**:
  - Comandi per la creazione del progetto
    ```
    npm install -g @angular/cli
    ng new progetto
    cd progetto
    ng generate component component-name
    ng serve
    ```
  - Comandi per l'import della libreria
    ```
    npm install bootstrap --save
    ```
  - Se ```css``` aggiungere nel file css generale
    ```
    @import "../node_modules/bootstrap/dist/css/bootstrap.min.css";
    ```
  - Se ```scss``` aggiungere 
    ```
    @import "bootstrap/scss/bootstrap";
    ```
  - Nel componente ```app.component.html``` aggiungere il codice di prova
    ```
    <h1>Titolo </h1>
    <div class="text-success">Verde</div>
    <div class="btn btn-info">Bottone</div>
    ```
- Per i progetti **React**:
  - Comandi per la creazione del progetto
    ```
    npx create-react-app react-app
    cd react-app
    npm start
    ```
  - Se ```css``` installazione di bootstrap
    ```
    npm install bootstrap
    import "bootstrap/dist/css/bootstrap.min.css";
    ```
    Esempio di codice:
    ```
    import './App.css';
    import "bootstrap/dist/css/bootstrap.min.css";
    function App() {
      return (
        <div className="App">
          <h1>Titolo </h1>
          <div class="text-success">Verde</div>
          <div class="btn btn-info">Bottone</div>
        </div>
      );
    }
    export default App;
    ```
  - Se ```scss``` installazione di bootstrap
    ```
    npm i node-sass
    ```
    Esempio di codice  nel file ```style.scss```:
    ```
    @import “../node_modules/bootstrap/scss/bootstrap.scss”;
    ```

## Pagina base con Bootstrap
Per creare una pagina base si può usare il [template ufficiale](https://getbootstrap.com/docs/5.2/getting-started/introduction/)
```
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
  </head>
  <body>
    <h1>Hello, world!</h1>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  </body>
</html>
```
e si può personalizzare la pagina con diversi stili e componenti, per esempio:
```
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Dati Finanziari</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <style>
        :root {
            --bs-primary: #2F4858;
            --bs-primary-rgb: 47,72,88;
        }
        .btn-primary {
            --bs-btn-bg: #2F4858;
            --bs-btn-border-color: #2F4858;
            --bs-btn-hover-bg: #243847;
            --bs-btn-hover-border-color: #243847;
            --bs-btn-active-bg: #1a2936;
            --bs-btn-active-border-color: #1a2936;
        }
        .navbar, .card-header {
            background-color: var(--bs-primary) !important;
            color: white;
        }
        #loadingOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .spinner-border {
            width: 3rem;
            height: 3rem;
        }
        .datepicker {
            z-index: 1060 !important;
        }
    </style>
</head>
<body>
    <div id="loadingOverlay">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Caricamento...</span>
        </div>
    </div>

    <nav class="navbar navbar-dark bg-primary mb-4">
        <div class="container">
            <span class="navbar-brand mb-0 h1">Gestione Dati Finanziari</span>
        </div>
    </nav>

    <div class="container">
      <!-- Sezione 1: Form di inserimento -->
      <div class="card mb-4" id="formSection">
          <div class="card-header">
              <h5 class="mb-0">Form di Inserimento</h5>
          </div>
          <div class="card-body">
              <form id="insertForm">
                  <table class="table table-borderless">
                      <tr>
                          <td><label for="importo">Importo</label></td>
                          <td><input type="number" class="form-control" id="importo" required></td>
                          <td><label for="intestazionePratica">Intestazione pratica</label></td>
                          <td><input type="text" class="form-control" id="intestazionePratica"></td>
                      </tr>
                      <tr>
                          <td><label for="causale">Causale</label></td>
                          <td colspan="3"><input type="text" class="form-control" id="causale"></td>
                      </tr>
                      <tr>
                          <td><label for="tipoTassoCreditore">Tipo tasso</label></td>
                          <td>
                              <select id="tipoTassoCreditore" class="form-select" required>
                                  <option value="Fisso">Fisso</option>
                                  <option value="Variabile">Variabile</option>
                                  <option value="BCE">BCE</option>
                              </select>
                          </td>
                          <td><label for="tasso">Tasso (%)</label></td>
                          <td><input type="number" class="form-control" id="tasso" step="0.01" required></td>
                      </tr>
                  </table>
                  <button type="submit" class="btn btn-primary">Calcola</button>
              </form>
          </div>
      </div>

      <!-- Sezione 2: Risultati calcolo -->
      <div class="card mb-4" id="resultSection" style="display: none;">
          <div class="card-header">
              <h5 class="mb-0">Risultati Calcolo</h5>
          </div>
          <div class="card-body">
              <button id="backToForm" class="btn btn-primary mb-3">Torna al Form</button>
              <div id="inputSummary" class="mb-4"></div>
              <div class="table-responsive">
                  <table id="resultTable" class="table table-striped table-hover">
                      <thead>
                          <tr>
                              <th>Incrementale</th>
                              <th>Data da</th>
                              <th>Data a</th>
                              <th>Giorni periodo</th>
                              <th>Capitale</th>    
                              <th>Tasso</th>
                              <th>Interessi</th>
                              <th>Saldo</th>
                          </tr>
                      </thead>
                      <tbody></tbody>
                  </table>
              </div>
          </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.it.min.js"></script>
    <script>
        window.addEventListener('load', fetchData);
        async function fetchData() {
            try {
                // TODO: chiamata API
            } catch (error) {
                console.log(error);
            } finally {
                document.getElementById('loadingOverlay').style.display = 'none';
            }
        }
        document.getElementById('tipoTassoCreditore').addEventListener('change', function() {
            const tasso = document.getElementById('tasso');
            this.value === 'BCE' ? tasso.value="3" : tasso.value="";
            tasso.disabled = (this.value === 'BCE');
        });
        document.getElementById('insertForm').addEventListener('submit', function(e) {
            e.preventDefault();
            calcola();
        });
        function calcola(){
          const importo = parseFloat(document.getElementById('importo').value);
          const tasso = parseFloat(document.getElementById('tasso').value) / 100;
          const data=[{'incrementale':1, 'dataDa':'01/01/2024', 'dataA':'31/12/2024', 'giorniPeriodo':365, 
            'capitale':importo, 'tasso':tasso*100,'interessi':importo*tasso , 'saldo':importo*tasso+importo}]
          //TODO
          document.getElementById('formSection').style.display = 'none';
          document.getElementById('resultSection').style.display = 'block';
          renderResultTable(data);
        }
        function renderResultTable(data) {
            const tbody = document.querySelector('#resultTable tbody');
            tbody.innerHTML = '';
            data.forEach(row => {
                const tr = document.createElement('tr');
                ['incrementale', 'dataDa', 'dataA', 'giorniPeriodo', 'capitale','tasso', 'interessi', 'saldo'].forEach(key => {
                    const td = document.createElement('td');
                    td.textContent = row[key];
                    tr.appendChild(td);
                });
                tbody.appendChild(tr);
            });
        }
        document.getElementById('backToForm').addEventListener('click', function() {
            document.getElementById('formSection').style.display = 'block';
            document.getElementById('resultSection').style.display = 'none';
        });

    </script>
  </body>
</html>
```

## Boxicons
Boxicons è una libreria open source di icone web che offre oltre 1500 icone vettoriali di alta qualità, disponibili in stile regular, solid e outline. 
Per utilizzarla basta includere il tag nel head del HTML 
```
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
```
e poi inserire le icone con tag come 
```
<i class='bx bx-home'></i>
```
oppure
```
<i class='bx bxs-heart'></i>.
```
Per esempio, per inserire un gruppo social:
```
.social-icons a{
  display:inline-flex;
  padding:10px;
  border: 2px solid #999999;
  border-radius:8px;
  font-size:24px;
  color:#aaaaaa;
  text-decoration:none;
  margin:0 8px;
}

<div class="social-icons">
  <a href="#"><i class='bx bxl-google' ></i></a>
  <a href="#"><i class='bx bxl-facebook' ></i></a>
  <a href="#"><i class='bx bxl-github' ></i></a>
  <a href="#"><i class='bx bxl-linkedin' ></i></a>
</div>
```

E' possibile unire la libreria BoxIcons con boostrap usando entrambi i CSS messi a disposizione delle librerie, per esempio:
```
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        .icon-card {
            transition: transform 0.2s;
        }
        .icon-card:hover {
            transform: translateY(-5px);
        }
        .bx {
            font-size: 2.5rem;
            color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="display-4">Boxicons Demo</h1>
            <p class="lead text-muted">Una raccolta di icone moderne per il tuo sito web</p>
        </div>
        <div class="row g-4">
            <div class="col-sm-6 col-md-4">
                <div class="icon-card card h-100 shadow-sm text-center p-4">
                    <div class="card-body">
                        <i class="bx bxs-heart mb-3"></i>
                        <p class="card-text text-muted">bxs-heart</p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="icon-card card h-100 shadow-sm text-center p-4">
                    <div class="card-body">
                        <i class="bx bxs-star mb-3"></i>
                        <p class="card-text text-muted">bxs-star</p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="icon-card card h-100 shadow-sm text-center p-4">
                    <div class="card-body">
                        <i class="bx bxs-message mb-3"></i>
                        <p class="card-text text-muted">bxs-message</p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="icon-card card h-100 shadow-sm text-center p-4">
                    <div class="card-body">
                        <i class="bx bxs-user mb-3"></i>
                        <p class="card-text text-muted">bxs-user</p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="icon-card card h-100 shadow-sm text-center p-4">
                    <div class="card-body">
                        <i class="bx bxs-bell mb-3"></i>
                        <p class="card-text text-muted">bxs-bell</p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4">
                <div class="icon-card card h-100 shadow-sm text-center p-4">
                    <div class="card-body">
                        <i class="bx bxs-bookmark mb-3"></i>
                        <p class="card-text text-muted">bxs-bookmark</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```


# Esempi di Css3


## Tooltip
```
<!DOCTYPE html>
<html>
  <head>
    <style>
    .tooltip {
      position: relative;
      display: inline-block;
      border-bottom: 1px dotted black;
    }
    .tooltip .tooltiptext {
      visibility: hidden;
      width: 120px;
      background-color: #555;
      color: #fff;
      text-align: center;
      border-radius: 6px;
      padding: 5px 0;
      position: absolute;
      z-index: 1;
      bottom: 125%;
      left: 50%;
      margin-left: -60px;
      opacity: 0;
      transition: opacity 0.3s;
    }
    .tooltip .tooltiptext::after {
      content: "";
      position: absolute;
      top: 100%;
      left: 50%;
      margin-left: -5px;
      border-width: 5px;
      border-style: solid;
      border-color: #555 transparent transparent transparent;
    }
    .tooltip:hover .tooltiptext {
      visibility: visible;
      opacity: 1;
    }
    </style>
  </head>
  <body style="text-align:center;">
    <h2>Tooltip</h2>
    <p>Move the mouse over the text below:</p>
    <div class="tooltip">Hover over me
      <span class="tooltiptext">Tooltip text</span>
    </div>
  </body>
</html>
```

## Loader
Nello sviluppo di pagine e siti chep resntano elementi caricati con tecnologie asincrone è indispensabile usare i *loader* per indicare al visitatore che la pagina sta caricando sezioni e/o dati. Per creare elementi grafici *loader* esistono vari metodi che possono essere usate, la più usata e comune è l'uso di keyframes e animazioni di css per ruotare o animare elementi. Per esempio per ruotare una immagine statica 
```
  .spin {
      animation: spin 2s linear infinite;
  }
  @keyframes spin {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
  }
```
Oppure per creare uno slider animato
```
    .loaderNao{
    	font-size:64px;
    	font-weight:bold;
    	color:#bb86fc;
    	padding:14px;
      background: linear-gradient(currentColor 0 0) bottom left / 0% 3px no-repeat;
      animation: loaderNaoKey 3s linear infinite;
    }
    @keyframes loaderNaoKey {
      100% {
        background-size: 100% 3px;
      }
    }
```
Un esempio completo di diversi metodi di loader combinando bootstrap con le icone boxicons:
```
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        .loader {
            font-size: 2rem;
        }
        .spin {
            animation: spin 2s linear infinite;
        }
        .pulse {
            animation: pulse 1.5s ease-in-out infinite;
        }
        .bounce {
            animation: bounce 1s ease infinite;
        }
        .horizontal-loader {
            width: 100%;
            height: 4px;
            background-color: #e9ecef;
            position: relative;
            overflow: hidden;
        }
        .horizontal-loader::after {
            content: '';
            position: absolute;
            width: 40%;
            height: 100%;
            background-color: #0d6efd;
            animation: horizontalLoad 1.5s infinite ease-in-out;
        }
        .vertical-dots {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }
        .dot {
            width: 8px;
            height: 8px;
            background-color: #0d6efd;
            border-radius: 50%;
            animation: dotBounce 0.8s infinite;
        }
        .dot:nth-child(2) { animation-delay: 0.2s; }
        .dot:nth-child(3) { animation-delay: 0.4s; }
        .horizontal-dots {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
        }
        .horizontal-dot {
            width: 8px;
            height: 8px;
            background-color: #0d6efd;
            border-radius: 50%;
            animation: dotPulse 1s infinite;
        }
        .horizontal-dot:nth-child(2) { animation-delay: 0.2s; }
        .horizontal-dot:nth-child(3) { animation-delay: 0.4s; }
        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.3); opacity: 0.7; }
            100% { transform: scale(1); opacity: 1; }
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
        @keyframes horizontalLoad {
            0% { left: -40%; }
            100% { left: 100%; }
        }
        @keyframes dotBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        @keyframes dotPulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.5); opacity: 0.5; }
        }
        .loaderNao{
          font-size:64px;
          font-weight:bold;
          color:#bb86fc;
          padding:14px;
            background: linear-gradient(currentColor 0 0) bottom left / 0% 3px no-repeat;
            animation: loaderNaoKey 3s linear infinite;
        }
        @keyframes loaderNaoKey {
          100% {
            background-size: 100% 3px;
          }
        }
        .loaderNao2{
          border:16px solid black;
          border-radius:50%;
          border-top: 16px solid lightgray;
          width: 5rem;
          height:5rem;
          padding:1px;
          animation: loaderNaoKey2 2s linear infinite;
        }
        @keyframes loaderNaoKey2 {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <h1 class="text-center mb-5">Loader Animati con Boxicons</h1>
        <div class="row g-4 justify-content-center">
            <!-- Loader con rotazione -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-5">
                        <i class="bx bx-loader loader spin text-primary mb-3"></i>
                        <h5 class="card-title">Loader Rotante</h5>
                        <p class="card-text text-muted">Animazione di rotazione continua</p>
                    </div>
                </div>
            </div>
            <!-- Loader con pulsazione -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-5">
                        <i class="bx bxs-circle loader pulse text-primary mb-3"></i>
                        <h5 class="card-title">Loader Pulsante</h5>
                        <p class="card-text text-muted">Effetto di pulsazione</p>
                    </div>
                </div>
            </div>
            <!-- Loader con rimbalzo -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-5">
                        <i class="bx bxs-square loader bounce text-primary mb-3"></i>
                        <h5 class="card-title">Loader Rimbalzante</h5>
                        <p class="card-text text-muted">Animazione di rimbalzo</p>
                    </div>
                </div>
            </div>
            <!-- Loader orizzontale -->
            <div class="col-md-6">
                <div class="card h-100 shadow-sm">
                    <div class="card-body p-5">
                        <div class="horizontal-loader mb-3"></div>
                        <h5 class="card-title text-center">Loader Orizzontale</h5>
                        <p class="card-text text-muted text-center">Barra di caricamento orizzontale</p>
                    </div>
                </div>
            </div>
            <!-- Loader verticale con punti -->
            <div class="col-md-3">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-5">
                        <div class="vertical-dots mb-3">
                            <div class="dot"></div>
                            <div class="dot"></div>
                            <div class="dot"></div>
                        </div>
                        <h5 class="card-title">Loader Verticale</h5>
                        <p class="card-text text-muted">Punti rimbalzanti verticali</p>
                    </div>
                </div>
            </div>
            <!-- Loader orizzontale con punti -->
            <div class="col-md-3">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-5">
                        <div class="horizontal-dots mb-3">
                            <div class="horizontal-dot"></div>
                            <div class="horizontal-dot"></div>
                            <div class="horizontal-dot"></div>
                        </div>
                        <h5 class="card-title">Loader Orizzontale Punti</h5>
                        <p class="card-text text-muted">Punti pulsanti orizzontali</p>
                    </div>
                </div>
            </div>
            <div class="col-md-10">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-5">
                      <div class="loaderNao">Loading ...</div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="card h-100 shadow-sm">
                    <div class="card-body text-center p-5">
                      <div class="loaderNao2"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
```

## Datepicker
La gestione delle date rappresenta uno degli aspetti più frequenti nello sviluppo di applicazioni web moderne. Che si tratti di prenotazioni, pianificazione di eventi o selezione di periodi temporali, la necessità di fornire agli utenti strumenti intuitivi e funzionali per la scelta delle date è diventata una priorità nel design dell'esperienza utente. Le interfacce tradizionali spesso si limitano a semplici campi di input che richiedono la digitazione manuale delle date, approccio che può generare errori di formato e frustrazioni negli utenti. In risposta a questa problematica, l'integrazione di componenti datepicker all'interno di finestre modali offre una soluzione che combina accessibilità, controllo e validazione automatica.


L'implementazione di una modal dotata di datepicker jQuery UI rappresenta un equilibrio tra funzionalità avanzate e semplicità d'uso. Questa soluzione consente di sfruttare le capacità di localizzazione, validazione e personalizzazione offerte dalla libreria jQuery UI, mantenendo al contempo un'interfaccia pulita e non invasiva per l'utente finale. Nel presente articolo verrà analizzata una implementazione pratica che dimostra come integrare efficacemente questi componenti, evidenziando le scelte tecniche adottate e i benefici derivanti dall'utilizzo di questa architettura nell'ambito dello sviluppo web front-end.
Codice header:
```
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery e jQuery UI CSS/JS -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/ui-lightness/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Localizzazione italiana per jQuery UI -->
<script src="https://code.jquery.com/ui/1.13.2/i18n/datepicker-it.min.js"></script>
<style>
    .date-input-group input {
        transition: border-color 0.3s;
    }
    .date-input-group input:focus {
        outline: none;
        border-color: #0d6efd;
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }
    .result-container {
        display: none;
    }
    .date-card {
        border-left: 4px solid #0d6efd;
    }
    /* Personalizzazione jQuery UI Datepicker */
    .ui-datepicker {
        font-size: 14px;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        z-index: 9999;
    }
    .ui-datepicker-header {
        border-radius: 6px 6px 0 0;
    }
    /* Assicura che il datepicker sia sopra la modal di Bootstrap */
    .ui-datepicker {
        z-index: 1070 !important;
    }
</style>
```
Codice HTML:
```
    <h1 class="display-5 mb-4">Modal con jQuery Datepicker e Bootstrap 5</h1>
    <p class="lead">Clicca il pulsante per aprire la modal e selezionare un periodo di date.</p>
    ...
    <button type="button" class="btn btn-success btn-lg" data-bs-toggle="modal" data-bs-target="#dateModal">
      Seleziona Periodo
    </button>
    ...

    <!-- Container per i risultati -->
    <div id="resultContainer" class="result-container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">Periodo Selezionato</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="date-card bg-light p-3 rounded">
                            <strong class="d-block text-primary">Data di Inizio:</strong>
                            <span id="selectedStartDate" class="fs-6"></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="date-card bg-light p-3 rounded">
                            <strong class="d-block text-primary">Data di Fine:</strong>
                            <span id="selectedEndDate" class="fs-6"></span>
                        </div>
                    </div>
                </div>
                <div class="mt-3 p-2 bg-info bg-opacity-10 rounded">
                    <strong class="text-info">Durata:</strong> <span id="duration"></span>
                </div>
            </div>
        </div>
    </div>
    ...
    <div class="modal fade" id="dateModal" tabindex="-1" aria-labelledby="dateModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h1 class="modal-title fs-5" id="dateModalLabel">Seleziona Periodo</h1>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="date-input-group">
                                <label for="startDate" class="form-label fw-bold">Data di Inizio</label>
                                <input type="text" class="form-control form-control-lg" id="startDate" name="startDate" readonly placeholder="Seleziona data inizio">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="date-input-group">
                                <label for="endDate" class="form-label fw-bold">Data di Fine</label>
                                <input type="text" class="form-control form-control-lg" id="endDate" name="endDate" readonly placeholder="Seleziona data fine">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annulla</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="clearDates()">Pulisci</button>
                    <button type="button" class="btn btn-primary" onclick="saveDates()">Conferma</button>
                </div>
            </div>
        </div>
    </div> 
```
Codice Javascript:
```
$(document).ready(function() {
    // Configurazione globale per jQuery UI Datepicker in italiano
    $.datepicker.setDefaults($.datepicker.regional['it']);

    // Inizializzazione dei datepicker
    $("#startDate").datepicker({
        dateFormat: 'dd/mm/yy',
        minDate: 0, // Non permette date passate
        maxDate: '+2y', // Massimo 2 anni nel futuro
        showButtonPanel: true,
        changeMonth: true,
        changeYear: true,
        onSelect: function(selectedDate) {
            // Aggiorna la data minima per il campo "data di fine"
            var minDate = $(this).datepicker('getDate');
            $("#endDate").datepicker('option', 'minDate', minDate);

            // Se la data di fine è precedente a quella di inizio, la svuota
            var endDate = $("#endDate").datepicker('getDate');
            if (endDate && endDate < minDate) {
                $("#endDate").val('');
            }
        }
    });

    $("#endDate").datepicker({
        dateFormat: 'dd/mm/yy',
        minDate: 0,
        maxDate: '+2y',
        showButtonPanel: true,
        changeMonth: true,
        changeYear: true,
        onSelect: function(selectedDate) {
            // Aggiorna la data massima per il campo "data di inizio"
            var maxDate = $(this).datepicker('getDate');
            $("#startDate").datepicker('option', 'maxDate', maxDate);
        }
    });

    // Gestione eventi Bootstrap modal
    $('#dateModal').on('shown.bs.modal', function () {
        // Modal aperta - puoi aggiungere logica se necessario
    });

    $('#dateModal').on('hidden.bs.modal', function () {
        // Modal chiusa - puoi aggiungere logica se necessario
    });
});

// Funzione per pulire le date
function clearDates() {
    $('#startDate, #endDate').val('');
    // Reset delle opzioni min/max date
    $("#startDate").datepicker('option', {minDate: 0, maxDate: '+2y'});
    $("#endDate").datepicker('option', {minDate: 0, maxDate: '+2y'});
}

// Funzione per salvare le date
function saveDates() {
    const startDate = $('#startDate').val();
    const endDate = $('#endDate').val();

    if (!startDate || !endDate) {
        // Usa il toast di Bootstrap per gli avvisi
        showToast('Per favore seleziona entrambe le date', 'warning');
        return;
    }

    // Calcola la durata
    const start = $("#startDate").datepicker('getDate');
    const end = $("#endDate").datepicker('getDate');
    const diffTime = Math.abs(end - start);
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; // +1 per includere entrambi i giorni

    // Mostra i risultati
    $('#selectedStartDate').text(startDate);
    $('#selectedEndDate').text(endDate);
    $('#duration').text(diffDays + ' giorni');

    $('#resultContainer').slideDown(400);

    // Chiudi la modal usando Bootstrap
    var modal = bootstrap.Modal.getInstance(document.getElementById('dateModal'));
    modal.hide();

    // Scroll verso i risultati
    $('html, body').animate({
        scrollTop: $("#resultContainer").offset().top - 20
    }, 500);

}
```


## Broadcast
Il Broadcast in JavaScript è implementato attraverso il [BroadcastChannel API](https://developer.mozilla.org/en-US/docs/Web/API/Broadcast_Channel_API), che permette la comunicazione tra diverse finestre, tab, iframe o worker che appartengono alla stessa origine (stesso dominio). È come un sistema di messaggistica che permette di inviare messaggi a tutti i "listener" interessati. Esempio preso spunto dal [video](https://www.youtube.com/watch?v=l-tJt0S4kgE).
Ecco un esempio pratico di utilizzo:
```
<!DOCTYPE html>
<html lang="">
  <head>
    <meta charset="utf-8">
    <title></title>
    <style>
      .hidden{display: none;}
    </style>
  </head>
  <body>
    <header></header>
    <main>
      <div class="warning hidden" id="warning">
        <h2>Warning</h2>
        <p>Hai aperto la pagina in un'altra tab!</p>
      </div>
      <div id="whatsapp-container" class="whatsapp-container">
        <h2>Whatsapp</h2>
        <p>Questa è la pagina di whatsapp</p>
      </div>
    </main>
    <footer></footer>
    <script>
      const warningElement = document.getElementById('warning');
      const whatsappContainerElem= document.getElementById('whatsapp-container');
      const broadcast = new BroadcastChannel('whatsapp-tab');
      broadcast.postMessage("new-tab");
      console.log(" broadcast message sent")
      broadcast.onmessage = (event) => {
        console.log(" broadcast message received " + event.data);
        if(event.data === 'new-tab') {
          warningElement.classList.remove("hidden");
          whatsappContainerElem.classList.add("hidden");
        }
      }
    </script>
  </body>
</html>
```
## WebSocket-Chat
Il Broadcast Channel funziona solo tra finestre/tab dello stesso browser. Non può comunicare tra browser diversi (per esempio tra Chrome e Firefox) per motivi di sicurezza e privacy. Se hai bisogno di comunicare tra browser diversi, dovresti considerare alternative come WebSocket per comunicazione real-time attraverso un server. I comandi per installare un ws con node e npm:
```
mkdir websocket-server
cd websocket-server
npm init -y
npm install ws
node server.js
```
Il codice di esempio che implementa WebSocket potrebbe essere:
```
const WebSocket = require('ws');
// Crea un server WebSocket sulla porta 8088
const wss = new WebSocket.Server({ port: 8088 });
// Tiene traccia dei client connessi e dei nomi utente
let connectedClients = new Set();
let activeUsernames = new Set();
// Gestisce le nuove connessioni
wss.on('connection', (ws, req) => {
    let username = null;
    // Gestisce i messaggi ricevuti
    ws.on('message', (message) => {
        try {
            const data = JSON.parse(message);
            // Gestisce il login
            if (data.type === 'login') {
                if (activeUsernames.has(data.username)) {
                    ws.send(JSON.stringify({
                        type: 'login_response',
                        success: false,
                        message: 'Username già in uso'
                    }));
                    return;
                }
                username = data.username;
                activeUsernames.add(username);
                connectedClients.add(ws);
                ws.send(JSON.stringify({
                    type: 'login_response',
                    success: true,
                    message: 'Login effettuato con successo'
                }));
                // Notifica tutti della nuova connessione
                broadcastMessage({
                    type: 'system',
                    message: `${username} è entrato nella chat`
                });
                console.log(`${username} si è connesso. Totale utenti: ${activeUsernames.size}`);
                return;
            }
            // Gestisce i messaggi normali
            if (username && data.type === 'message') {
                broadcastMessage({
                    type: 'message',
                    username: username,
                    message: data.message
                });
            }
        } catch (error) {
            console.error('Errore nella gestione del messaggio:', error);
        }
    });
    // Gestisce la disconnessione
    ws.on('close', () => {
        if (username) {
            activeUsernames.delete(username);
            connectedClients.delete(ws);
            
            broadcastMessage({
                type: 'system',
                message: `${username} ha lasciato la chat`
            });

            console.log(`${username} si è disconnesso. Totale utenti: ${activeUsernames.size}`);
        }
    });
    // Gestisce gli errori
    ws.on('error', (error) => {
        console.error('Errore WebSocket:', error);
        if (username) {
            activeUsernames.delete(username);
            connectedClients.delete(ws);
        }
    });
});
// Funzione per inviare messaggi a tutti i client
function broadcastMessage(message) {
    const messageString = JSON.stringify(message);
    connectedClients.forEach((client) => {
        if (client.readyState === WebSocket.OPEN) {
            client.send(messageString);
        }
    });
}
// Log quando il server si avvia
console.log('Server WebSocket in ascolto sulla porta 8088');
// Gestisce gli errori del server
wss.on('error', (error) => {
    console.error('Errore del server:', error);
});
// Pulizia alla chiusura del server
process.on('SIGTERM', () => {
    console.log('Chiusura del server...');
    wss.close(() => {
        console.log('Server chiuso');
        process.exit(0);
    });
});
```
Il client si collega il websocket con metodo specifico:
```
// Connetti al WebSocket
function connectWebSocket() {
    ws = new WebSocket('ws://localhost:8088');
    ws.onopen = () => {
        login(username);
    };
    ws.onclose = () => {
        document.getElementById('statusText').textContent = 'Disconnesso';
        document.getElementById('statusText').classList.remove('text-green-200');
        disableChat();
        setTimeout(connectWebSocket, 3000);
    };
    ws.onerror = (error) => {
        console.error('WebSocket Error:', error);
        disableChat();
    };
    ws.onmessage = (event) => {
        const data = JSON.parse(event.data);
        switch(data.type) {
            case 'login_response':
                handleLoginResponse(data);
                break;
            case 'message':
                handleChatMessage(data);
                break;
            case 'system':
                addSystemMessage(data.message);
                break;
        }
    };
}
```



# AlNao.it
Nessun contenuto in questo repository è stato creato con IA o automaticamente, tutto il codice è stato scritto con molta pazienza da Alberto Nao. Se il codice è stato preso da altri siti/progetti è sempre indicata la fonte. Per maggior informazioni visitare il sito [alnao.it](https://www.alnao.it/).


## License
Public projects 
<a href="https://it.wikipedia.org/wiki/GNU_General_Public_License"  valign="middle"><img src="https://img.shields.io/badge/License-GNU-blue" style="height:22px;"  valign="middle"></a> 
*Free Software!*