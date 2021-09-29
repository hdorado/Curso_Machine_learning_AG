
# Hugo Andres Dorado
# Estimacion de datos faltantes
# 19-08-2021


# Utilizando random forest

library(randomForest)

datos_maiz <- read.csv("Datos/datos_maiz.csv",stringsAsFactors = T,row.names = 1)

summary(datos_maiz)

rfEst <- rfImpute(Yield~.,data = datos_maiz)

summary(rfEst)

write.csv(rfEst,"Resultados/datos_maiz_completo.csv")
