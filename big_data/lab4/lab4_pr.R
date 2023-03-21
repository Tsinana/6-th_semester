num<-c(1:10)
square<-num*num
plot(num,square,type="b")
help(plot)
par(no.readonly = T)
opar <- par(no.readonly=TRUE) # создает копию текущих параметров
par(lty=2, pch=17)            # назначает тип линии – пунктирная (lty=2) вместо  
#сплошной по умолчанию и тип символа – заполненный треугольник (pch=17)
plot(num,square,type="b")
par(opar) 			 #восстановление исходных значений параметров

n <- 10
mycolors <- rainbow(n)
pie(rep(1, n), labels=mycolors, col=mycolors) # Круговая диаграмма 
mygrays <- gray(0:n/n)
pie(rep(1, n), labels=mygrays, col=mygrays)
windows()
Sys.setlocale("LC_ALL","En")

windowsFonts(A=windowsFont('Arial Black'),B=windowsFont('Bookman Old Style'),C=windowsFont('Comic Sans MS'))

opar <- par(no.readonly=TRUE)      
par(pin=c(2, 3))                    
par(lwd=2, cex=1.5)            
par(cex.axis=.75, font.axis=3)      
plot(num, square, type="b", pch=19, lty=2, col="red")    
plot(num, square, type="b", pch=23, lty=6, col="blue", bg="green")
par(opar)

plot(num, square, type="b",  
           col="green", lty=2, pch=2, lwd=2,
           main="Квадратичная зависимость", 
           sub="Просто квадрат числа", 
           xlab="Month", ylab="Квадрат числа",
           xlim=c(0, 12), ylim=c(0, 300))
plot(num, square, type="b",  ann=FALSE,
             col="green", lty=2, pch=2, lwd=2,
             xlim=c(0, 12), ylim=c(0, 300))

 title(main="Квадратичная зависимость", col.main="red", 
               sub="Просто квадрат числа", col.sub="blue", 
               xlab="Month", ylab="Квадрат числа",
               col.lab="green", cex.lab=1)
