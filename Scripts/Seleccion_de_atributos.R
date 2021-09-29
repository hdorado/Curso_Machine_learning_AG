
# Metodos de seleccion de atributos
# Hugo Andres Dorado
# 19-08-2021
# 

library(caret)
library(FSinR)
library(dplyr)

# Lectura de datos

datos <- read.csv("Datos/Platano_cultivo_asociado_colombia.csv",row.names = 1,
                  stringsAsFactors = T)

head(datos)

summary(datos)

# datos$ID <- row.names(datos)
#inner_join

# Modelo completo - Linea base

set.seed(123)

modelo_completo <- train(RDT_PLANT~., data = datos,method = 'knn',
                         tuneLength = 4)

modelo_completo

#-------------------------------------------------------------------------------
##   Metodos de seleccion de atributos

filter_eval <- filterEvaluator("cramer")

?filterEvaluator

variables <- names(datos)[-26]

cramerV <- filter_eval(datos,"RDT_PLANT",variables)

cramerV

dfcramer <- data.frame(variables,cramerV)

dfcramer <- dfcramer %>% arrange(desc(cramerV))

seleccion_filtros <- dfcramer %>% filter(cramerV>0.80)

seleccion_filtros <- seleccion_filtros$variables

seleccion_filtros

# Modelo con seleccion por filtros

set.seed(123)

modelo_filtros <- train(RDT_PLANT~., data = datos[c(seleccion_filtros,"RDT_PLANT")],
                        method = 'knn',
                        tuneLength = 4)

modelo_filtros


# Otros filtros

nearZeroVar(datos)

# Correlacion

datos_cuant <- datos %>% select_if(is.numeric)

cor_datos <- cor(datos_cuant)

corVars <- findCorrelation(cor_datos,cutoff = 0.7)

corVars

set.seed(123)

modelo_filtros_cor <- train(RDT_PLANT~., data = datos[c(corVars,26)],
                        method = 'knn',
                        tuneLength = 4)

modelo_filtros_cor

# Modelos con seleccion por wrappers

set.seed(123)

evaluador <- wrapperEvaluator("knn")

search <- searchAlgorithm("hillClimbing")

results <- featureSelection(datos,"RDT_PLANT",search,evaluador)

?searchAlgorithm

results

selecVars <- which(results$bestFeatures==1)

selecVars

set.seed(123)

modelo_wrapper <- train(RDT_PLANT~., data = datos[c(selecVars,26)],
                            method = 'knn',
                            tuneLength = 4)


modelo_wrapper

# Metodos embebidos

set.seed(123)

modelo_embebido_rf <- train(RDT_PLANT~., data = datos,
                            method = 'rf',
                            tuneLength = 4)

modelo_embebido_rf

# Comparacion

modelo_completo # 7.165960

modelo_filtros # 7.206280

modelo_filtros_cor # 7.000805

modelo_wrapper # 6.910266

names(datos)[selecVars]

modelo_embebido_rf # 6.656563






