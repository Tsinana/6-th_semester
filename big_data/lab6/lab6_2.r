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

#
col_with_value = grep("yes_value", names(acticity))


#Стандартизация переменных нет необходимости, тк кк значения представляют собой процент 
#Смотрим на разницу результатов в зависимости от df
dist.df_all = dist(acticity_full[,col_with_value])

clust.df_all = hclust(dist.df_all,"ward.D")
plot(clust.df_all)

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


df = data.frame(acticity_full[,col_with_value],factor(groups))
                 

library(klaR)
naive_df <- NaiveBayes(df$factor.groups. ~ ., data = df)
naive_df$tables



opar=par()
par(mfrow=c(2,2))
plot(naive_df,lwd = 2)
legend("topright",inset = c(-0.42, 0), legend=c("setosa", "versicolor", "virginica"),lty=1:3, cex=0.5)
par = opar

a =  naive_df
pred <- predict(naive_df, df[, -5])

(table(Факт = df$factor.groups., Прогноз = pred)) 
Acc <- mean(pred == df$factor.groups.)

head(df)

set.seed(1234)
ind <- sample(2, nrow(df), replace=TRUE, prob=c(0.7, 0.3))
trainData <- df[ind==1,]
testData <- df[ind==2,]
nrow(trainData)             # [1]       112 
nrow(testData)              # [1]        38 
nrow(df) 

myFormula <- factor.groups. ~ PAINDX2_yes_value  + PASTAE2_yes_value + PASTRNG_yes_value  + TOTINDA_yes_value
act_ctree <- ctree(myFormula, data=trainData)

pred <- predict(act_ctree, df[, -5])
table(predict(act_ctree), trainData$factor.groups.)
Acc <- mean(pred == df$factor.groups.)

plot(act_ctree)

library(randomForest)
rf <- randomForest(factor.groups. ~ .,data=trainData, ntree=100, proximity=TRUE)
table(predict(rf), trainData$factor.groups.)
pred <- predict(rf, df[, -5])
Acc <- mean(pred == df$factor.groups.)

a = data.frame(head(df))
