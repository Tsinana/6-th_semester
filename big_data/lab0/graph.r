x = c(1:10)
y = x
z = 10 / x
opar = par(no.readonly = TRUE)
par(mar = c(5,4,4,8) + .1 )
plot(x, y, type = 'b',pch = 21, col = 'red', yaxt = 'n',lty = 3, ann = FALSE)
lines(x, z, type = "b", pch = 22, col = 'blue',lty = 2)

axis(2, at = x, labels = x, col.axis = 'red', las = 2)
axis(4, at = z, labels = round(z, digits = 2), col.axis = 'blue', las = 2, cex.axis = 0.7, tck = -.01)
mtext('y = 1 / x', side = 4, line = 3, cex.lab = 1, las = 2)
title('simple primer',xlab = '3na4 X',ylab = 'y=x')
par(opar)

attach(mtcars)
opar <- par(no.readonly=TRUE)

par(mfrow=c(2,2)) # будет четыре графика

plot(wt,mpg, main="Диаграмма рассеяния для \n расхода топлива и веса машины")
plot(wt,disp, main="Диаграмма рассеяния для \n объема двигателя и веса машины")
hist(wt, main="Распределение  значений \n веса машины")
boxplot(wt, main="Ящик-с-усами \n для веса машины")

par(opar)
detach(mtcars)

