
# Inferencia estadistica
# Hugo Andres Dorado
# 09-08-2021

library(ggplot2)
library(dplyr)

?rnorm

norm.pob <- rnorm(n = 1000,mean = 9000,sd= 500 )

norm.pob

hist(norm.pob)

exp.pob <- rexp(n=1000,rate=300)

hist(exp.pob)

# Estimación puntual

n <- 30

# set.seed(123)

for(i in 1:10)
{
  muestra.norm <- sample(norm.pob,n)

  print(mean(muestra.norm))
}

# Intevalos de confianza

t.test(muestra.norm)

# Simular una base de datos muestra

# Contruccion de una base de datos simulada

n <- 50

set.seed(123)

sogata <- sample(0:1,n,p=c(0.8,0.2),replace = T)

tratamiento <- c(array("a",25),array("b",25))

rendimiento <- c(rnorm(25,6200,400),rnorm(25,8000,800))

calidad <- runif(n,20,100)

agricultura <- data.frame(id=1:50,sogata,tratamiento, rendimiento, calidad)

agricultura

#-------------------------------------------------------------------------------

# Pruebas para las proporciones

960/1700

agricultura

# proporcion de ciclos de cosecha que tuvieron sogata

pro.sogata <- sum(agricultura$sogata)
n <- nrow(agricultura)

pro.sogata/n

# h0: P < 0.25 : No aplico
# ha: P > 0.25 : Aplico

p.tests <- prop.test(x = pro.sogata, p=0.25,n=n,alternative = "greater",
                     conf.level = 0.95)

p.tests

alpha = 0.05

# Rechazo si valor p < alpha

# Valor p = 0.628 > alpha 0.05, No rechazo h0, No aplico

p.tests$conf.int

p.tests$p.value

# Prueba 2, max exigente

# Ho: P < 0.10 No aplico
# Ha: P > 0.10 Si aplica

p.tests <- prop.test(x = pro.sogata, p=0.10,n=n,alternative = "greater",
                     conf.level = 0.95)

p.tests

alpha = 0.05

# Rechazo si valor p < alpha

# Valor p = 0.004761 < alpha 0.05, rechazo h0, Si aplico

# Intevalo cerrado

p.tests <- prop.test(x = pro.sogata, p=0.10,n=n,alternative = "two.sided",
                     conf.level = 0.95)

p.tests

#-------------------------------------------------------------------------------

# Prueba para la media o medias

# Ho: mu > 7000 Mantengo mi paquete tecnologico
# Ha: mu < 7000 Cambio mi paquete tecnologico

rendimiento <- agricultura$rendimiento

t.test(x = rendimiento,alternative = "less",mu=7000)

# Rechazo si valor p < alpha

# Valor p = 0.7913 > alpha = 0.05, no rechazo h0, Mantengo el paquete tecnologico

# comparacion de medias de dos poblaciones

agricultura %>% ggplot(aes(x=tratamiento ,y=rendimiento)) +geom_boxplot()

# ¿Es mas efectivo alguno de los tratamientos en comparacion con otro?

# mua - mub = 0 escogeria cualquiera
# mua - mub != 0 escogería el b 

ttest <- t.test(rendimiento~tratamiento,data = agricultura,mu = 0,
                alternative = "two.sided",paired = FALSE,var.equal = F,
                conf.level = 0.90)

ttest

# Rechazo si valor p < alpha

#-------------------------------------------------------------------------------

# Comparacion de varianzas

# vara/varb = 1 # Las varianzas son iguales para ambos tratamientos
# vara/varb != 1 # Las varianzas son diferentes para ambos tratamientos

vartest <- var.test(rendimiento~tratamiento,data = agricultura)

vartest

# Otro paquete para inferencia estadtistica

library(infer)

F_hat <- agricultura %>% 
  specify(rendimiento~tratamiento) %>%
  calculate(stat = "F")


null_distn <- agricultura %>%
  specify(rendimiento~tratamiento) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "F")

visualize(null_distn) +
  shade_p_value(obs_stat = F_hat, direction = "greater")

null_distn %>%
  get_p_value(obs_stat = F_hat, direction = "greater")

#-------------------------------------------------------------------------------

# Barras de error

# http://www.sthda.com/english/wiki/ggplot2-error-bars-quick-start-guide-r-software-and-data-visualization

data_summary <- function(data, varname, groupnames){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE),n = length(x[[col]]),
      delta=1.96*sd(x[[col]], na.rm=TRUE)/sqrt(n))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

df2 <- data_summary(agricultura,varname = "rendimiento",
                    groupnames = c("tratamiento","sogata"))

p<- ggplot(df2, aes(x=tratamiento , y=rendimiento,fill=factor(sogata))) + 
  geom_bar(stat="identity", color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=rendimiento-delta, ymax=rendimiento+delta), width=.2,
                position=position_dodge(.9)) 
p


#-------------------------------------------------------------------------------

# Prueba formal de correlación de pearson

agricultura

?cor.test

# H0: p(x,y) = 0 ; La variable calidad es independiente del rendimiento
# Ha: p(x,y) != 0 ; Existen una correlación lineal entre calidad y rendimiento

cor(agricultura$rendimiento,agricultura$calidad)

plot(agricultura$rendimiento,agricultura$calidad)

cor.test(agricultura$rendimiento,agricultura$calidad)

# Rechazo ho si valor p = 0.04028  < alpha = 0.05


###############################################################################
# Pruebas no parametricas

# Prueba binomial

agricultura

Si_sogata <- sum(agricultura$sogata)

No_sogata <- nrow(agricultura) - Si_sogata

Ho: p = 0.5 # Aplico tratamiento
Ha: p != 0.5 # No aplico tratamiento

?binom.test

binom.test(x=c(Si_sogata,No_sogata),p=0.5)

# Test de Kolmogorov smirno

?ks.test

agricultura

rendim_trat <- split(agricultura$rendimiento,agricultura$tratamiento)

rendim_trat

# Ho: Los datos provienen de una distribucion normal
# Ha: Los datos no provienen de una distribución normal

ks.test(rendim_trat$a,"pnorm",mean(rendim_trat$a),sd(rendim_trat$a))

# Rechazo ho si valop < alpha

ks.test(rendim_trat$b,"pnorm",mean(rendim_trat$b),sd(rendim_trat$b))

# Otro prueba de normalidad 
?shapiro.test

shapiro.test(rendim_trat$a)

shapiro.test(rendim_trat$b)

#-------------------------------------------------------------------------------
# Comparacion de medianos utilizando wilconxos o u man witney

agricultura

# Ho: me(a) - me(b) = 0
# Ha: me(a) - me(b) !=0 

boxplot(rendimiento~tratamiento,data=agricultura)

wilcox.test(rendimiento~tratamiento, data = agricultura,paired = F)

boxplot(calidad~tratamiento,data=agricultura)

wilcox.test(calidad~tratamiento, data = agricultura,paired = F)

#-------------------------------------------------------------------------------
# Prueba chi cuadrado

agricultura

table(agricultura$sogata,agricultura$tratamiento)

# H0: No hay asociacion entre ambas variables
# HA: Si hay asociacion entre ambas variables

chisq.test(factor(agricultura$sogata),agricultura$tratamiento)

?chisq.test

fisher.test(factor(agricultura$sogata),agricultura$tratamiento)

# Correlacion de spearman

# H0: p(x,y) = 0 ; La variable calidad es independiente del rendimiento
# Ha: p(x,y) != 0 ; Existen una correlación lineal entre calidad y rendimiento

cor.test(agricultura$rendimiento,agricultura$calidad,method = "spearman")





