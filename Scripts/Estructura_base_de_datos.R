
# Estructurar bases de datos
# Hugo Andres Dorado
# 3-08-2021

library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)

data_long <- read.csv('Datos/Cierre_agricola_mun_long.csv')

mun <- str_replace_all(data_long$Nommunicipio,c("Ã©"="o","Ã³"="a","Ã¡"="e"))

str_to_upper(mun)


data_long <- tibble(data_long)

data_long

data_long %>% ggplot(aes(x=Nommodalidad,y=value))+geom_boxplot()+
  facet_wrap(~Variable,scales = 'free')

datos_censo <- data_long %>% pivot_wider(id_cols = c("Nommunicipio","Nommodalidad" ),
                                         names_from = "Variable",
                                         values_from = "value")

?pivot_wider

datos_censo

summary(datos_censo)

datos_censo %>% mutate(Produccion = Area * Rendimiento)

datos_censo %>% pivot_wider(id_cols = "Nommunicipio",
                            names_from = "Nommodalidad",
                            values_from = "Rendimiento")


datos_censo %>% pivot_longer(cols = c('Area' ,'Rendimiento'),
                             names_to = 'Variable',
                             values_to = "Valores")








