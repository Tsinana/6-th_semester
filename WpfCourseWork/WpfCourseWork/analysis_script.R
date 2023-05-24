setwd("C:/Users/Tsinana/GitHub/6-th_semester/WpfCourseWork/WpfCourseWork/analysis")
opar = par(no.readonly = TRUE)

#Подготовка к работе
a<-as.matrix(read.csv("a.csv",header = FALSE))[1,]
temp<-as.matrix(read.csv("temp.csv",header = FALSE))[1,]
cf<-as.matrix(read.csv("cf.csv",header = FALSE))[1,]

a <- head(a, -1)
temp <- head(temp, -1)
cf <- head(cf, -1)

cf <- matrix(cf, nrow = length(a), ncol = length(temp))

library(plotly)
fig <- plot_ly(
  type = 'surface',
     x = ~a,
  y = ~temp,
  z = ~cf)

fig
