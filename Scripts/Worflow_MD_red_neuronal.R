
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

corMat <- cor(datos)

corMat

corVars <- findCorrelation( corMat, cutoff = 0.70)

corVars

datos <- datos[,-corVars]

# Particion de los datos

set.seed(123)

inTrain <- createDataPartition(y = datos$Yield,p=0.60,list=F)

inTrain

trainning <- datos[inTrain,]

testing <- datos[-inTrain,]

# Normalizacion de los datos

norm_training_mod <- preProcess(trainning, method = "range")

head(norm_training)

norm_training <- predict(norm_training_mod,trainning)

summary(norm_training)

testing_norm <- predict(norm_training_mod,testing)

summary(testing_norm)


# Optimzar parametros

library(nnet)

ctrl <- expand.grid(size = c(2,6,12),decay = c(0.001,0.01,0.1))

ctrl

model <- train(Yield~.,data=norm_training,method = "nnet",tuneGrid=ctrl,
               trControl= trainControl(method = "repeatedcv",number = 4),
               lineout = T)

?nnet

model

# Despeño del modelo

pred_var <- predict(model,testing_norm)

pred_var

postResample(pred_var,testing_norm$Yield)


plot(pred_var,testing_norm$Yield)
lines(0:3,0:3)

varimp <- varImp(model)

plot(varimp)



partialPlot(model$finalModel, data, srtm, main="srtm", xlab="srtm")


