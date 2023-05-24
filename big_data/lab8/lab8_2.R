setwd("C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab8/")
opar = par(no.readonly = TRUE)
#install.packages(pkgs=c("ellipse"))
library(ellipse)
years = c(1989:2017)

data<-read.csv("data.csv", sep=",", header=T, fileEncoding="cp1251")

df = data[data$Country.Code=='USA',]
#a.	Роста ВВП и прироста населения
task1 = df[df$Series.Code=='SP.POP.GROW' | df$Series.Code=='NY.GDP.MKTP.KD.ZG',]
task1 = data.frame(lapply(task1[1:2,5:33], as.numeric))
task1 = t(task1)
colnames(task1) = c('SP.POP.GROW','NY.GDP.MKTP.KD.ZG')
a = data.frame(cor(task1))
#b.	Прироста населения на динамику безработицы
task2 = df[df$Series.Code=='SP.POP.GROW' | df$Series.Code=='SL.UEM.BASC.ZS',]
task2 = data.frame(lapply(task2[1:2,5:34], as.numeric))
task2 = na.omit(t(task2))
colnames(task2) = c('SP.POP.GROW','SL.UEM.BASC.ZS')
a = cor(task2)
#c.	Изменения расходов на медицину и увеличения продолжительности жизни и смертность.
task3 = df[df$Series.Code=='NV.MNF.TECH.ZS.UN' | df$Series.Code=='SP.DYN.CDRT.IN'| df$Series.Code=='SP.DYN.LE00.IN',]
task3 = data.frame(lapply(task3[1:3,5:34], as.numeric))
task3 = na.omit(t(task3))
colnames(task3) = c('NV.MNF.TECH.ZS.UN','SP.DYN.CDRT.IN','SP.DYN.LE00.IN')
a = cor(task3)
#d.	Прирост людей с высшим образованием на рост экспорта товаров и на прирост высокотехнологичного производства. 
task4 = df[df$Series.Code=='BM.GSR.MRCH.CD' | df$Series.Code=='IP.JRN.ARTC.SC'| df$Series.Code=='TX.VAL.TECH.MF.ZS',]
task4 = data.frame(lapply(task4[1:3,5:34], as.numeric))
task4 = na.omit(t(task4))
colnames(task4) = c('BM.GSR.MRCH.CD','IP.JRN.ARTC.SC','TX.VAL.TECH.MF.ZS')
cor(task4)
#d.	Прирост людей с высшим образованием на рост экспорта товаров и на прирост высокотехнологичного производства. 
task5 = df[df$Series.Code=='BM.GSR.MRCH.CD' | df$Series.Code=='IP.JRN.ARTC.SC'| df$Series.Code=='NV.IND.TOTL.KD.ZG',]
task5 = data.frame(lapply(task5[1:3,5:34], as.numeric))
task5 = na.omit(t(task5))
colnames(task5) = c('BM.GSR.MRCH.CD','IP.JRN.ARTC.SC','NV.IND.TOTL.KD.ZG')
cor(task5)
#e.	Расходов на образование на – кумулятивный прирост бакалавров среди женщин 
task6 = df[df$Series.Code=='SE.TER.CUAT.BA.FE.ZS' | df$Series.Code=='IP.JRN.ARTC.SC', ]
task6 = data.frame(lapply(task6[1:2,5:34], as.numeric))
task6 = na.omit(t(task6))
colnames(task6) = c('SE.TER.CUAT.BA.FE.ZS','IP.JRN.ARTC.SC')
cor(task6)
#f.	Прирост людей с высшим образованием на развитие высоких технологий (прирост статей в научных журналах)
task7 = df[df$Series.Code=='SE.TER.CUAT.BA.ZS' | df$Series.Code=='IP.JRN.ARTC.SC', ]
task7 = data.frame(lapply(task7[1:2,5:34], as.numeric))
task7 = na.omit(t(task7))
colnames(task7) = c('SE.TER.CUAT.BA.ZS','IP.JRN.ARTC.SC')
cor(task7)
task7 = data.frame(task7)
#g.	С помощью регрессионного анализа найдите зависимые переменные и
#поясните влияние на них независимых переменных.

fit<- lm(IP.JRN.ARTC.SC ~ SE.TER.CUAT.BA.ZS, data=task7)
fit
summary(fit)
fitted(fit)
residuals(fit)
plot(task7$IP.JRN.ARTC.SC,task7$SE.TER.CUAT.BA.ZS)
abline(fit, col="red")

#h.	С помощью функции predict() (см. лекции и help()) постройте прогноз по любому
#понравившемуся Вам атрибуту.


df <- datasets::cars
my_linear_model <- lm(dist~speed, data = df)
summary(my_linear_model)
fitted(my_linear_model)
residuals(my_linear_model)
lm(formula = dist ~ speed, data = df)
variable_speed <- data.frame(speed = c(11,11,12,12,12,12,13,13,13,13))
predict(my_linear_model, newdata = variable_speed)
predict(linear_model, newdata = variable_speed, interval = 'confidence')

#как в методе
plot(years,df[1,5:33])
plot(years,task1[2,])
