

library(raster)
library(sp)

#Descarga  de world clim. Recuerde rvisar la documentacio con ?getdata

r <- getData("worldclim",var="bio",res=10)

r <- r[[c(1,12)]]

names(r) <- c("Temp","Prec")

#Ubicacion de los puntos en un data frame
lats <- c(14.628434 , 9.396111, 9.161417)
lons <- c(-90.5227, -11.72975, -11.709417)

points <- SpatialPoints(coords, proj4string = r@crs)
values <- extract(r,points)
df <- cbind.data.frame(coordinates(points),values)
df

points <- SpatialPoints(coords, proj4string = r@crs)
values <- extract(r,points)
df <- cbind.data.frame(coordinates(points),values)
df
