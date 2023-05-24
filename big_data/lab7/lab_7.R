numb=rnorm(100)

plot(numb,type="h")
hist(numb)
dens <- density(numb)
plot(dens, main = "Сглаженная гистограмма", xlab = "Значения", ylab = "Плотность", type = "l")

summary(numb)

t.test(numb,mu=mean(numb),conf.int=TRUE)
wilcox.test(numb,mu=mean(numb),conf.int=TRUE)

#тест на нормальность
shapiro.test(numb)
qqnorm(numb)
qqline(numb,col=2)

#install.packages('car')
library(car)
qqPlot(numb)

install.packages('ISwR')
library(ISwR)
data(energy)
attach(energy)
tapply(energy$expend, energy$stature, mean)
qqPlot(energy$stature)

bartlett.test(expend~stature, data=energy)

t.test(energy$expend ~ energy$stature)

t.test(energy$expend ~ energy$stature, paired = FALSE, var.equal = TRUE)
