
# Comandos basicos en R
# Hugo Dorado
# 15/07/2021

getwd()

1234

# Ayudas en R

?lm

?apropos

apropos("norm")

# ventana auxiliar

windows()

# asignar valores a objetos en R

edad

edad <- 30

edad

edad == 30 # Operacion logica igual

# Instalar paquetes en R (plyr,ggplot2)

library(plyr)

# install.packages("plyr")

library(ggplot2)

# asignar valores a objetos en R 2

edad.1 <- 6

EDAD

edad

sexo <- "masculino"

sexo

# Manipular objetos en R

edades <- c(12,15,18,16,21)

edades

sexo <- c("M","F","M","M","F")

sexo

length(edades)
length(edad)

is(edades)
is(sexo)

id <- 1:5

id

ciudad <- array("Lima",5)

ciudad

?seq

seq(2,10,2)

renta <- c(600,750,NA,600,250)

renta

# Objeto Data.frame

personas <- data.frame(id,edades,sexo)

personas <- cbind(personas,ciudad)

personas

dim(personas) # Num. filas x num. columnas

nrow(personas) # Num. filas

ncol(personas) # Num. columnas

personas$edades

personas$sexo

personas[3,]

personas[,4]

personas[3:4,c(2,3)]

edades[4]

edades[c(2,4)]

edades[3:5]

edades[6]

personas

personas$renta <- renta

personas$renta_sol <- renta*3.8

personas

is(personas)

# Almacenar dataframes

write.csv(personas,"Resultados/personas1.csv")

write.csv2(personas,"Resultados/personas2.csv")

write.table(personas,"Resultados/personas3.csv",dec = ",",sep = "\t")

# Listar, almacenar y remover objetos en R

ls()

rm(edad.1)

ls()

# rm(list = ls()) Borrar memoria en R

names(personas)

names(personas)[6] <- "renta_soles"

personas$renta_soles[4]

row.names(personas)

# Matrices en R

vec1 <- 1:6

vec1

mat1 <- matrix(vec1,2,3)

mat1

mat2 <- matrix(vec1,3,3,byrow = T)

mat2

mat2[2,]
mat2[,3]

# Objeto tipo lista

lista <- list(ciudad = ciudad,matriz2 = mat2,personas = personas)

lista[[3]]

lista$ciudad

lista[[3]]$renta_soles

save(lista,edad,file = "Resultados/Objetos.RData")

ls()

rm(list = ls())

ls()

lista

load("Resultados/Objetos.RData")

ls()

lista

# Operaciones basicas entre vectores

vec1 <- c(18,50,80,20,15,13)
vec2 <- c(60,13,40,15,36,90)
vec3 <- c(60,13,NA,15,36,90)

sum(vec1)

prod(vec1)

vec1*100

vec1 - 15

396*496

vec2^2

mean(vec3,na.rm = T)

sd(vec3,na.rm = T)

vec1 + vec2

vec1*vec2

sqrt(vec1)

# Otras funciones

sort(vec1,decreasing = T)

order(vec1)

vec4 <- c(1,2,2,3,3,3,0)

unique(vec4)

vx <- c(3,-1,2,1)
vy <- c(1,0,4,1,0,-1) 

x <- matrix(vx,nrow = 2,ncol = 2)
y <- matrix(vy,2,3)
y

2*x

x*x

x%*%x

solve(x)


