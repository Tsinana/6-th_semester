setwd("C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab7/")
opar = par(no.readonly = TRUE)

athlete_events<-read.csv("athlete_events.csv", sep=",", header=T, fileEncoding="cp1251")

df = athlete_events[athlete_events$Sport == 'Sailing',]
df = na.omit(df)

#гист
par(mfrow=c(1,2))
hist(df$Weight)
boxplot(df$Weight)
par(opar)

#НЕТ выбросам
library(dplyr)
Q1 <- quantile(df$Weight, 0.25)
Q3 <- quantile(df$Weight, 0.75)
IQR <- Q3 - Q1
df <-filter(df,df$Weight > Q1 - 1.5*IQR & df$Weight < Q3 + 1.5*IQR)

#гист
par(mfrow=c(1,2))
hist(df$Weight)
boxplot(df$Weight)
par(opar)

#Ты норм?
library(car)
qqPlot(df$Weight)
shapiro.test(df$Weight)


#Проведем тест Стьюдента над этой выборкой
t.test(df$Weight,mu=mean(df$Weight),conf.int=TRUE)
#and ..
wilcox.test(df$Weight,mu=mean(df$Weight),conf.int=TRUE)

