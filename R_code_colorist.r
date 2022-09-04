Colorist ###

install.packages("colorist")
library(colorist)
library(ggplot2) #colorist funziona con ggplot2

data("fiespa_occ")
#campionamento annuale
fiespa_occ
#è un rasterstack, colorist lavora solo con pile di raster

#metrica
met1 <- metrics_pull(fiespa_occ)

#creazione della palette
pal <- palette_timecycle(fiespa_occ)
#creo una palette per ciclo annuale

#creazione della mappa multipla
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))
#ho diviso in 3 colonne le distribuzioni mese per mese nel corso dell'anno

map_single(met1, pal, layer = 6)
#posso estrarre e plottare una delle singole mappe, specificando il layer (mese)

# manipolazione della mappa

p1_custom <- palette_timecycle(12, start_hue = 60)
#cambio il colore delle mappe in serie, con una palette personale

map_multiples(met1, p1_custom, ncol = 4, labels = names(fiespa_occ))
#creo la nuova multipla con la mia palette

#mappa distillata

met1_distill <- metrics_distill(fiespa_occ)
map_single(met1_distill, pal)
#le parti grigie saranno le parti di bassa specificità
#ovvero le specie saranno lì la maggior parte dei mesi
#non ci sono specie che stanno lì in mesi specifici
#le parti più colorate hanno alta specificità


#leg
legend_timecycle(pal, origin_label = "1 jan")
#per comprendere la mappa avremo bisogno della legenda
#specifico la stessa palette e il mese di partenza


#Esempio Pekania penna

data("fisher_ud")
#nuovo dato di partenza

m2 <- metrics_pull(fisher_ud)
#creo la metrica

pal2 <- palette_timeline(fisher_ud)

head(pal2)

#mappa multipla

map_multiples(m2, pal2, ncol = 3, lambda_i = -12)
#vediamo veramente poco, questo è dovuto a lambda
#lambda regola l'opacità
#aggiungo il valore di lmabda agli argomenti

m2_distill <- metrics_distill(fisher_ud)

map_single(m2_distill, pal2, lambda_i = -10)
#creiamo la mappa singola, quella di più interesse
#come nello spazio si è mossa la specie

legend_timeline(pal2)

