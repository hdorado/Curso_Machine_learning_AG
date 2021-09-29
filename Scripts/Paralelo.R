
# Ejecutar procesos en paralelo
# Hugo Andres Dorado
# 23/08/2021

library(parallel)
library(doParallel)
library(foreach)

detectCores()

mtcars

dim(mtcars)

ind <- sample(1:32,100,replace = T)

ind

result <- lm(mpg~cyl,data = mtcars[ind,])

r <- coefficients(result)

r


set.seed(123)


trial <- 1000

res <- data.frame(Intercep = "", Beta1 = "")

system.time(
  for(i in 1:trial){
    ind <- sample(1:32,100,replace = T)
    result <- lm(mpg~cyl,data = mtcars[ind,])
    r <- coefficients(result)
    res <- rbind(res,r)
  }
  
)

res[,-1]


# Lapply


boosLm <- function(trial){
  ind <- sample(1:32,100,replace = T)
  result <- lm(mpg~cyl,data = mtcars[ind,])
  r <- coefficients(result)
  res <- data.frame(Intercept = r[1],Beta1 = r[2])
}

system.time(
  results <- lapply(1:trial,boosLm)
)

do.call(rbind,results)

library(parallel)

trial_seq <- 1:trial

system.time(
  results <- mclapply(trial_seq,boosLm,mc.cores = 1)
)

do.call(rbind,results)

# do.par

registerDoParallel(3)

system.time(
  r <- foreach(icount(trial) , .combine = rbind) %dopar% {
    ind <- sample(1:32,100,replace = T)
    result <- lm(mpg~cyl,data = mtcars[ind,])
    r <- coefficients(result)
    data.frame(Intercept = r[1],Beta1 = r[2])
  }
)

r

stopImplicitCluster()

