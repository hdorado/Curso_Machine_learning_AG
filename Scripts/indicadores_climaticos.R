
rm(list=ls())

#VINCULACULACI?N DATOS CLIMATICOS 

source("Scripts/funcionesClimaticas.R")

lotes    <- read.csv("Datos/Lotes.csv")

head(lotes)

lotes$Germinacion <- as.Date(lotes$Germinacion,"%m/%d/%Y")
lotes$Fin.Cosecha <- as.Date(lotes$Fin.Cosecha,"%m/%d/%Y")

sort(lotes$Fin.Cosecha-lotes$Germinacion)

hist(as.numeric(lotes$Fin.Cosecha-lotes$Germinacion))

cosechBase      <-  lotes
climBase        <-  read.csv("Datos/station_JOINT.csv")

head(climBase)

names(climBase) <-  c("DATE","RAIN","TMAX","TMIN","RHUM","ESOL")

climBase$DATE <- as.Date(climBase$DATE,"%m/%d/%Y")

Indicadores  = c("mean(TMAX)","mean(TMIN)","mean((TMAX+TMIN)/2)",
                 "mean(TMAX-TMIN)","sum(ESOL)","sum(TMAX>34)/length(TMAX)",
                 "sum(RAIN)","sum(RAIN > 10)/length(RAIN)",
                 "sum(TMIN<15)/length(TMIN)","mean(RHUM)","sd(RHUM)" )


namFun=c("Temp_Max_Avg", "Temp_Min_Avg","Temp_Avg","Diurnal_Range_Avg",
         "Sol_Ener_Accu","Temp_Max_34_Freq","Rain_Accu","Rain_10_Freq",
         "Temp_Min_15_Freq","Rhum_Avg","Rhum_sd" )

#parametros para estimar tiempo de la fase


periodBase     <- 119.77
FaseCultivo    <- c("VEG","REP","LLEN")
diasPorFase    <- c(47.5,41.27,31)
namFec         <- c("Germinacion","Fin.Cosecha")


a <- climIndicatorsGenerator(climVar=Indicadores,namFun=namFun,Fase=FaseCultivo,
                             periodcul=periodBase,diasFase=diasPorFase,cosechBase=cosechBase,
                             namFecha=namFec,climBase=climBase)


a

write.csv(data.frame(lotes,a),"Resultados/eventos_clima_arroz.csv",row.names = F)

write.table(data.frame(lotes,a),"Resultados/eventos_clima_arroz.csv",row.names = F,sep=";",dec=",")


