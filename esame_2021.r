#directory----
setwd("D:/Desktop/Esame2022Statistica")
#package----
install.packages("ade4")
library(ade4)
#load data----
pesi<-read.csv("pesi.csv")
summary(pesi)
#pca----
pca1=dudi.pca(pesi[,-7],center=T,scale=T)
pca1

#capire quanto "pesano i valori"----
perc.eig=pca1$eig/sum(pca1$eig)*100
perc.eig
#sommare per capire quante componenti ci servano----
cumsum(perc.eig) 

pca1$li
col1=c(rep("red",12),rep("green",11))

#scatterplot----
plot(pca1$li[,1],pca1$li[,2],xlab = "PC1",ylab = "PC2",col=col1)
legend("topright",legend=c("cha","zeb"),pch=1,col=c("red","green"))
text(pca1$li[,1],pca1$li[,2],labels=abbreviate(row.names(pesi)),cex=0.7)
#aggiungere una miniatura----
add.scatter.eig(pca1$eig,nf=3,xax=1,yax=2,posi="bottomleft")

#esportare pdf----
dev.copy2pdf(file="pca_scores.pdf") 
#circle plot----

pca1$c1
s.corcircle(pca1$c1,xax = 1, yax= 2)

#-----
cor.test(pesi$,pca1$scores[,1])

#cluster analisi 1----
#a) Metodo gerarchico - metodo di collegamento completo

#Per procedere con l'analisi è necessario ridimensionare il set di dati e creare la distanza della matrice.

pesi.dist=dist(scale(pesi[,-7]))
pesi.dist
#Questa linea di codice utilizza due funzioni, scale e dist, su una matrice chiamata pesi.
#La funzione scale viene utilizzata per normalizzare i dati nella matrice pesi escludendo 
#la settima colonna (indicata da [, -7]).
#La funzione dist viene quindi utilizzata sui dati normalizzati per calcolare la distanza tra i punti. 
#Il risultato viene assegnato alla variabile pesi.dist.




pesi.hc=hclust(pesi.dist)
pesi.hc

#Questa linea di codice utilizza una funzione chiamata hclust su una matrice di distanze chiamata pesi.dist 
#per effettuare un'analisi di clustering gerarchico. L'analisi di clustering gerarchico è un metodo di 
#agrupamento di dati che utilizza un albero di dendrogrammi per rappresentare la relazione di somiglianza 
#tra i punti di dati. La funzione hclust restituisce un oggetto di clustering gerarchico che può essere utilizzato 
#per visualizzare l'albero di dendrogrammi e per effettuare ulteriori analisi. Il risultato viene assegnato alla variabile pesi.hc


plot(pesi.hc,labels=pesi[,7], cex=0.7)

rect.hclust(pesi.hc,k=2,border = 3:2)

pesi.hc3=cutree(pesi.hc,k=2)
pesi.hc3

#Questa linea di codice utilizza la funzione cutree per tagliare l'albero di dendrogrammi generato da hclust al numero di cluster desiderati.
#In questo caso, l'opzione k=2 indica che l'albero di dendrogrammi deve essere tagliato in 2 cluster.
#La funzione cutree utilizza l'oggetto di clustering gerarchico pesi.hc per identificare i punti di dati che appartengono a ciascun cluster e 
#restituisce un vettore di lunghezza uguale al numero di punti di dati, in cui ogni elemento rappresenta l'indice del cluster a cui appartiene il punto di dati corrispondente.
#Il risultato della funzione viene assegnato alla variabile pesi.hc3

#Il risultato della funzione cutree può essere utilizzato per selezionare i punti di dati in ciascun cluster per ulteriori analisi o per etichettare i punti di dati in base al loro cluster.

table(pesi.hc3,pesi$class)

dev.copy2pdf(file="Dendrogram_complete_linkage")

#cluster analisi 2----
#b) NON - Hierarchical method – k-means

tot.var=vector("numeric",10)

for (i in 1:10) {
    tot.var[i]=kmeans(scale(pesi[,-7]),centers=i,nstart=10)$tot.withinss
}
tot.var
plot(tot.var,type="b",xlab = "number of centers", ylab = "totalvariance")


pesi.km=kmeans(scale(pesi[,-7]),centers=3,nstart=10)
pesi.km
#K-means clustering with 3 clusters of sizes 5, 7, 11

#ottimo modo per vedere i risultati
install.packages("factoextra")
library(factoextra)
fviz_cluster(pesi.km,pesi[,-7])


table(pesi.km$cluster,pesi$class)

#cha zeb
#1   5   0
#2   7   0
#3   0  11

#Questa analisi mostra che aggiungendo un grappolo (ai 2 considerati durante l'analisi PCA), 
#la varietà zeb potrebbe essere perfettamente identificata.
