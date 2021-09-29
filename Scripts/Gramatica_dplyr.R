
# Gramatica dplyr
# Hugo Dorado
# 02-Agosto - 2021

library(dplyr)
library(nycflights13)
library(ggplot2)

sqrt(mean(flights$distance))

flights$distance %>% mean() %>% sqrt()

# Leer una base de datos

"Datos/eventos_de_platano.csv" %>% read.csv(stringsAsFactors = T) %>% summary()

datos_platano <- "Datos/eventos_de_platano.csv" %>% read.csv(stringsAsFactors = T)

datos_platano %>% head()

gplot <- datos_platano %>% ggplot(aes(x=NO_ARBOLES,y=AREA_UM)) + geom_point() +
  theme_bw()

ggsave("Resultados/plot_area_arboles.png",gplot)








