# file data-analysis-AEPS-BigData.R
# 
# This file contains a script to develop regressions with machine learning methodologies
#
#
# author: Hugo Andres Dorado 02-16-2015
#  
#This script is free: you can redistribute it and/or modify
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

#-----------------------------------------------------------------------------------------------------------------


#SCRIPT BUILED FOR R VERSION 3.0.2 
#PACKAGES

rm(list=ls())

require(gtools)
require(gridBase)
require(gridExtra)
require(relaimpo)
require(caret)
require(party)
require(randomForest)
require(snowfall)
require(earth)
require(agricolae)
require(cowplot)
require(reshape)
require(stringr)
require(gbm)
require(plyr)

#Load functions; Open  All-Functions-AEPS_BD.RData

load("All-Functions-AEPS_BD.RData")

#Work Directory

dirFol <- ""

setwd(dirFol)

#DataBase structure

datNam <- "mora_toyset.csv"

dataSet   <- read.csv(datNam,row.names=1)

head(dataSet)

namsDataSet <- names(dataSet)


inputs  <- 1:28  #inputs columns
segme   <- 29   #split column
output  <- 30   #output column


#Creating the split factors

contVariety <- table(dataSet[,segme])
variety0    <- names(sort(contVariety[contVariety>=30]))


if(length(variety0)==0){variety = variety0 }else{variety = factor(c(variety0,"All"))}


#creating folders
variety="All"

# createFolders(dirFol,variety)

#Descriptive Analysis

descriptiveGraphics("All",dataSet,inputs = inputs,segme = segme,output = output,
                    smooth=T,ylabel = "Rendimiento (kg/ha)",smoothInd = NULL,
                    ghrp="box",res=80)

#DataSets ProcesosF

dataSetProces(variety,dataSet,segme,corRed="caret")

#MULTILAYER PERCEPTRON

library(parallel)

detectCores() 

multilayerPerceptronFun("All",dirLocation=paste0(getwd(),"/"),nb.it=5,
                        ylabs="Yield (Kg/HA)",pertuRelevance=T,ncores=3)

#RANDOM FOREST

randomForestFun("All",nb.it=10,ncores = 3,saveWS=F,barplot = T)



