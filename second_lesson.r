#MULTIVARIATE ANALYSES---- 

#Questi metodi sono dedicati all'analisi di set di dati che includono un gran numero di variabili.
#È importante sottolineare che tutte queste variabili sono trattate simultaneamente e allo stesso modo, il che significa che non esiste una o poche variabili "preferite" rispetto alle altre, ma sono tutte ugualmente importanti.
#Diversamente dai test statistici 'classici' (chi-quadro, t-test, ecc.) e dai modelli (regressione lineare, anova, ecc.), i metodi multivariati non producono modelli stocastici e significatività statistiche, ma si concentrano sull'ottenimento di una panoramica della variabilità dei dati, spesso attraverso semplici rappresentazioni grafiche. In altre parole, tutte le analisi multivariate mirano a estrarre il "segnale" all'interno dei dati
#in presenza di "rumore". Per questi motivi, le analisi multivariate sono solitamente metodi "aperti", cioè "liberi" da ipotesi da verificare.
#Gli obiettivi principali dei metodi multivariati sono:

#Gli obiettivi principali dei metodi multivariati sono:
#1) Riduzione della dimensionalità (analisi esplorativa, semplificazione dei dati) → Analisi delle componenti principali (PCA)
#2) Classificazione (valutazione del grado di omogeneità all'interno di osservazioni/unità sperimentali) → Cluster analysis

#PRINCIPAL COMPONENT ANALYSIS (PCA)----
#PCA is a statistical procedure that uses an orthogonal transformation to convert a given set of (possibly
#correlated) numeric variables into a new set of variables called ‘principal components’. Of course the
#starting set of variables corresponds to the experimental variables. The transformation is defined in
#such a way that the new variables are: 
#1) ordered according to the percentage of variance that they explain;
#2) uncorrelated between each other. 


#Dato che, partendo da un dato numero di variabili, il metodo produce un numero (quasi) uguale di componenti principali, 
#qual è il vantaggio del metodo? In che modo PCA consente la "dimensionalità". riduzione'?
#Per rispondere a queste domande, consideriamo le proprietà dei componenti principali. 
#Si parte da un insieme di variabili disordinate e (potenzialmente) correlate e si ottiene un insieme di nuove variabili ordinate 
#(secondo la varianza) e non correlate (componenti principali). Ciò significa che con un piccolo numero delle componenti principali di rango più alto – prima, seconda, terza, … – 
#conserviamo gran parte della varianza presente nel dataset originale. Allo stesso tempo, filtriamo il "rumore", che viene trattenuto dai componenti principali di rango più basso. 
#In questo modo, concentrandoci su un basso numero di variabili – cioè riducendo la dimensionalità dei dati – possiamo studiare (e rappresentare graficamente) i principali pattern/caratteristiche di un dataset multivariato.



#In R there is a number of functions dedicated to the analysis of principal components. Among them,
#one of the most frequently used is dudi.pca from package ade4.
#R comes with a number of default packages, but it can be expanded at will installing supplementary
#libraries/packages. Each library is dedicated to a particular method, set of methods, application, etc. For
#instance, the library ade4 implements a large number of multivariate methods.
#In order to install new libraries in our R version we can proceed as follows: 

install.packages("ade4")
library(ade4)

#La funzione dudi.pca contiene argomenti per eseguire un bilanciamento preliminare delle variabili a cui si vuole applicare PCA. 
#Perché abbiamo bisogno di "bilanciare" le variabili? Perché PCA è dipendente dalla scala, il che significa che i risultati del metodo sono influenzati dalle dimensioni delle variabili. 
#Ciò significa che le variabili con grandezza e varianza maggiori hanno un impatto maggiore sui risultati rispetto a quelle con grandezza e varianza inferiori. Pertanto, il bilanciamento
#ha lo scopo di rendere tutte le variabili numericamente omogenee e richiede due passaggi:

#1) centratura → tutte le variabili vengono trasformate in modo da avere media = 0;

#2) ridimensionamento → tutte le variabili vengono trasformate in modo da avere deviazione standard = 1.

