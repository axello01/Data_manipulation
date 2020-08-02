rm(list=ls())

# Editar paths de los puntos 1, 2 y 3

# Escribir todo path entre " " y con barra /

# 1. Directorio de trabajo donde queres el decomp final

setwd("C:/Users/alax7001/Desktop/Amazon_purina/TC/Directorio_TC")

# 2. Path del Varmatch 

varmatch <- read.csv("C:/Users/alax7001/Desktop/Amazon_purina/TC/varmatch.csv", header = TRUE, sep = ",")

# 3. Path del Decomps_Weekly_RptLevels

data1 <- read.csv("C:/Users/alax7001/Desktop/Amazon_purina/TC/Decomps_Weekly_RptLevels_TC_ITERATION_25.csv", header = TRUE, sep = ",")

#...................FIN DE INPUTS..............


#path de la libreria (dejarlo fijo)

.libPaths("/work/mktmix/mix/alax7001/Library_R")





# esto droppea todo lo que no pertenece al decomp.csv

library(data.table)
library(plyr)
library(dplyr)

data2 <- select(data1, -IPweight, -prodkey, -Prodlvl, -geogkey, -Geoglvl, -BRAND, -CATEGORY, -X_Actual, -X_FinlFit, -X_residual, -YEAR_CUR, -YEAR_PRV)

data3 <- select(data2, - Prodname, -Geogname)





t_data3 <- transpose(data3)

data4 <- subset(data2,select=c(Prodname, Geogname))
                
data5 <- data4[-c(nrow(t_data3): nrow(data4)), ]     

tdata33 <- t_data3[-1,]

colnames(tdata33) <- t_data3[1,]

merge1 <- cbind(data5,tdata33)

eventkeys <- data3[1,]

eventkeys2 <- colnames(eventkeys)





data5_5 <- colnames(eventkeys)

data5_5 <- as.data.frame(data5_5)


basevar <- data5_5[-1,]


merge2 <- cbind(basevar, merge1)

basevar <- cbind(basevar, merge2[,2:3] )


merge3 <- cbind(basevar, merge1)


varmatch2 <- varmatch[,2:3]






merge13 <- join(basevar, varmatch2, by ="basevar")

merge13 [] <- lapply(merge13, as.character)

merge13$varname[is.na(merge13$varname)] <- as.character(merge13$basevar[is.na(merge13$varname)])

colnames(merge13) <- c("basevar", "x", "y", "Variable Name")

merge14 <- cbind(merge13[,-2:-3], merge1)

data20 <- merge14[, -1]

data21 <- c("Prodname", "Geogname")

data20 <- data20[, c(data21, setdiff(names(data20), data21) )]

write.csv(data20, file = "decomp_analyzer_iteration0_ip0.csv", row.names = FALSE)









