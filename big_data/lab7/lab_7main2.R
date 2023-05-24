setwd("C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab7/")
opar = par(no.readonly = TRUE)

athlete_events<-read.csv("athlete_events.csv", sep=",", header=T, fileEncoding="cp1251")

df = athlete_events[athlete_events$Sport == 'Football' | athlete_events$Sport == 'Volleyball',]
df = df[df$Sex == 'F',]
df = na.omit(df)

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

par(mfrow=c(1,2))
hist(df$Weight)
boxplot(df$Weight)
par(opar)

#Ты норм?
library(car)
qqPlot(df$Weight)
shapiro.test(df$Weight)

#Ты дисп?
bartlett.test(Weight~Sport, data=df)


tapply(df$Weight, df$Sport, mean)

t.test(df$Weight ~ df$Sport)

t.test(df$Weight ~ df$Sport, paired = FALSE, var.equal = TRUE)