#(Si noti che ci sono alcuni casi in cui il bilanciamento non è consigliabile, ad esempio quando le variabili sono conteggi/frequenze assolute).
#Sperimentiamo con PCA con un set di dati di esempio (file usair.csv). I dati comprendono 7 variabili climatologiche/ambientali osservate in 41 città americane. Più precisamente, le variabili sono:
#concentrazione di anidride solforosa (SO2), temperatura (negativa) (Neg.Temp), produzione (Manuf), popolazione (Pop), vento (Wind), precipitazioni (Precip), giorni di precipitazioni (Days). Importiamo il file dati:


data=read.csv("usair.csv")
summary(data) 



#Per il momento, escludiamo dall'analisi la variabile SO2, che è un indicatore del livello di inquinamento, ed eseguiamo PCA con le restanti 6 variabili.

pca1=dudi.pca(data[,-1],center=T,scale=T)


#Il primo argomento è il frame di dati a cui viene applicato il PCA (meno la prima colonna) mentre il secondo e il terzo argomento, center e scale, impostano le opzioni di bilanciamento. (Vale la pena osservare che "VERO" è
#l'impostazione predefinita per queste opzioni, quindi non sarebbe necessario specificarle in questo caso). Dopo aver avviato l'analisi, l'interfaccia grafica R si apre mostrando un barplot: questo barplot rappresenta gli 
#autovalori delle componenti principali da calcolare. Cosa sono gli autovalori? Gli autovalori sono a misura della varianza spiegata dalle componenti principali, quindi ha senso che la prima componente abbia l'autovalore più alto, 
#il successivo valore più alto sia quello della seconda componente e così via. In sintesi, le componenti principali sono ordinate secondo gli autovalori.
#La funzione dudi.pca funziona di default in modo interattivo, infatti, dopo aver mostrato il grafico, attende che scegliamo il numero di componenti principali che vogliamo mantenere nei risultati. Infatti, a
#spiegato sopra, il "trucco" della PCA si concentra su un basso numero di nuove variabili (i componenti principali) che rappresentano una grande quota della variabilità dell'intero set di dati. Pertanto, la domanda è: 
#quanti componenti dovremmo tenere? Purtroppo non esiste una risposta univoca. Secondo alcuni analisti, dovremmo conservare componenti fino al 70-90% della varianza totale. Secondo altri,
#dovremmo mantenere quelle componenti che conservano una quantità di variabilità superiore alla media delle variabili originarie. In pratica, la decisione finale è lasciata alla discrezionalità dell'analista. Se, ad esempio, 
#il numero di variabili di partenza è molto elevato – alcuni set di dati possono includere migliaia di variabili o anche molte di più – potremmo essere legittimamente soddisfatti del 20-30% della varianza totale.
#Nel caso in esame – che è molto semplice – possiamo conservare 3 componenti principali. Come facciamo a sapere la percentuale di varianza trattenuta da loro? La riga seguente ottiene la risposta:

perc.eig=100 * pca1$eig/sum(pca1$eig)


#L'oggetto pca1 contiene i risultati del nostro PCA e pca1$eig è una "sezione" di questo oggetto in cui sono memorizzati gli autovalori. Dividendo gli autovalori per la loro somma totale (e moltiplicando per 100), 
#otteniamo la percentuale di varianza per ogni componente principale. Quindi:


cumsum(perc.eig) 

#è la somma cumulativa di queste percentuali. Possiamo vedere che con 3 componenti principali manteniamo quasi tutta la variabilità originale.
#Ora rivolgiamo la nostra attenzione all'oggetto pca1: è composto da diverse "sezioni" o "slot", ciascuna delle quali contiene parti dei risultati PCA. Tra questi vale la pena citare:


pca1$call # the ‘call’ is the instruction that we used for this specific analysis,
pca1$tab # this section contains the input data after balancing,
pca1$eig # as observed above, here is the complete sequence of eigenvectors,
pca1$rank # a number specifying the number of starting independent variables,
pca1$c1 # loadings of the starting variables (see below for details),
pca1$li # scores or individual coordinates of the principal components (see below for details)



