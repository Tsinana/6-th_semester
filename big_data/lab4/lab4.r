setwd("C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab4")
attach(mtcars)

#Выгрузка данных
df_Türkiye_in_sailing<-read.csv("tb.csv", sep=";", header=T, fileEncoding="cp1251")
df_Türkiye<-read.csv("tb30Yeaers.csv", sep=",", header=T, fileEncoding="cp1251")
df_6_olympiads<-read.csv("tb6Olimp!.csv", sep=";", header=T, fileEncoding="cp1251")
df_6_olympiads_ceiling<-read.csv("tb6OlimpCeiling.csv", sep=",", header=T, fileEncoding="cp1251")
df_6_olympiads_ceiling = data.frame(df_6_olympiads_ceiling[1:3])
df_6_olympiads_ceiling = data.frame(df_6_olympiads_ceiling[1:6,])
teal = '#008080'
opar = par(no.readonly = TRUE)


#<столбчатую диаграмму по количеству мест>
par(oma = c(1, 1, 1, 1))
y = df_Türkiye_in_sailing$Количество
x = df_Türkiye_in_sailing$место
plot(x, y, type = 'h', ann = FALSE , yaxt = 'n', lwd = 5,col = teal)
grid(lty="dotted")
axis(2, at = y, labels = y, las = 2)
title('Рузальтаты Турции\nпо Парусному спорту за 30 лет',xlab = 'Места',ylab = 'Количество')
par(opar)
#----------


#<>
BestM = df_Türkiye$Золото.М + df_Türkiye$Серебро.М + df_Türkiye$Бронза.М
BestAll = BestM + df_Türkiye$Золото.Ж + df_Türkiye$Серебро.Ж + df_Türkiye$Бронза.Ж
years = substr(df_Türkiye$Летние.ОИ, 1, 4)

par(oma = c(1, 1, 1, 1))

plot(BestAll, type = 'h', ann = FALSE , xaxt = 'n',yaxt = 'n', lwd = 5,col = teal)
grid(lty="dotted")
axis(1, at = c(1:length(years)), labels = years, col.axis = 'black', las = 2)
axis(2, at = BestAll, labels = BestAll, las = 2)
title('Количество призовых мест Турции за 30 лет',xlab = 'Год',ylab = 'Количество')
par(opar)
#----------


#<>
par(oma = c(1, 1, 1, 1))
x = df_Türkiye$Золото.М + df_Türkiye$Золото.Ж
names = df_Türkiye$Летние.ОИ
pie(x, labels = names)
title("Количество первых мест\nв каждой из олимпиад")
par(opar)
#----------


#<>
par(oma = c(1, 1, 1, 1))

BestM = df_Türkiye$Золото.М + df_Türkiye$Серебро.М + df_Türkiye$Бронза.М
BestW = df_Türkiye$Золото.Ж + df_Türkiye$Серебро.Ж + df_Türkiye$Бронза.Ж

x = substr(df_Türkiye$Летние.ОИ, 1, 4)
xrange = c(1, length(x))
yrange = range(BestM,BestW)
plot(xrange, yrange, type = 'n', yaxt = 'n',xaxt = 'n', ann = 0) 

points( BestM, pch=20, col="red3") 
lines(BestM, pch=20, col="red3") 

points( BestW, pch=22, col="blue") 
lines(BestW, pch=22, col="blue")

grid(lty="dotted")
axis(1, at = c(1:length(x)), labels = x, col.axis = 'black', las = 2)
axis(2, at = c(0:yrange[2]), col.axis = 'black', las = 2)
title("Tенденции изменения\nколичества призовых мест ",xlab = 'Год', ylab = 'Кол-во призовых мест')
legend("topright", inset=.01, c("M","W"),lty=c(1, 2), pch=c(21, 22), col=c("red", "blue")) 

par(opar)
#----------

#<0 olympiad>
par(mfrow=c(2,2))

years = c(2020,2016,2012,2008,2004,2000)
achv = range(df_6_olympiads[2:19])
plot(c(1,6), achv, type = 'n', yaxt = 'n',xaxt = 'n', ann = 0) 
df_6_olympiads[1,]

a = as.integer(df_6_olympiads[2,seq(4, ncol(df_6_olympiads), by = 3)])
points(a, pch=20, col="red3") 
lines(a, pch=20, col="red3") 
a = as.integer(df_6_olympiads[1,seq(4, ncol(df_6_olympiads), by = 3)])
points(a, pch=20, col="blue") 
lines(a, pch=20, col="blue")
a = as.integer(df_6_olympiads[3,seq(2, ncol(df_6_olympiads), by = 3)])
points(a, pch=20, col="#e38698") 
lines(a, pch=20, col="#e38698")
a = as.integer(df_6_olympiads[4,seq(2, ncol(df_6_olympiads), by = 3)])
points(a, pch=20, col="#96aa3d") 
lines(a, pch=20, col="#96aa3d")
a = as.integer(df_6_olympiads[5,seq(2, ncol(df_6_olympiads), by = 3)])
points(a, pch=20, col="#fd7e00") 
lines(a, pch=20, col="#fd7e00")
a = as.integer(df_6_olympiads[6,seq(2, ncol(df_6_olympiads), by = 3)])
points(a, pch=20, col="#868686") 
lines(a, pch=20, col="#868686")

