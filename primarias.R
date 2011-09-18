# File-Name:       primarias.R
# Date:            18.09.11
# Author:          Federico Carlés
# Email:           fedecarles@gmail.com                                      
# Data:            BA.csv, Junta Electoral de Buenos Aires
# Packages Used:   sp, maptools, RColorBrewer

#Indicamos el working directory
setwd("C:/Documents and Settings/carles/My Documents/R")

#Carga de librerias
library (sp)
library (RColorBrewer)
library (maptools)

#Carga de mapa y datos.
result<-read.csv("Mapas/BA.csv", sep=";")
mapa<-readShapeSpatial("ARG/BA/BA_PROV.shp")

#Calculo de porcentajes.
total<-result$TOT
fpv<-result$FPV
udeso<-result$UDESO
fpv_pct<- fpv*100/total
udeso_pct<- udeso*100/total

#Creación de factores.
fpv_pct_f<-cut(fpv_pct, breaks=seq(0,100,20),include.lowest=T)
udeso_pct_f<-cut(udeso_pct, breaks=seq(0,100,20),include.lowest=T)

#Carga de factores al mapa
mapa$fpv<-fpv_pct_f
mapa$udeso<-udeso_pct_f
mapa$fp<-fp_pct_f

#Creamos la paletas de colores. Es importante que la cantidad de colores sea
#igual a la cantidad de niveles de nuestro factor. O sea, 
#con breaks de 20 necesitamos 5 colores.
colfpv<-brewer.pal(5,"Blues")
coludeso<-brewer.pal(5,"Reds")

#Ploteo del mapa

png("PASO_BA.png", width=630, height=630, bg="grey50")

par <- list(axis.line=list(col="transparent"),
clip=list(panel="off"), par.main.text=list(col="black"), 
axis.text=list(col="black"), fontsize=list(text=12))

spplot(mapa, "fpv", col.regions=colfpv, col="grey15",
 main=list(label="INT. MUNICIPAL, CONCEJALES Y
CONSEJEROS - PASO 2011 - FPV"), res=88, par.settings = par)


spplot(mapa, "udeso", col.regions=coludeso, col="grey15",
 main=list(label="INT. MUNICIPAL, CONCEJALES Y
CONSEJEROS - PASO 2011 - UDESO"),
 res=88, par.settings = par)

dev.off()