#Caricamenti e punteggi sono i risultati più importanti della PCA.
#I “caricamenti” sono le correlazioni tra le componenti principali e le variabili originali del dataset.
#Pertanto, un caricamento uguale a zero significa assenza di correlazione tra una data componente principale e una data variabile. 
#Al contrario, i valori di caricamento vicini a 1 e -1 suggeriscono una forte correlazione tra loro, rispettivamente positiva e negativa.
#In conclusione, i caricamenti consentono di chiarire la "composizione" delle componenti principali in termini di variabili originali.
#I "punteggi" sono invece i valori effettivi delle componenti principali, ovvero le coordinate delle nostre osservazioni dopo PCA. 
#In altre parole, le nostre osservazioni iniziali erano rappresentate dai valori di un dato insieme di variabili. Dopo la PCA,
#questi valori sono stati convertiti – attraverso una trasformazione dello spazio – in un nuovo insieme di valori, che sono i punteggi 
#delle componenti principali. Ovviamente ci concentriamo solo sui punteggi dei componenti principali mantenuti.
#Sia i caricamenti che i punteggi sono solitamente rappresentati graficamente utilizzando scatterplot, cioè piani euclidei su cui sono
#rappresentate due variabili quantitative (asse x e asse y).
#Come possiamo generare grafici a dispersione in R? Iniziamo con i punteggi PCA.
#Una possibilità è usare la funzione 'plot', che è la funzione di tracciamento di base in R. Nel nostro caso:


plot(pca1$li[,1],pca1$li[,2],xlab="PC1",ylab="PC2",type="n") 


#I primi due argomenti sono le variabili che devono essere rappresentate rispettivamente sull'asse x e sull'asse y.
#Nel nostro caso, stiamo tracciando la prima e la seconda componente principale, cioè quelle componenti che spiegano 
#la più alta percentuale di varianza totale. Gli argomenti xlab e ylab specificano rispettivamente il contenuto delle etichette 
#associate agli assi x e y. L'ultimo argomento, type="n", impedisce a R di tracciare qualsiasi cosa all'interno dello spazio della
#trama (infatti 'n' sta per 'no plotting'). Lo stiamo facendo perché vogliamo riempire il grafico con etichette che specifichino 
#i nomi delle città incluse nel set di dati. Dopo aver lanciato il comando, il dispositivo grafico R si apre mostrando il grafico "vuoto".
#Aggiungiamo i nomi delle città alla trama usando la funzione grafica "testo". Questa funzione – come molte altre – lavora su una trama 
#preesistente, aggiungendo elementi ad essa. In particolare, la funzione 'testo' aggiunge etichette all'interno della trama.


text(pca1$li[,1],pca1$li[,2],labels=abbreviate(row.names(data)),cex=0.7)

#Il testo viene aggiunto alle stesse coordinate utilizzate per il grafico della funzione. L'argomento "etichette" è un vettore contenente 
#il testo da tracciare sul grafico. Qui, i nomi delle città vengono estratti dal set di dati originale utilizzando la funzione "row.names" 
#e abbreviati (altrimenti potrebbero essere lunghi per la trama) con un'altra funzione, "abbreviate". L'ultimo argomento, 'cex', modula l''espansione del carattere',
#cioè la dimensione della lettera (il default è 1).
#Per salvare il grafico, digitare:

dev.copy2pdf(file="pca_scores.pdf") 


#Risultati della traduzione
#Risultato di traduzione
#Il grafico viene salvato nella directory di lavoro corrente con il nome specificato nell'argomento "file".
#Potrebbe essere interessante includere le informazioni sulla percentuale di varianza trattenuta dalle componenti principali tracciate.
#Può essere fatto con una versione leggermente più complicata delle precedenti righe di comando.

plot(pca1$li[,1],pca1$li[,2],xlab=paste("PC1 (",perc.eig[1],"% of total variance)",sep=""),
ylab=paste("PC2 (",perc.eig[2],"% of total variance)",sep=""),type="n")
text(pca1$li[,1],pca1$li[,2],labels=abbreviate(row.names(data)),cex=0.7)


