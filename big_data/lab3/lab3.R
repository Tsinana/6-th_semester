setwd("C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab2")
par(mar=c(20,4,4,4))
#Выгрузка данных
df<-read.csv("csv_for_lab2.csv", sep=";", header=T, fileEncoding="cp1251")
View(df)

#Выполнить сортировку наборов данных по выбранному признаку.
medianspicy = apply(df[3:12],2, FUN = median)
spicy_name = colnames(df[-c(1,2)])
df.median = data.frame(spicy_name,medianspicy)
medians <- with(df.median, order(df.median$spicy_name, decreasing = F)) # Equivalent


df1 = df[c(-1,-2)]
newdf = df1[order(colnames(df1),decreasing = T)]
n =newdf[2,2]
boxplot(newdf,density = 20, col = "red",
        horiz = T,las = 2)
hist(newdf[1])
#Сформировать отдельные наборы данных по одинаковому признаку
dfp = subset(df,Pudow >=6,select=c('ФИО','Pudow'))
summary(df[3:12])
barplot(height=dfp$Pudow, names=dfp$ФИО, col=rgb(0.2,0.4,0.6,0.6),las=2)

