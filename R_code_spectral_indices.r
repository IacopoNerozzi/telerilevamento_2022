### DAY 6 ###
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