#Un altro metodo per tracciare un grafico a dispersione dei punteggi PCA è fornito dalla funzione s.label. Questa funzione, 
#che è una funzione di tracciamento specifica della libreria ade4, ha lo scopo di rappresentare "grafici a dispersione con etichette".
#La riga di comando è più semplice di quella "trama" ma è meno flessibile.


s.label(pca1$li,xax=1,yax=2)


#In questo caso il primo argomento è semplicemente la sezione $li dei risultati PCA, mentre l'argomento xax e yax specificano quali componenti 
#principali (tra quelle che abbiamo mantenuto) verranno tracciate nel grafico. Inoltre, è possibile includere un barplot "in miniatura" all'interno 
#dello stesso grafico utilizzando la funzione "add.scatter.eig" (ovvero "aggiungi allo scatterplot gli autovalori").

add.scatter.eig(pca1$eig,nf=3,xax=1,yax=2,posi="bottomleft")


#Qui il primo argomento è la sezione $eig dei risultati PCA, mentre 'nf' corrisponde al numero di componenti conservati e 'posi' specifica la posizione 
#(all'interno del grafico a dispersione) in cui vorremmo tracciare gli autovalori. Altri argomenti (xax e yax) come sopra.
#Passiamo ai caricamenti PCA. Un modo semplice per rappresentare graficamente i caricamenti, se il numero di variabili non è troppo elevato, 
#consiste nell'utilizzare un particolare grafico a dispersione che includa un cerchio di correlazione. Può essere fatto facilmente con un'altra 
#funzione grafica di ade4, s.corcircle.


s.corcircle(pca1$c1,xax=1,yax=2) 


#Naturalmente, il primo argomento è la sezione $c1 dei risultati PCA, mentre xax e yax hanno lo stesso significato di cui sopra. In questo grafico i due assi 
#corrispondono alla prima (x) e alla seconda (y) componenti principali (analogamente al grafico dei punteggi), mentre i caricamenti sono rappresentati da frecce. 
#In particolare, la posizione della punta delle frecce è determinata dalle correlazioni tra le variabili originarie e le componenti principali del grafico.
#In questo modo, la lunghezza e l'inclinazione delle frecce ci permettono di capire a colpo d'occhio l'associazione tra variabili originarie e componenti principali.

#Esercizio 1. Rappresenta graficamente i punteggi PCA ei caricamenti della seconda e terza componente principale sopra calcolati.
#Quando abbiamo iniziato la nostra analisi, abbiamo escluso una delle variabili (SO2) dai conteggi. Ciò è stato fatto perché l'SO2 è un indicatore di inquinamento ambientale 
#e potrebbe essere interessante verificare la relazione tra l'inquinamento e tutte le altre variabili sintetizzate dalla PCA. Un modo semplice per verificarlo consiste nell'eseguire 
#un test di correlazione tra SO2 e i componenti principali. Per quanto riguarda il primo componente principale:


cor.test(data$SO2,pca1$scores[,1])


#What does the test suggest?
#Exercise 2. Perform correlation tests with second and third principal components. What do you conclude?
#Exercise 3. The ‘iris’ dataset was introduced in 1936 by famous statistician and biologist Ronald Fisher
#as an example of linear discriminant analysis. It is available in R by typing: 


data(iris) 



#Si compone di 50 campioni di tre specie di iris, vale a dire Iris setosa, Iris virginica e Iris versicolor.
#Per ogni campione sono state misurate 4 variabili numeriche, ovvero la lunghezza e la larghezza dei sepali e dei petali, in centimetri.
#Il tuo compito è:
#1) eseguire la PCA in base alle variabili numeriche dell'iride;
#2) calcolare la percentuale di varianza trattenuta dalle componenti principali;
#3) tracciare i punteggi della prima e della seconda componente principale utilizzando entrambe le funzioni "plot" e "s.label";
#4) carichi grafici della prima e della seconda componente principale.Quindi, alcuni compiti più difficili:
#5) dopo aver letto la pagina di aiuto ?plot.default (sezione 'Dettagli'), rifare lo scatterplot dei punteggi del punto 3 aggiungendo gli argomenti 'pch' e/o 'col' per differenziare le osservazioni in base alla specie classificazione;
#6) dopo aver letto la pagina di aiuto di ?s.class, provare a rifare lo scatterplot includendo la classificazione delle specie.
#Cosa suggeriscono i risultati? C'è struttura nei dati? È possibile discriminare le specie di iris in base ai risultati del PCA?
#Quale componente principale descrive meglio la classificazione delle specie? Quale variabile/variabili sono meglio associate a questo componente?

