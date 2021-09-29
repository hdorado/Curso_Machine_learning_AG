
# Leer archivos desde R
# Hugo Andres Dorado B.
# 22-07-2021

library(readr)
library(readxl)
library(data.table)

# install.packages("readr","readxl","data.table")

# Listar archivos de una carpeta

list.files()

# Crear una carpeta validando primero que ya exista

if(!file.exists("Datos espaciales")){
dir.create("Datos espaciales")
}

list.files()

# Confirmar que existe un archivo con un nombre especifico

file.exists("Resultados")

# Dercagar datos de la web

download.file("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/11-24-2020.csv",
              destfile = "Datos/covid-19.csv")

?unzip # Descomprimir archivos

datos <- read.csv("Datos/covid-19.csv")

head(datos,10)

str(datos)

summary(datos)

tail(datos,10)

datos <- read.table("Datos/covid-19.csv",header = T, sep=",",quote = "\"",
                    stringsAsFactors =  T,na.strings = "NA")

summary(datos)

# nrow = numero de filas a leer, skip

platano0 <- read.table("clipboard",header = T,sep="\t") # Leer datos desde el clipboard

summary(platano0)

datos2 <- read_xlsx("Datos/eventos_de_platano.xlsx")

datos2 <- as.data.frame(datos2)

summary(datos2)

?fread

covid <- fread("Datos/covid-19.csv")
is(covid)

install.packages("RSQLite","RMySQL")

install.packages("dbplyr")

library(RSQLite)
library(dbplyr)
library(dplyr)

download.file(url = "https://ndownloader.figshare.com/files/2292171",
              destfile = "Datos/portal_mammals.sqlite",mode = "wb")

mammals <- DBI::dbConnect(RSQLite::SQLite(),"Datos/portal_mammals.sqlite")

summary(mammals)

src_dbi(mammals)

tbl(mammals, sql("SELECT year, species_id, plot_id FROM surveys"))

# paquetes para leer y procesar paginas web httr, XML (Funcion GET)

# paquete foreing, para leer archivos de diversos formatos 


url <- "https://www.ncdc.noaa.gov/data-access"


library(httr)
library(XML)

webScrap <- GET(url)

c <- content(webScrap,as="text")
ht <- htmlParse(c,asText = T)

xpathSApply(ht,"//title",xmlValue)

# https://www.r-bloggers.com/2014/02/web-scraping-the-basics/


