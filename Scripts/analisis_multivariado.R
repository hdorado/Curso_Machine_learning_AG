
# Analisis de datos multivariado
# Hugo Andres Dorado
# 10/08/2021 

library(FactoMineR)
library(agridat)
library(dplyr)
library(tidyr)
library(tibble)

data <- australia.soybean
?australia.soybean

head(data)

data <- data %>% select(gen:oil) %>% pivot_longer(cols = yield:oil,
                                                  names_to = "Variable",
                                                  values_to = "Values")

data <- data %>% group_by(gen,Variable) %>% dplyr::summarise(Media = mean(Values))

data <- data %>% pivot_wider(id_cols = 'gen',names_from = "Variable",values_from = Media)

data

plot(data[,1:7])

data <- data %>% column_to_rownames(var = "gen")

head(data)

data$Group <- c(array("a",20),array("b",20),array("c",18))

res.PCA <- PCA(data,scale.unit = T,ncp = 3, quali.sup = 7)

res.PCA$eig

plot.PCA(res.PCA,axes = c(1,3),choix ='var')

res.PCA$var

head(data)

head(res.PCA$ind$coord)

head(res.PCA$ind$contrib)

dimdesc(res.PCA)

plotellipses(res.PCA)


# Analisis de corresponcia multiple

data(tea)

head(tea)

names(tea)

res.MCA <- MCA(tea,quanti.sup = 19,quali.sup = 20:36)

res.MCA$eig

plot.MCA(res.MCA, invisible=c("var","quali.sup"), cex=0.7)
plot.MCA(res.MCA, invisible=c("ind","quali.sup"), cex=0.7)
plot.MCA(res.MCA, invisible=c("ind"))
plot.MCA(res.MCA, invisible=c("ind", "var"))

res.MCA$var

# Analisis cluster

data

res.hcpc <- HCPC(res.PCA,nb.clust = 3)

res.hcpc$data.clust

res.hcpc$desc.var$quanti

# Reduccion de dimensiones con R-tsne

library(Rtsne)

tsne <- Rtsne(data, pca= FALSE, dims = 2, perplexity=10,  max_iter = 500)

plot(tsne$Y, asp=1, main = "t-SNE",col=as.factor(data$Group)) # 

# Modelo de regresion lineal multiple

airquality

lm.simple <- lm(Ozone ~ Temp, data = airquality)

lm.simple

summary(lm.simple)

?lm

lm.multiple <- lm(Ozone~. ,  data = airquality)

summary(lm.multiple)

lm.multiple$residuals

plot(lm.multiple)

shapiro.test(lm.multiple$residuals)

library(car)

boxCox(lm.multiple)

airquality2 <- airquality

airquality2$Ozone <- airquality2$Ozone^0.2

lm.multiple2 <- lm(Ozone~. ,  data = airquality2)

layout(matrix(1:4,2,2))

plot(lm.multiple2)

shapiro.test(lm.multiple2$residuals)

# Modelo de seleccion de atributos

lm.seleccion <- step(lm.multiple2)
?step

summary(lm.seleccion)

AIC(lm.multiple2)

lm.normal <- lm(Ozone~Solar.R +Wind+Temp,data=airquality2 )

lm.inter <- lm(Ozone~Solar.R +Wind*Temp,data=airquality2 )
summary(lm.inter)

AIC(lm.normal)
AIC(lm.inter)

anova(lm.normal,lm.inter)

# Analisis de varianza

library(agricolae)

data(sweetpotato)

sweetpotato


# H0: mu1 = mu2 = mu3 = mu4  No hay efecto del virus
# HA: mui != muj Si hay efecto del virus 


aov.sp <- aov(yield  ~ virus, data = sweetpotato)

summary(aov.sp)

library(ggplot2)
library(dplyr)

sweetpotato %>% ggplot(aes(x=virus,y=yield))+geom_point()

# Test pos anova

tukey <- LSD.test(aov.sp,"virus")

tukey

HSD.test(aov.sp,"virus",console = T)

TukeyHSD(aov.sp)

exper <- read.csv("Datos/Diseño_factorial_bloque.csv")

exper

aov.exp <- aov(yield ~ block + clone*nitrogen ,data=exper)

summary(aov.exp)

plot(aov.exp)

LSD.fisher <- LSD.test(aov.exp,c("clone","nitrogen"),console = T)






