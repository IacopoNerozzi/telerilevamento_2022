
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

#ci occuperemo di Time Series Analysis
#andremo a vedere cosa è successo nel tempo
#caricando più immagini contemporaneamte
#Analizzeremo quanto ghiaccio si sta sciogliendo in Groenlandia

####


setwd("C:/lab/greenland/")
library(raster)

#faremo prima l'operazione classica
#poi quella globale, importando i dati tutti insieme

#già la funzione brick carica più dati, carica tutte le bande di un'immagine
#ora però non abbiamo una sola immagine con tot bande diverse, ma 4 fonti di dati diverse

lst2000 <- raster("lst_2000.tif")
lst2000
#immagine a 16bit
plot(lst2000)

lst2005 <- raster("lst_2005.tif")
lst2010 <- raster("lst_2010.tif")
lst2015 <- raster("lst_2015.tif")
#importo i restanti dati

cl <- colorRampPalette(c("blue", "light blue", "pink", "red")) (100)
#creo la palette di colori da utilizzare

par(mfrow=c(2,2))
plot(lst2000, col=cl)
plot(lst2005, col=cl)
plot(lst2010, col=cl)
plot(lst2015, col=cl)
#questo è il metodo classico, più macchinoso

#provo l'importazione di massa

rlist <- list.files(pattern="lst")
#uso la funzione list.files
#crea una lista di oggetti secondo un pattern specificato
#il pattern è il metodo di riconoscimento dei files che utilizza il software per riconoscerli
#deve essere un qualcosa che accomuna tutti i dati necessari per metterli insieme
rlist
#non è altro che una lista dei files

import <- lapply(rlist, raster)
import
#con la funzione lapply applico una funzione ad un oggetto
#applico la funzione raster alla lista
#gli argomenti sono la lista e poi la funzione
#ho quindi importato i miei oggetti contemporaneamente

tgr <- stack(import)
tgr
#ho fatto lo stack dei dati
#in questo modo metto insieme i dati senza passare dal multiframe
plot(tgr, col=cl)
#posso anche plottarli risparmiandomi il par

#potrei aver bisogno di plottare solo il primo elemento dello stack
plot(tgr[[1]], col=cl)
#devo quindi specificarlo nella funzione appiccicandolo all'argomento dell'oggetto da importare
#posso specificare acnhe elementi diversi se ho bisogno di essi
dev.off()

plotRGB(tgr, r=1, g=2, b=3, stretch="Lin") 
#se mettessi tutti i valori uguali avrei un'immagine in bianco e nero
#devo necessariamente specififcare lo stretch con un'immagine in bianco e nero
plotRGB(tgr, 1, 2, 4, stretch="Lin") 
plotRGB(tgr, 4, 3, 2, stretch="Lin") 
#lo stretch adatta i dati (normalmente all'interno di un range nel totale all'intero range di dati 6(5K a 16 bit)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(TGr, col=cl)
#plot con la nostra palette

#colorist è un pacchetto molto utile e comprende molte mappe di distribuzione delle specie
#diverse colorazioni a seconda della stagione
#utile per evidenziare la distribuzione stagionale

##Secondo esempio di Time Series Analysis





### 07/04/2022 NO2 DURANTE IL LOCKDOWN  ###

library(raster)
setwd("C:/lab/EN")

en01 <- raster("EN_0001.png")
en01

cl <- colorRampPalette(c('red','orange','yellow'))(100)

plot(en01, col=cl) 
# situazione nube NO2 a gennaio 2020 (prima del lockdown, molto estesa)
dev.off()

en13 <- raster("EN_0013.png")
en13

plot(en13, col=cl) 
# situazione nube NO2 a marzo 2020 (poco dopo inizio lockdown, nube già meno estesa)
dev.off()

# esercizio: importare tutto il set di immagini insieme

ENlist <- list.files(pattern="EN") # crea la lista di file EN
ENimport <- lapply(ENlist, raster) # applica la funzione raster a tutti gli oggetti della lista
ENstack <- stack(ENimport) # crea il Raster Stack (insieme di Raster Brick)

plot(ENstack, col=cl) # plotta tutte le immagini dello stack

# esercizio: plottare solo en01 (prima immagine di gennaio) accanto a en13 (ultima immagine di marzo)

par(mfrow=c(1,2))
plot(ENstack$EN_0001, col=cl)
plot(ENstack$EN_0013, col=cl)
dev.off()

# oppure

en01.13 <- stack(ENstack[[1]], ENstack[[13]])

plot(en01.13, col=cl)
dev.off()

# vediamo la differenza tra la situazione a gennaio e quella a febbraio
difEN <- ENstack[[1]] - ENstack[[13]]
cldifEN <- colorRampPalette(c('blue','white','red'))(100) # gennaio appare come la zona in rosso e marzo la zona in blu

plot(difEN, col=cldifEN)
dev.off()




### 08/04/2022  ###

library(raster)
setwd("C:/lab/")
source("R_inputcode.txt")

rlist <- list.files(pattern="EN")
ENimport <- lapply(rlist, raster)
en <- stack(ENimport)

cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en, col=cl)


plotRGB(en, r=1, g=7, b=13, stretch="lin")





# 08/04/2022 IMMAGINI SOLAR ORBITER ESA

library(RStoolbox)
library(raster)
setwd("C:/lab/")

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun.jpg")
so

plotRGB(so, 1, 2, 3, stretch="lin")

# costruiamo un modello con la funzione unsuperClass, che raggruppa in modo casuale i raster caricati con un algoritmo di kmeans clustering
# il k means clustering è un algoritmo che divide un insieme di oggetti in k gruppi sulla base dei loro attributi
soc <- unsuperClass(so, nClasses=3) # nel modello è compresa una mappa che decidiamo di dividere i 3 categorie energetiche (cluster)
# la valutazione della categoria nella quale cade ogni pixel è randomica, come definito dalla funzione stessa
# possiamo verificare le classi in cui abbiamo impostato la divisione dei pixel nell'ultima riga delle statistiche del modello (values)
soc

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc$map, col=cl) # plottiamo solo la mappa del modello, visualizzando le 3 classi che abbiamo stabilito
# classe rossa = a più alta energia
# classe nera = intermedia
# classe gialla = a più bassa energia
# in realtà ogni persona che ha usato il codice ottiene mappe diverse a livello di colori
# perchè l'algoritmo raggruppa in modo casuale i pixel dell'immagine nelle 3 categorie che abbiamo impostato,
# prendendo casualmente 10000 pixel sul totale dei pixel dell'immagine (7669050 pixel) ma in maniera diversa ogni volta che viene utilizzato.
# L'algoritmo mantiene però il pattern spaziale dell'immagine (se il numero di categorie in cui è stata divisa rimane lo stesso)