#CLUSTER ANALYSIS----
#Il clustering è un ampio insieme di tecniche per trovare gruppi di osservazioni all'interno di un set di dati. In generale,
#le osservazioni all'interno dello stesso ammasso dovrebbero essere simili, mentre le osservazioni in ammassi diversi dovrebbero essere dissimili
#(almeno più dissimili di quelle all'interno dell'ammasso!). La somiglianza tra le osservazioni è definita utilizzando alcune misure di distanza tra
#le osservazioni, comprese misure di distanza euclidea e basate sulla correlazione.
#Esistono due famiglie principali di metodi di clustering (non supervisionati), chiamati metodi gerarchici e non gerarchici.
#I metodi gerarchici tipicamente producono una rappresentazione ad albero delle osservazioni, chiamata dendrogramma. In generale, 
#i metodi gerarchici richiedono un passo preliminare che è il calcolo della distanza (o dissomiglianza) tra ciascuna coppia di osservazioni. 
#In pratica le distanze sono misure che sintetizzano tutte le differenze (su tutte le variabili) tra una coppia di osservazioni.
#Le distanze possono essere calcolate in molti modi diversi. Una delle misure di distanza più frequenti è la distanza euclidea, 
#che corrisponde alla distanza geometrica tra una coppia di punti in uno spazio multidimensionale, dove ciascuna delle variabili presenti 
#nel dataset corrisponde a una dimensione dello spazio e i loro valori sono le coordinate di i punti/osservazioni.


#Se si calcolano le distanze per tutte le possibili coppie di osservazioni, si ottiene come risultato una matrice delle distanze. 
#Una matrice delle distanze è una matrice quadrata (numero di righe = numero di colonne) la cui dimensione è uguale al numero di osservazioni. 
#Una tipica matrice di distanza ha tre caratteristiche principali:
#1) è al quadrato (come detto sopra),
#2) la sua diagonale è piena di zeri (infatti i valori della diagonale corrispondono alle distanze di ciascuna osservazione da se stessa),
#3) è simmetrico, una proprietà che deriva dal fatto che la distanza tra, diciamo, l'osservazione 1 e l'osservazione 2 è la stessa della distanza tra l'osservazione 2 e l'osservazione 1.
#Per questi motivi (simmetria e diagonale piena di zeri), le matrici delle distanze sono spesso rappresentate come matrici triangolari, cioè stampano 
#solo i valori sotto la diagonale, cioè il triangolo inferiore della matrice. Infatti il triangolo superiore, essendo simmetrico a quello inferiore, è 
#una ripetizione degli stessi valori, ed è noto il contenuto della diagonale (zero).
#Vediamo un esempio pratico, considerando il dataset “iris”. Analogamente alla PCA, prima di calcolare le distanze, le variabili necessitano di una fase 
#di bilanciamento, che viene eseguita con la funzione scale:


iris.scaled=scale(iris[,-5]) # we exclude the 5th column because it is a non-numeric variable. 


#Quindi applichiamo la funzione 'dist' al set di dati in scala:

iris.dist=dist(iris.scaled) 

#Tieni presente che questi passaggi possono essere eseguiti con un'unica riga di comando:

iris.dist=dist(scale(iris[,-5]))

#La funzione 'dist' calcola di default una matrice di distanze euclidee tra tutte le coppie di osservazioni.
#(Ma nota che altri metodi sono disponibili con l'argomento 'method' - vedi la funzione help per i dettagli).
#La matrice delle distanze è rappresentata di default con il formato triangolare. Se preferiamo il formato "completo",
#dovremmo impostare entrambi gli argomenti "diag" e "upper" come TRUE (T). Si noti inoltre che le matrici di distanza hanno una propria classe R:

class(iris.dist)


