
# Procesamiento de datos utilizando los paquetes tidyr y dplyr
# Hugo Andres Dorado B.
# 03-08-2021

library(tidyr)
library(dplyr)
library(ggplot2)

# Leer datos de cultivo utilizando csv

crop_data <- read.csv("Datos/Maize_Cordoba_Crop.csv",stringsAsFactors = T)

summary(crop_data)

crop_data

crop_data <- tibble(crop_data)

crop_data

is(crop_data)

# Versión transpuesta 

glimpse(crop_data)

# filtrar en base a una condicion

crop_data[crop_data$Yield > 8,]

?filter

filter(crop_data,Yield > 8)

crop_data %>% filter(Yield > 8) %>% summary()

crop_data %>% filter(Yield > 8 , Sowing_Method == "Mecanizado")

# Ordenar base de datos

crop_data %>% arrange(Yield)

crop_data %>% arrange(desc(Yield))

crop_data %>% arrange(Sowing_Method,desc(Yield))

# seleccionar algunas de las columnas del tibble

crop_data %>% select(Cultivar,Yield)

head(crop_data)

crop_data %>% select(Cultivar:Yield)

crop_data %>% select(Soil_ID,Former_Crop,everything())

crop_data %>% select(Soil_ID,Cultivo_Anterior = Former_Crop,everything())

# Renombrar columnas

crop_data %>% rename(Rendimiento = Yield, Fecha_siembra = Planting_Date)

# crear una nueva columna dentro de la base de datos

crop_data <- crop_data %>% mutate(Dataset = "Maiz_cordoba")

crop_data <- crop_data %>% mutate(YieldAvg = mean(Yield))

is(crop_data$Planting_Date)

?as.Date

is(as.Date(crop_data$Planting_Date,"%m/%d/%Y"))

crop_data <- crop_data %>% mutate(Planting_Date = as.Date(Planting_Date,"%m/%d/%Y"),
                                  Harvest_Date = as.Date(Harvest_Date,"%m/%d/%Y"))


crop_data <- crop_data %>% mutate(Length_Cycle = as.numeric(Harvest_Date - Planting_Date))

crop_data

summary(crop_data)

# Agrupar por categorias en la base de datos

tapply(crop_data$Yield,crop_data$Sowing_Method,mean)

crop_data <- crop_data %>% group_by(Sowing_Method)

crop_data %>% summarise(promedioY = mean(Yield), maxY = max(Yield),
                        sdY= sd(Yield),promedioLC = mean(Length_Cycle,na.rm = T))

agregado <- 
  crop_data %>% group_by(Sowing_Method,Cultivar) %>% summarise(
  Avg_Yield = mean(Yield), Avg_LC = mean(Length_Cycle,na.rm=T), n = n()
)

agregado

agregado %>% arrange(desc(n))

?separate

crop_data2 <- crop_data %>% mutate(Fecha = as.character(Harvest_Date)) %>%
 separate(Fecha,c("Anio","Mes","Dia"),sep="-")

crop_data2

summary(crop_data2)


# 1. Utilizar mutate para convertir el año en numerico

crop_data2 <- crop_data2 %>% mutate(Anio = as.numeric(Anio))

summary(crop_data2)

# 2. Filtrar solo los registros desde 2015 en adelante, filter

fcrop_data2 <- crop_data2 %>% filter(Anio >= 2015)

summary(fcrop_data2)

# 3. Hacer un agregado por Former crop calculando promedio y mediana de rendimiento

fcrop_data2 <- fcrop_data2 %>% group_by(Former_Crop) %>% summarise(PromedioY = mean(Yield), MedianaY = median(Yield))

# 4. Ordenar el conjunto de datos resultante agregado de manera ascendente por promedio de rendimiento

fcrop_data2 <- fcrop_data2 %>% arrange(PromedioY )

write.csv(fcrop_data2,"Resultados/agregado.csv")

