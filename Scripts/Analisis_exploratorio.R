
# Analisis  exploratorio de datos
# Hugo Andres Dorado
# 26-07-2021

m1 <- c(21,30,29,30,27,29)
m2 <- c(21,30,29,30,27,70)

mean(m1);mean(m2)
median(m1);median(m2)

sd(m1);sd(m2)

range(m1)

edad <- c(21,34,10,15,37)
estatura <- c(1.8,1.7,1.5,1.4,1.7)

sd(edad)/mean(edad)
sd(estatura)/mean(estatura)

# Graficos en R, paquete base

airquality

summary(airquality)

head(airquality)

complete.cases(airquality)

airq <- airquality[complete.cases(airquality),]

summary(airq)

dim(airquality)
dim(airq)

# Correlacion entre variables

cor.data <- cor(airq)

?cor

cor.data

plot(airq)

windows()

# Cuales variables tienen la correlacion mas alta? 
# Cuales variables tienen la correlacion mas baja?
# cuales variables tienen correlacione negativa?

# Grafico de dispersion

plot(airq$Temp,airq$Ozone,xlab = "Temperatura (degrees F)",ylab = "Ozone (ppb)",
     pch = 16,col="red", main = "Temp vs Ozone")

?plot
?airquality

# Histograma de frecuencias


png("Resultados/hist_ozone.png",width = 520,height =480 )

hist(airquality$Ozone,breaks = 13, ylim = c(0,30),col='orange',
     xlab="",main="")
box()
abline(v = mean(airquality$Ozone,na.rm = T),lty = 2)
text(50,25,"Mu = 42.13")
rug(airquality$Ozone)

dev.off()


# boxplot o diagrama de cajas y bigotes

boxplot(airquality$Solar.R)

boxplot(airquality$Solar.R~airquality$Month)

with(airquality, {boxplot(Solar.R~Month,col="blue")} )

# Graficos para variables cualitativas

tabMeses <- table(airquality$Month)

# Diagrama de barras

barplot(tabMeses, ylim = c(0,35))
box()

# Grafico de torta

pie(tabMeses)

# Graficos con ggplot2

library(ggplot2)

trigo <- read.csv("Datos/baseTrigo.csv",row.names = 1,stringsAsFactors = T)

str(trigo)

head(trigo,10)

summary(trigo)

# Boxplot

brend <- ggplot(trigo,aes(x=Variedad,y=Rend)) + geom_boxplot() + 
  facet_grid(.~ubicacion) + ylab("Rendimiento (ton/ha)") + theme_bw()

ggsave("Resultados/boxplotRend.png",brend,height = 4,width = 6)

?ggsave

# Histograma de frecuencias

ggplot(trigo,aes(x=Rend))+geom_histogram(bins = 15,colour = "black", fill = "honeydew2")+
  ggtitle("Histograma de rendimiento")+theme_bw()


# Grafico de dispersion

ggplot(trigo,aes(x=tiemp,y=Rend))+geom_point()+geom_smooth()+
  facet_grid(ubicacion~.)

# Grafico de burbujas

iris

head(iris)
summary(iris)

p.iris <- ggplot(iris,aes(x=Sepal.Length,y=Petal.Length)) + 
  geom_point(aes(color=Species,size= Petal.Width),alpha = 0.7)+theme_bw()

ggsave("Resultados/plotiris.png",p.iris,height = 4,width = 5)


################################################################################

# Library

# install.packages("fmsb")

library(fmsb)


# Create data: note in High school for Jonathan:

data <- as.data.frame(matrix( sample( 2:20 , 10 , replace=T) , ncol=10))

colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding", "data-viz" , "french" , "physic", "statistic", "sport" )

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
data <- rbind(rep(20,10) , rep(0,10) , data)

# Check your data, it has to look like this!
# head(data)

# The default radar chart 
radarchart(data)

airquality

ggplot(airquality,aes(x=Day,y=Ozone )) + geom_point() +
  facet_grid(Month~.)

ggplot(airquality,aes(x=Day,y=Ozone )) +
  geom_line(aes(colour = factor(Month)))