#Come accennato in precedenza, una distanza di matrice è il punto di partenza per la maggior parte dei metodi di clustering gerarchico.
#I metodi di clustering gerarchico utilizzati più di frequente sono definiti "aggregativi", nel senso che l'algoritmo inizia trattando ciascun
#oggetto come un cluster singleton. Successivamente, le coppie di cluster vengono successivamente unite finché tutti i cluster non sono stati uniti
#in un unico grande cluster contenente tutti gli oggetti. Naturalmente, l'unione dei cluster si basa sulle distanze tra le osservazioni, quindi tutti 
#i metodi iniziano a raggruppare quelle coppie di osservazioni che mostrano la distanza più bassa. Quindi, ogni metodo ha il proprio criterio per unire 
#i cluster di "livello superiore" (ovvero "cluster di cluster") e, naturalmente, ogni metodo ha i suoi vantaggi e svantaggi.
#Una delle funzioni che calcolano il clustering gerarchico in R è hclust, che implementa diversi metodi di clustering (vedere ?hclust per i dettagli). 
#Tra questi, i più utilizzati sono il collegamento completo (che è l'impostazione predefinita), la media e il rione. Iniziamo con il collegamento completo:


iris.hc=hclust(iris.dist) 


#Con il collegamento completo, la distanza tra due cluster è definita come il valore massimo di tutte le distanze a coppie tra gli elementi nel cluster 1 
#e gli elementi nel cluster 2. Tende a produrre cluster "più compatti".
#Per quanto riguarda il tracciato del dendrogramma:

plot(iris.hc)


#Ma è più informativo introdurre i nomi delle specie come etichette del dendrogramma:


plot(iris.hc,labels=iris[,5],cex=0.6) 


#Poiché sappiamo che il dataset include tre specie di iris (setosa, versicolor, virginica),
#potrebbe essere interessante tagliare l'albero in tre gruppi:


rect.hclust(iris.hc,k=3,border = 2:4) # the ‘border’ arguments is here used for setting groups’ colors
iris.hc3=cutree(iris.hc,k=3) # outputs group membership for each observation in the dataset 


#Possiamo verificare le prestazioni del metodo confrontando le affiliazioni delle specie con l'appartenenza ai cluster:


table(iris$Species,iris.hc3) 

#È chiaro che il collegamento completo ha funzionato bene con setosa, ma versicolor e virginica non sono ben risolti.
#Successivamente, proviamo il metodo di collegamento medio. In questo caso, la distanza tra due cluster è definita come la 
#distanza media tra gli elementi del cluster 1 e gli elementi del cluster 2.


iris.ha=hclust(iris.dist,method="average") # note that the ‘method’ argument is used for specifying nondefault methods
plot(iris.ha,labels=iris[,5],cex=0.6)
rect.hclust(iris.ha,k=3,border = 2:4)
iris.ha3=cutree(iris.ha,k=3)
table(iris$Species,iris.ha3) 


#Il metodo di collegamento medio fa un lavoro perfetto con setosa, ma ancora una volta la separazione tra versicolor e virginica è irrisolta.
#Concludiamo con il metodo di Ward o della varianza. Riduce al minimo la varianza totale all'interno del cluster, il che significa che ad ogni 
#passaggio la coppia di cluster che porta all'aumento minimo della varianza totale all'interno del cluster viene unita.


iris.hw=hclust(iris.dist,method="ward.D")
plot(iris.hw,labels=iris[,5],cex=0.6)
rect.hclust(iris.hw,k=3,border = 2:4)
iris.hw3=cutree(iris.hw,k=3)
table(iris$Species,iris.hw3) 


#Il metodo di Ward non è inoltre in grado di risolvere chiaramente versicolor e virginica. In conclusione, i risultati di cui sopra suggeriscono che: 
#1) setosa è chiaramente distinguibile da altre specie, ma
#2) versicolor e virginica non lo sono, almeno con le variabili comprese nel presente dataset.
#Tieni presente che non esistono metodi "esatti" o "migliori" nell'analisi dei cluster. Alcuni metodi funzionano meglio con determinati tipi di dati, 
#altri metodi con altri tipi. Un buon consiglio è quello di provare diversi metodi e confrontare i risultati.
#È probabile che i risultati che appaiono indipendentemente dal metodo riflettano la struttura effettiva all'interno dei dati.
#Ovviamente ci sono metodi per convalidare i cluster (bootstrap, silhouette, ecc.) ma questo va oltre gli scopi di questo corso.

