data(iris)
fix(iris)
labels_iris <- iris[,5] 
iris_C <- iris[,-5]

maxs <- apply(iris_C, 2, max)
mins <- apply(iris_C, 2, min)
iris_C <- scale(iris_C, center = mins, scale = maxs - mins)

dist.iris <- dist(iris_C)

clust.iris <- hclust(dist.iris, "ward.D")

plot(clust.iris)

#  Вектор groups содержит номер кластера, в который попал классифицируемый объект 
groups <- cutree(clust.iris, k=3) 

#  Для каждой группы определяем средние значения характеристик и строим датафрейм.

#  в 1-ом кластере
g1<-colMeans(iris[groups==1, 1:4])
#  во 2-ом кластере
g2<-colMeans(iris[groups==2, 1:4])
#  в 3-ем кластере
g3<-colMeans(iris[groups==3, 1:4])

df<-data.frame(g1,g2,g3)
df1<-t(df)
df<-t(df1)
barplot(df, col=c("red","green","blue","yellow")) #  построим график 

library (lattice)

my_data <- iris
head(my_data)

xyplot(Sepal.Length ~ Petal.Length, data = my_data)
xyplot(Sepal.Length ~ Petal.Length, group = Species, data = my_data)
boxplot(Sepal.Length ~ Species, data = iris, ylab = "Sepal.Length",  col = "lightgray")


xyplot(Sepal.Length~Petal.Length+Petal.Width|Species,data=iris, grid = T, auto.key=TRUE)
xyplot(
  Sepal.Length ~ Petal.Length | Species, 
  layout = c(3, 1),               # panel with ncol = 3 and nrow = 1
  group = Species, data = iris,
  type = c("p", "smooth"),        # Show points and smoothed line
  scales = "free"                 # Make panels axis scales independent
)

cloud(Sepal.Length ~ Sepal.Length * Petal.Width, group = Species, data = iris, auto.key = TRUE)

packages <- c('ggplot2', 'dplyr', 'tidyr', 'tibble')
install.packages(packages)
library(ggplot2)
library(dplyr)
library(tidyr)
library(tibble)
iris %>% 
  ggplot(aes(Petal.Length, Petal.Width, color = Species))+geom_point()


