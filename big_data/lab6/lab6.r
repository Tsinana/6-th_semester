setwd("C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab6/19_Физ_активность в США")

#Выгрузка данных
location_id<-read.csv("BRFSS location_id KEY.csv", sep=",", header=T, fileEncoding="cp1251")
activity_columns<-read.csv("BRFSS Physical Activity columns KEY.csv", sep=",", header=T, fileEncoding="cp1251")
acticity<-read.csv("BRFSS Physical Acticity.csv", sep=",", header=T, fileEncoding="cp1251")

# 2021,2020,2019!,2018,2017!,2016,2015!

acticity_2020 <- data.frame(acticity[acticity[3]==2020,])

acticity_full <- data.frame(acticity[is.na(acticity[4]),])
acticity_unfull <- data.frame(acticity[!is.na(acticity[4]),])

#сделать анализ по годам и по штатам