#Esercizio. Considera il set di dati "wine.txt", che si riferisce a 21 vini della Val de Loire. Il set di dati ha 21 righe (il numero di vini) e 31 colonne.
#la prima colonna corrisponde all'etichetta di origine, la seconda colonna al suolo e le altre ai descrittori sensoriali. 
#Prova i metodi di raggruppamento gerarchico di cui sopra (ovviamente considerando solo le variabili numeriche) e confronta 
#i risultati con il luogo di origine e il tipo di suolo.


#Per quanto riguarda i metodi non gerarchici, il più utilizzato è k-medie. A differenza dei metodi gerarchici, k-mean non restituisce un dendrogramma. 
#Invece, il set di dati viene immediatamente partizionato in un insieme di k gruppi (cioè cluster), che devono essere decisi dall'analista 
#(e questo potrebbe essere uno svantaggio). L'idea di base alla base del clustering k-means consiste nel definire i cluster in modo che la variazione
#totale all'interno del cluster (nota come variazione totale all'interno del cluster) sia ridotta al minimo. Naturalmente, e analogamente ad altri metodi di clustering,
#gli oggetti (osservazioni) all'interno dello stesso cluster sono il più simili possibile (cioè, elevata somiglianza intra-classe), mentre gli oggetti di cluster diversi 
#sono il più dissimili possibile (cioè, bassa somiglianza inter-classe). somiglianza). Nel clustering k-means, ogni cluster è rappresentato dal suo centro 
#(cioè centroide) che corrisponde alla media dei punti assegnati al cluster. La funzione R per questo metodo è chiamata "kmeans". Ancora una volta, utilizzando 
#il set di dati dell'iride:

iris.km=kmeans(scale(iris[,-5]),centers=3,nstart=10)


#Si noti che kmeans si applica direttamente al set di dati (in scala) e non a una matrice di distanza. L'argomento successivo "centri" è il numero di cluster in cui
#vorremmo che il set di dati fosse partizionato. Ne selezioniamo 3 perché sappiamo che i nostri dati riguardano tre specie di iris. L'ultimo argomento, 'nstart', 
#implementa più configurazioni iniziali (casuali) e segnala quella migliore. Infatti, come primo passo l'algoritmo seleziona k oggetti casuali dal dataset, 
#che vengono impostati come centri di cluster iniziali. Quindi, ogni osservazione viene assegnata al suo centro più vicino (in base alle distanze euclidee).
#Successivamente, i centri del cluster vengono ricalcolati come valori medi di tutti i punti assegnati al cluster. Quindi, le osservazioni vengono riassegnate 
#in base ai centri aggiornati. Queste ultime operazioni, ovvero il ricalcolo dei centri del cluster e la riassegnazione dei punti dati a ciascun cluster,
#vengono ripetute fino a quando le assegnazioni del cluster non smettono di cambiare o viene raggiunto il numero massimo di iterazioni. Per impostazione predefinita,
#il numero massimo di iterazioni consentite dalla funzione 'kmeans' è 10 (ma può essere impostato diversamente, se necessario).
#La funzione 'kmeans' emette un oggetto complesso che include molte sezioni (per i dettagli: ?kmeans). I più importanti sono:


iris.km$cluster # a vector indicating cluster affiliation for each point (observation)
iris.km$centers # a matrix of cluster centers
iris.km$size # number of points for each cluster 


#Verifichiamo la corrispondenza tra cluster e specie:


table(iris$Species,iris.km$cluster) 


#Possiamo vedere che kmeans ha prestazioni migliori rispetto ai metodi gerarchici di cui sopra; tuttavia la separazione tra versicolor e virginica rimane
#tutt'altro che perfetta.
#Un bel modo per tracciare i risultati di k-mean è usare la funzione "fviz_cluster" dal pacchetto "factoextra" come segue:


