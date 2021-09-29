
# Analisis de datos espaciales
# Hugo Andres Dorado


library(sf)
library(tidyverse)

peru <- read_sf("datos/Peru_departamento.shp")

print(peru)

plot(peru)

plot(peru["NOMBDEP"])

ggplot() + geom_sf(data = peru, aes(fill = NOMBDEP))

# 

peru <- peru %>% mutate(areakm2 =as.numeric( st_area(geometry) /(1000*1000))) 

print(peru)

# Ordenar a areas de menor a mayor

arrange(peru,areakm2)

peru %>% filter(NOMBDEP == "PASCO")


plot(st_geometry(peru))

departamentos <- peru %>% filter(areakm2 >50000)

plot(st_geometry(departamentos),add=T,col="red")


# Ejercicio con raster



filter


