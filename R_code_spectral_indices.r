
### Indici spettrali ###
install.packages("rgdal")
library(rgdal)
#installazione pacchetto di lavoro per problemi Mac

library(RStoolbox)
#una libreria fatta apposta per lavorare con dati spettrali
library(raster)
setwd("C:/lab/")


l1992 <- brick("defor1_.jpg")
#importo le immagini
l1992
#classe Rasterbrick, ovvero sono presenti vari livelli
#sono presenti 3 sole bande con i 3 nomi
plot(l1992)
#visualizzo a schermo
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")


l2006 <- brick("defor2_.jpg")
l2006
plot(l2006)
#importo e visualizzo la seconda immagine
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
#vedo la differenza causata dalla deforestazione

#Plot in un multiframe delle due immagini

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
#perchè metto c in par?
#perchè sono due elementi di un vettore, di un array

#posso ora apprezzare le differenze grafiche fra le due immagini
#l'acqua tende ad assorbire tutto l'infrarosso vicino quindi in questo plot tende al nero
#nell'immagine sopra è però bianca, perchè ricca di sedimento


#Calcolo DVI Difference Vegetation Index
#calcoleremo prima quello del 1992
#poi quello del 2006
#vedremo quindi la differenza

dvi1992 <- l1992[[1]] - l1992[[2]]
#1 e 2 sono indicativi delle bande
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2
#soluzione analoga utilizzando i nomi

dvi2006 <- l2006[[1]] - l2006[[2]]
#lo faccio anche per il 2006

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
cl

plot(dvi1992, col=cl)

#DVI differenza nel tempo
dvi_dif = dvi1992 - dvi2006 
cld <- colorRampPalette(c("blue", "white", "red")) (100)
#mi dava "object not interpretable as a factor"
#stare attenti a non scrivere c maiuscolo
dev.off()
plot(dvi_dif, col=cld)

### DAY 7 ###

#esiste un altro indice detto ndvi, molto simile
#viene normalizzato sulla somma delle due bande
#l'altro era una differenza fra le due condizioni
#essendo standardizzato è utile quando si usano immagini con bit diversi

#l'ndvi minimo è -1 lo si ha con l'acqua
#il massimo è 1
#range fra -1 e 1

#il range del dvi è fra -255 e 255

#Range dvi (8bit): -255 a 255
#ange ndvi (8bit): -1 a 1

library(raster)
setwd("C:/lab/")
#carico il pacchetto di lavoro e imposto la working directory

l1992 <- brick("defor1_.jpg")
l1992
l2006 <- brick("defor2_.jpg")
l2006
#importo le immagini
#come vedo se l'immagine è a 8bit?
#guardo il minimo e massimo valore
#essendo compreso fra 0 e 255 è 8bit

#NDVI 1992

dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
#dvi fratto la somma
#oppure
ndvi1992 = (l1992[[1]] - l1992[[2]]) / (l1992[[1]] + l1992[[2]])
#sccrittura alternativa

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(ndvi1992, col=cl)

par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, strech="lin")
plot(ndvi1992, col=cl)
#plottato un multiframe
#sono shiftate perchè una l'immagine originale con legenda, va bene così
#l'indice uno, dove tutto l'infrarosso viene assorbito e l'indice crolla è dell'acqua
#come mai allora buona parte dell'acqua non è scura?
#perchè ha moltissimi solidi disciolti dipendentemente dalla stagione

#NDVI 2006

dvi2006 <- l2006[[1]] - l2006[[2]]
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(ndvi2006, col=cl)

par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
#se non chiudo il par precedente con un dev.off non avrei bisogno di riparirlo stavolta
dev.off()
#Indici Spettali Automatici

library(RStoolbox)
#carico la libreria, utile per analisi dati
?RStoolbox
#all'interno c'è la nostra funzione per gli indici spettrali
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si1992, col=cl)
#plotto a schermo tutti gli indici che riguardano la nostra area di studio

#rasterdiv
install.packages("rasterdiv")
library(rasterdiv)
#andiamo a vedere quale dataset c'è dentro raster
#ndvi di copernicus
#è la media dell'NDVI fra il 1999 e il 2017
#più c'è vegetazione più c'è biomassa, più è alto l'indice
plot(copNDVI)



