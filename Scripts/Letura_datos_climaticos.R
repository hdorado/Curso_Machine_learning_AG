
# Lectura de datos climaticos
# Hugo Andres Dorado B.
# 19-08-2021

names <- list.files("Datos_climaticos/")

names <- gsub("_FUS.txt","",names)

paths <- list.files("Datos_climaticos/",full.names = T)

clima <- lapply(paths,read.table,header=T)

names(clima) <- names

stat_clima <- clima$`12045020_TMAX`

stat_clima$Dates <- as.Date(stat_clima$Date)

plot(stat_clima$Dates,stat_clima$Value )