achv = seq(achv[1], achv[2],by = 5)
grid(lty="dotted")
axis(1, at = c(1:6), labels = years, col.axis = 'black', las = 2)
axis(2, at = achv, col.axis = 'black', las = 2)
title("Tенденции изменения\nколичества золотых медалей 6 олимпиад",xlab = 'Год', ylab = 'Кол-во призовых мест')


years = c(2020,2016,2012,2008,2004,2000)
df_6_olympiads1 = df_6_olympiads
df_6_olympiads <- data.frame(df_6_olympiads[1], rowSums(df_6_olympiads[, 2:4]), rowSums(df_6_olympiads[, 5:7]),rowSums(df_6_olympiads[, 8:10]),rowSums(df_6_olympiads[, 11:13]),rowSums(df_6_olympiads[, 14:16]),rowSums(df_6_olympiads[, 17:19]))

achv = range(df_6_olympiads[2:7])
plot(c(1,6), achv, type = 'n', yaxt = 'n',xaxt = 'n', ann = 0) 

a = as.integer(df_6_olympiads[2,2:7])
points(a, pch=20, col="red3") 
lines(a, pch=20, col="red3") 
a = as.integer(df_6_olympiads[1,2:7])
points(a, pch=20, col="blue") 
lines(a, pch=20, col="blue")
a = as.integer(df_6_olympiads[3,2:7])
points(a, pch=20, col="#e38698") 
lines(a, pch=20, col="#e38698")
a = as.integer(df_6_olympiads[4,2:7])
points(a, pch=20, col="#96aa3d") 
lines(a, pch=20, col="#96aa3d")
a = as.integer(df_6_olympiads[5,2:7])
points(a, pch=20, col="#fd7e00") 
lines(a, pch=20, col="#fd7e00")
a = as.integer(df_6_olympiads[6,2:7])
points(a, pch=20, col="#868686") 
lines(a, pch=20, col="#868686")

achv = seq(achv[1], achv[2],by = 20)
grid(lty="dotted")
axis(1, at = c(1:6), labels = years, col.axis = 'black', las = 2)
axis(2, at = achv, col.axis = 'black', las = 2)
title("Tенденции изменения\nколичества призовых мест 6 олимпиад",xlab = 'Год', ylab = 'Кол-во призовых мест')
#legend("topright", inset=.001, df_6_olympiads$Страна, lty = 1, col=c("red3", "blue","#e38698","#96aa3d","#fd7e00","#868686")) 
df_6_olympiads = df_6_olympiads1

plot(0,0,type="n", yaxt = 'n',xaxt = 'n',ann =FALSE)
legend("top", inset = .01, df_6_olympiads$Страна, lty = 1, col=c("red3", "blue","#e38698","#96aa3d","#fd7e00","#868686")) 
par(opar)
#----------

#<>
par(oma = c(1, 1, 1, 1))

x = substr(df_Türkiye$Летние.ОИ, 1, 4)

xrange = c(1, length(df_6_olympiads_ceiling[,1]))
yrange = range(df_6_olympiads_ceiling[2:3])

plot(xrange, yrange, type = 'n', yaxt = 'n',xaxt = 'n', ann = 0) 

points( df_6_olympiads_ceiling[2], pch=20, col="red3") 
lines(df_6_olympiads_ceiling[2], pch=20, col="red3") 

points( df_6_olympiads_ceiling[3], pch=22, col="blue") 
lines(df_6_olympiads_ceiling[3], pch=22, col="blue")

grid(lty="dotted")
axis(1, at = c(1:length(df_6_olympiads_ceiling[,1])), labels = df_6_olympiads_ceiling[,1], col.axis = 'black', las = 2)
axis(2, at = c(0:yrange[2]), col.axis = 'black', las = 2)
title("Tенденции изменения\nколичества призовых мест ",xlab = 'Год', ylab = 'Кол-во призовых мест')
legend("topright", inset=.01, c("MAN","WEMEN"),lty=c(1, 2), pch=c(21, 22), col=c("red", "blue")) 
par(opar)
#----------

#<>
par(mfrow=c(2,2))

par(oma = c(1, 1, 1, 1))
names = df_6_olympiads_ceiling$п.їY
pie(df_6_olympiads_ceiling[,2], labels = names)
title("Количество мужских призовых мест")

names = df_6_olympiads_ceiling$п.їY
pie(df_6_olympiads_ceiling[,3], labels = names)
title("Количество женских призовых мест")

y = df_6_olympiads_ceiling$M
x = df_6_olympiads_ceiling$п.їY
plot(x, y, type = 'h', ann = FALSE , yaxt = 'n', lwd = 5,col = teal)
grid(lty="dotted")
axis(2, at = y, labels = y, las = 2)
title('Рузальтаты мужчин GB\nпо Парусному спорту за 6 олимпиад',xlab = 'Год',ylab = 'Количество призовых мест')

y = df_6_olympiads_ceiling$W
x = df_6_olympiads_ceiling$п.їY
plot(x, y, type = 'h', ann = FALSE , yaxt = 'n', lwd = 5,col = teal)
grid(lty="dotted")
axis(2, at = y, labels = y, las = 2)
title('Рузальтаты женщин GB\nпо Парусному спорту за 6 олимпиад',xlab = 'Год',ylab = 'Количество призовых мест')
par(opar)
#----------