library(raster)
#carico raster
setwd("C:/lab/")
#setto la working directory

#importo le immagini satellitare da Virtuale

l1992 <- brick("defor1_.jpg")
#importo le immagini
l1992
#classe Rasterbrick, ovvero sono presenti vari livelli
#sono presenti 3 sole bande con i 3 nomi
plot(l1992)
#visualizzo a schermo
l2006 <- brick("defor2_.jpg")
plot(l2006)
