library(klaR)
install.packages('klaR')
naive_iris <- NaiveBayes(iris$Species ~ ., data = iris)
naive_iris$tables
naive_iris$tables$Petal.Width

opar=par()
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
plot(naive_iris,lwd = 2)

par=opar 

pred <- predict(naive_iris, iris[, -5])$class
(table(Факт = iris$Species, Прогноз = pred)) 
Acc <- mean(pred == iris$Species)
Acc 

set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]
nrow(trainData)             # [1]       112 
nrow(testData)              # [1]        38 
nrow(iris)                  # [1]        150


install.packages("party")
library(party)
myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(myFormula, data=trainData)

table(predict(iris_ctree), trainData$Species)
plot(iris_ctree)
test_predicted <- predict(iris_ctree, newdata=testData)
table(test_predicted, testData$Species)

install.packages("randomForest")
library(randomForest)
rf <- randomForest(Species ~ .,data=trainData, ntree=100, proximity=TRUE)
table(predict(rf), trainData$Species)
