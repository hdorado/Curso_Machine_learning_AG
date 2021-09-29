
# Practica de funciones y estructuras en R
# Hugo Andres Dorado
# Julio 2021

# Operaciones logicas

a <- c(2,3,4,3,2)

# Igual 

a == 2

# Diferente a

a != 3

# Control + l, limpiar la consola

# Mayor que o menor que

a >= 2
a <= 2

a[a > 2] # Extraer subconjuntos con reglas

a %in% c(2,4)

# and or

a[a>2 & a<4 ]

a[a<3 | a>3]

# which (posicion)

which.max(a)

which.min(a)

which(a >2)


iris$Species == "versicolor"

iris[iris$Species == "versicolor",]

# Filtrar las lineas con Sepal.Length menores o iguales a 6

iris[iris$Sepal.Length <= 6,]

# Funciones en R

filtrarversicolor <- function(){
  iris[iris$Species == "versicolor",]
}

filtrarversicolor()

filtrarflor <- function(flor){
  iris[iris$Species == flor,]
}

filtrarflor("versicolor")

filtrarflor <- function(flor = "setosa"){
  iris[iris$Species == flor,]
}

filtrarflor("virginica")

filtrarflor <- function(flor = "setosa",sl){
  # Filtrar la matriz iris
  iris[iris$Species == flor & iris$Sepal.Length <= sl,]
  
}

filtrarflor("virginica",6)

filtrarflor(sl = 6, flor = "virginica")


# area cuadrado argumento l, area_cuad

area_cuad <- function(l){
  ac <- l^2
  return(56)
  236
  ac
}

area_cuad(3)

# Calcular el volumen de prisma equivalente a mutilplicar arista1,arista2,arista3,
# asignar valores de defecto para todas las aristas respectivamente de 1,3,2

vol_prism <- function (a1,a2,a3){
  a1*a2*a3
}
vol_prism(1,3,2)

## Control de estructuras en R ##

if(4 > 3){
  "Verdadero"
}

if(4 < 3){
  "Verdadero"
}

if(4>3){
  
  "Verdadero"
  
}else{"Falso"}

calificaciones <- c(6,7,8,1,2)

media <- mean(calificaciones)

if(media >= 6){
  print("Aprobado")
}else{
  print("Reprobado")
}


# Crear una funcion validar_curso con un argumento llamado calificaciones

# Loops o ciclos for

print("Hugo")
print("Hugo")
print("Hugo")
print("Hugo")
print("Hugo")


for(i in 1:10){
  
  print("Hugo")
  print(i)

}

dado <- 1:6

for(cara in dado){
  print(cara^2)
}


# Elevar lanzamientos al cuadrado y guardarlos dentro de un vector

dado <- 1:6

dado2 <- NULL

for(cara in dado){
  
  dado2[cara] <- cara^2
  
}

dado^2

dado2

x <- matrix(1:6,2,3)

x

seq_len(5)

for(i in seq_len( nrow(x) )){
  for(j in seq_len( ncol(x) )){
    print(x[i,j])
  }
}

# While

umbral <- 5
valor <- 0

while(valor < umbral){
  print(paste("Todavia no el valor es ", valor))
  valor <- valor + 1
}

while(1 < 2){
  print("test")
}


# Función sample

?sample

sample(dado,5,replace = T)

sample(c("C","S"),2,replace = T)

ruleta()

# Medir el tiempo procesamiento de un proceso

ptm <- proc.time()

sample(dado,500000,replace = T)

proc.time() - ptm


