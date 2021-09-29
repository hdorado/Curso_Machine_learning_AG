
# Operaciones de tablas y listas
# Hugo Andres Dorado
# 12/08/2021

library(agridat)
library(tibble)
library(dplyr)

data("hessling.argentina")

?hessling.argentina

head(hessling.argentina)

# Selecciona precipitaciones

precipitaciones <- hessling.argentina %>% column_to_rownames("year") %>% 
  select(p05:p12)

precipitaciones

?sum

# Operaciones por fila

apply(precipitaciones, 1, sum,na.rm = T)

rowSums(precipitaciones)

# Operaciones por columna

apply(precipitaciones, 2, mean)

# Agregar una variable

datosSiglo <- hessling.argentina %>% mutate(Siglo = ifelse(year<1900,"800s","900s"))

datosSiglo

tapply(datosSiglo$yield, datosSiglo$Siglo, mean)

# Desagregar por listas

separar_siglos <- split(datosSiglo,datosSiglo$Siglo)

separar_siglos

separar_siglos$`900s`

separar_siglos$`800s`

# lapply

ls_datos <- lapply(separar_siglos, function(x){
  x <- x[,-17]
  apply(x,2,mean)
})

do.call(rbind,ls_datos)

cultivos <- c("MANGO","ARROZ","BANANO","GUANABANA")

cultivos_min <- lapply(cultivos, tolower)

cultivos_min

# Sapply 

sapply(1:10,function(x){x^2} )

sapply(hessling.argentina,is.numeric)

iris_clase <- sapply(iris,is.numeric)

num_iris <- iris[,iris_clase]

num_iris


# mapply

rep(1,4)
rep(2,3)
rep(3,2)
rep(4,1)


mp <- mapply(rep,1:4,4:1)

mp

do.call(c,mp)

# Libreria purr

library(purrr)

mtcars %>%
  split(.$cyl) %>% # from base R
  map(~ lm(mpg ~ wt, data = .)) %>%
  map(summary) %>%
  map_dbl("r.squared")









