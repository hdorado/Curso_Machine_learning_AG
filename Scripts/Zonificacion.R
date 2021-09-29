
# Zonificacion
# Hugo Andres Dorado
# 24-08-2021

# Lectura de paquetes

libs=c('caret','FactoMineR',"rgdal","raster","sp","rgeos","sf", 
       'tmaptools')

sapply(libs,require,character.only= T)

# Leer archivos espaciales

list.files('Shapes/',pattern = '.tif')

vect <- c('bio_1.tif','bio_5.tif','bio_6.tif','bio_12.tif') # Listar las variables que voy a tener en cuenta en mi analisis

routs <- paste("Shapes",vect,sep="/")

datos_worclim <- lapply(routs,raster)

datos_worclim <- stack(datos_worclim)

plot(datos_worclim)

datos_worclim

# Raster de referencia 

rasterRef <- datos_worclim[[1]] # referencia de un raster ya cortado

levelsWNA <- which(!is.na(rasterRef[])) # Extraer referencia de celdas

coordenadasRef <- xyFromCell(rasterRef,levelsWNA) # Extraer coordenadas

dataWeather <- extract(datos_worclim,coordenadasRef)# Extraer datos de clima 

dataWeather <- as.data.frame(dataWeather)

dataClasificacion <- dataWeather

# Normalizar datos

modNorm <- preProcess(dataClasificacion,method = "range")

dataClasificacionNorm <- predict(modNorm,dataClasificacion)

# Reduccion de dimensiones.

PCAdataClss<- PCA(dataClasificacionNorm,ncp = 2) # PCA

round(PCAdataClss$eig,2)

plot(PCAdataClss)

data <- as.matrix(PCAdataClss$ind$coord)

# Analisis cluster

set.seed(1234)

k.max <- 20

wss <- sapply(5:k.max, 
              function(k){kmeans(data, k, iter.max = 100)$tot.withinss})

plot(5:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

cluster.kmeans <- kmeans(data, 10, iter.max = 10000)

table(names(cluster.kmeans$cluster) == row.names(data))

dataClust <- data.frame(data,cluster=cluster.kmeans$cluster)

# Llevar mi resultado  a un mapa

rasterRef[] <- NA 

rasterRef[levelsWNA] <- factor(dataClust$cluster)

plot(rasterRef)

writeRaster(rasterRef, filename="Classkmeans_10clust_v2.tif", 
            format="GTiff", overwrite=T)






