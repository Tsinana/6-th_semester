#Выгрузка данных
setwd("C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab6/19_Физ_активность в США")
opar = par(no.readonly = TRUE)

#Подготовка к работе
location_id<-read.csv("BRFSS location_id KEY.csv", sep=",", header=T, fileEncoding="cp1251")
activity_columns<-read.csv("BRFSS Physical Activity columns KEY.csv", sep=",", header=T, fileEncoding="cp1251")
acticity<-read.csv("BRFSS Physical Acticity.csv", sep=",", header=T, fileEncoding="cp1251")
years = c(2021,2020,2019,2018,2017,2016,2015)
col_key = c('Участвовал в 150 или более минутах\nаэробной физической активности в неделю',
            'Участвовал в достаточном количестве\nаэробных упражнений и упражнений для укрепления мышц,\nчтобы соответствовать рекомендациям',
            'Участвовал в упражнениях по укреплению мышц\nдва или более раз в неделю',
            'Участвовал в физической активности\nв течение последнего месяца')
acticity_unfull <- data.frame(acticity[is.na(acticity[4]),])
acticity_full <- data.frame(acticity[!is.na(acticity[4]),])

#ящики для каждого года
par(mfrow=c(2,2))
col_with_value = grep("yes_value", names(acticity))
for (col_int in col_with_value) {
  current_df = acticity[, c(3, col_int)]
  boxplot(current_df[,2] ~ current_df[,1],
          main = col_key[col_int/4],
          xlab = "Год",
          ylab = "Значение %",
          col = "orange",
          border = "brown")
  
}
#гисты для каждого города
for (col_int in col_with_value) {
  current_df = acticity[, c(2, col_int)]
  plot(current_df[,2] ~ current_df[,1],
          main = col_key[col_int/4],
          xlab = "Город",
          ylab = "Значение %",
          col = "brown",
          type="h")
}
par(opar)
#min max для городов
for (col_int in col_with_value) {
  current_df = acticity[, c(2, col_int)]
  current_df = na.omit(current_df)
  cat(sprintf("\n\n%s\nfun, Город, Значение (Процент)", col_key[col_int/4]))
  digit = max(current_df[,2], na.rm = TRUE)
  sity =  array(current_df[current_df[,2] == digit,])
  cat(sprintf("\nmax, %s, %0.1f", location_id[location_id[1] == sity[1]][2], sity[2]))
  digit = min(current_df[,2], na.rm = TRUE)
  sity =  array(current_df[current_df[,2] == digit,])
  cat(sprintf("\nmin, %s, %0.1f", location_id[location_id[1] == sity[1]][2], sity[2]))
} 

#Стандартизация переменных нет необходимости, тк кк значения представляют собой процент 
#Смотрим на разницу результатов в зависимости от df
acticity_only_value = acticity[,col_with_value]
acticity_nain0 = replace(acticity_only_value, is.na(acticity_only_value), 0)

dist.df_na.in0 = dist(acticity_nain0)
dist.df_all = dist(acticity_full[,col_with_value])
dist.df_unfall= dist(acticity_unfull[,16])

clust.df_all = hclust(dist.df_all,"ward.D")
plot(clust.df_all)
clust.df_na.in0 = hclust(dist.df_na.in0,"ward.D")
plot(clust.df_na.in0)
clust.df_unfall = hclust(dist.df_unfall,"ward.D")
plot(clust.df_unfall)

#Смотрим на различае в группах
test = acticity_full[,col_with_value]
groups <- cutree(clust.df_all, k=3) 
g1<-colMeans(test[groups==1, 1:4])
g2<-colMeans(test[groups==2, 1:4])
g3<-colMeans(test[groups==3, 1:4])

df<-data.frame(g1,g2,g3)
df1<-t(df)
df<-t(df1)
barplot(df, 
        main = "Groups of act",  
        col=c("red","green","blue","yellow"), 
        beside=TRUE)

#Смотрим на каменную осыпь
length(clust.df_all$height)
plot(1:163, clust.df_all$height, type='b')

#Класторизация
library (lattice)
test = acticity_full[,c(3,col_with_value)]
head(test)
xyplot(PAINDX2_yes_value ~ TOTINDA_yes_value, groups = year, data = test, auto.key = TRUE)


#Класторизация в связи
xyplot(PAINDX2_yes_value ~ PASTAE2_yes_value + PASTRNG_yes_value + TOTINDA_yes_value |year,data=test, grid = T, auto.key=TRUE)
#Класторизация в связи 3D
cloud(PAINDX2_yes_value ~ TOTINDA_yes_value+ PASTRNG_yes_value, group = year, data = test, auto.key = TRUE)

#модный ggplot
packages <- c('ggplot2', 'dplyr', 'tidyr', 'tibble')
#install.packages(packages)
library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
test %>% 
  ggplot(aes(PAINDX2_yes_value, TOTINDA_yes_value, color = year))+geom_point()

a = data.frame(head(acticity))

