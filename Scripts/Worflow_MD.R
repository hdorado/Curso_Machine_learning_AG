
# Worflow para mineria de datos
# Hugo Andres Dorado
# 16-08-2021

# install.packages('caret')

library(caret)

library(randomForest)

datos <- read.csv("Datos/mora_toyset.csv",row.names = 1)

head(datos)


# Seleccionar variables informativas

nz <- nearZeroVar(datos)

datos <- datos[,-nz]

# Remover variables correlacionadas 

# Particion de los datos

set.seed(123)

inTrain <- createDataPartition(y = datos$Yield,p=0.60,list=F)

inTrain

trainning <- datos[inTrain,]

testing <- datos[-inTrain,]

# Normalizacion de los datos

# Optimzar parametros

ctrl <- data.frame(mtry=c(3,6,12,18,21))

model <- train(Yield~.,data=datos,method = "rf",tuneGrid=ctrl,
               trControl= trainControl(method = "repeatedcv",number = 4))

model

# Despeño del modelo

pred_var <- predict(model,testing)

pred_var

postResample(pred_var,testing$Yield)


plot(pred_var,testing$Yield)
lines(1:3,1:3)

varimp <- varImp(model)

plot(varimp)



partialPlot(model$finalModel, data, srtm, main="srtm", xlab="srtm")


