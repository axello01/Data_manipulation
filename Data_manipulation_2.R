C:/Users/alax7001/Desktop/8 de octubre

library(data.table)
library(dplyr)
library(tidyr)
library(base)

sq1 <- fread("C:/Users/alax7001/Desktop/8 de octubre/Shipments_PC_FQ1_2018_from_DL.csv")
sq2 <- fread("C:/Users/alax7001/Desktop/8 de octubre/Shipments_PC_FQ2_2018_from_DL.csv")
sq3 <- fread("C:/Users/alax7001/Desktop/8 de octubre/Shipments_PC_FQ3_2018_from_DL.csv")
sq4 <- fread("C:/Users/alax7001/Desktop/8 de octubre/Shipments_PC_FQ4_2017_from_DL.csv")

total <- rbind(sq1,sq2,sq3,sq4)





total1 <- total[total$`Business Area Description` %in% c("Consumer Volume Desktop", "Volume Desktops", "Volume Notebooks"), ] 



total1$`Shipment Base Extended Quantity`<-as.numeric(gsub(",","",total1$`Shipment Base Extended Quantity`))



as.numeric(total1$`Shipment Base Extended Quantity`)



suma <- aggregate(total1$`Shipment Base Extended Quantity`, by=list(total1$`Business Area Description`,total1$`Profit Center Level 5 Description`),sum)

colnames(suma) <- c("Business Area Description",	"Profit Center Level 5 Description",	"Shipment Base Extended Quantity")

write.csv(suma, file = "Shipment_QUantity_Pais_Producto.csv", row.names = FALSE)