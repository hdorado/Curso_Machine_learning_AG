
datos <- read.csv("Datos/lista_participantes.csv")

datos2 <- read.table("Datos/Lista_ML_150721_horas.txt",skip = 60,sep="\t")

participantes <- unique(datos$ï..Nombre.completo)

ruleta <- function(){

sample(x = participantes,size = 1)

}

ruleta()

