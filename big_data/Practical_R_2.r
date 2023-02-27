x = c(123,134,145,167,39)
m = c('M','M','W','M','CAT')
x.f = factor(x)
m.f = factor(m)
 is.character(x.f)
 is.character(m.f)
 is.factor(x.f)
 is.factor(m.f)
 plot(m.f)
w = c(69,68,93,76,10)
plot(w,x,pch = as.numeric((m.f)),col = as.numeric(m.f))
legend("topleft",pch=1:3,col = 1:3,legend =levels(m.f))
t = c('XXS','XXS','XS','S','XXXXXS')
t.f = factor(t)
t.o=ordered(t.f,levels = c('XXXXXS','XXS','XS','S'))
h = c(8,20,NA,NA,2)
mean(h,na.rm = TRUE)
mean(na.omit(h))
a = c(1,1,1,2,2,3,2,1,5,1)
mean(a)
h[is.na(h)] <- mean(na.omit(h))
names = c('Олег','Олег','Жея','Олег','Кошка')
df = data.frame(weight = w,height = x, size = t.o,sex = m.f)
df[,1]
df[[1]]
df[,"weight"]
df[df$sex=='W',]
df[order(df$sex,df$height),]
