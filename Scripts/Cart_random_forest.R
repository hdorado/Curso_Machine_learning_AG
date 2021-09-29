
# Arboles de clasificacion y regresión y random forest
# Hugo Andres Dorado
# 16-08-2021

library(randomForest)
library(party)
library(rpart)
library(rpart.plot)

# Base de datos mtcars

mtcars

?mtcars

?rpart

tree <- rpart(mpg ~.,data=mtcars,cp =0.001)
tree

plot(tree)
text(tree, use.n = TRUE)

rpart.plot(tree,type = 2)

# Random forest

rf.mtcars <- randomForest(mpg~. , data=mtcars)

rf.mtcars

?randomForest

plot(mtcars$mpg,rf.mtcars$predicted,pch=16,col="red")
lines(1:40,1:40)