fviz_cluster(iris.km,iris[,-5])



#dove il primo argomento è il risultato di kmeans e il secondo è il set di dati iniziale. La funzione emette un grafico a dispersione del primo e del secondo 
#componente principale (vedere PCA per i dettagli) e unisce i punti in base ai cluster rilevati.
#Tuttavia, rimane una domanda aperta: quanti cluster dovremmo cercare? Infatti, poiché sapevamo a priori che il set di dati dell'iride comprendeva tre specie,
#k = 3 è stata la scelta più naturale. Ma di solito non abbiamo un'idea del numero "migliore" di cluster. Fortunatamente, ci sono molti metodi, indicatori, 
#criteri per decidere quale sia il numero di cluster più adatto per un dato set di dati. (Ad esempio, il pacchetto "NbClust", che contiene una funzione con 
#lo stesso nome, calcola 30 diversi indicatori e suggerisce il miglior k secondo la regola della maggioranza).
#Uno di questi è il metodo del "gomito", che è molto semplice e diretto, ma, dall'altro, mantiene un certo grado di arbitrarietà.
#L'idea di base deriva dal fatto che la varianza totale all'interno dei gruppi dovrebbe diminuire all'aumentare del numero di cluster. 
#Possiamo facilmente verificare questo:

kmeans(scale(iris[,-5]),centers=1,nstart=10)$tot.withinss
kmeans(scale(iris[,-5]),centers=2,nstart=10)$tot.withinss
kmeans(scale(iris[,-5]),centers=3,nstart=10)$tot.withinss
kmeans(scale(iris[,-5]),centers=4,nstart=10)$tot.withinss
kmeans(scale(iris[,-5]),centers=5,nstart=10)$tot.withinss

#e così via. In che modo questo può essere utile per decidere il miglior valore k? Dobbiamo osservare come diminuisce la varianza totale all'interno del gruppo.
#Se siamo abbastanza fortunati, dovrebbe esserci un punto in cui tale diminuzione diventa meno rapida. In altre parole, da quel momento in poi un ulteriore aumento 
#di k porta solo miglioramenti marginali delle prestazioni di clustering. Naturalmente l'individuazione di tale punto è in qualche modo arbitraria. 
#Per facilitare la nostra decisione, è una buona idea tracciare i valori della varianza rispetto a k.
#Per fare questo, abbiamo bisogno di un piccolo script di loop. Innanzitutto, generiamo un vettore "vuoto", che verrà riempito in seguito, durante il ciclo:


tot.var=vector("numeric",10)


#Il primo argomento specifica la classe del vettore (“numerico”), mentre il secondo ne definisce la lunghezza. Scegliamo 10 perché vogliamo calcolare i valori 
#di varianza per k da 1 a 10.
#Quindi usiamo l'operatore "for" per applicare iterativamente la funzione "kmeans" 10 volte:


for (i in 1:10) {
  tot.var[i]=kmeans(scale(iris[,-5]),centers=i,nstart=10)$tot.withinss
}


#Il ciclo inizia dichiarando una variabile 'contatore', che qui chiamiamo 'i', e che varierà da 1 a 10 durante il ciclo. Quindi, tra parentesi graffe ({}) 
#specifichiamo l'operazione che verrà eseguita iterativamente 10 volte. In pratica è lo stesso comando che abbiamo usato sopra, ma qui il numero di centri
#è determinato da 'i'. Ad ogni esecuzione del ciclo, il risultato verrà "registrato" nel vettore tot.var nella posizione "i".
#Tracciamo i risultati:


plot(1:10,tot.var,type="b",xlab="number of centers",ylab="total variance") 


#È un grafico a dispersione in cui l'argomento 'type="b"' introduce una linea spezzata che collega i 10 punti.
#Ora, secondo il criterio del 'gomito', dovremmo individuare il punto in cui la linea presenta qualcosa come un 'gomito'. 
#In questo caso, è chiaro che k = 3 è un buon candidato per il "gomito", inoltre coincide con la nostra aspettativa basata sul numero di specie presenti nel set di dati.

#Esercizio. Sperimenta con il clustering k-mean utilizzando il set di dati del vino sopra.



















