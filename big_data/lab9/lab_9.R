#install.packages("igraph")
#install.packages("network")
#install.packages("sna")
#install.packages("ndtv")

#Создайте кольцевой граф  g со случайным числом вершин 
#G_size (от 25 до 88). 
#Выведите число ребер и вершин  этого графа.
#Постройте граф, выведите его матрицу смежности.
library(igraph)
G_size <- sample(25:88, 1)
g <- graph.ring(G_size)

cat("Число вершин графа:", vcount(g), "\n")
cat("Число ребер графа:", ecount(g), "\n")

adj_matrix <- get.adjacency(g)
print(adj_matrix)

plot(g)

#Создайте  граф g1 из  пустого графа с числом вершин 
#G_size  желтого цвета.
#Добавьте ему 120 случайных ребер,
#сформированных из вектора вершин, 
#окрасьте ребра красным цветом,
#нарисуйте граф и выведите его матрицу смежности.
#Добавьте графу g1 еще  150 случайных ребер,
#сформированных из вектора вершин,
#окрасьте ребра синим цветом,
#нарисуйте граф и выведите его матрицу смежности. 

g1 = graph.empty() + vertices(letters[1:G_size],color="yellow") 
V(g1)$name <- c(1:G_size)

g1 <- g1+edges(sample(V(g1),240,replace=TRUE),color="red")
plot(g1, edge.arrow.size=.2,vertex.size=20) 
g1[]
E(g1)
g1 <- g1+edges(sample(V(g1),300,replace=TRUE),color="blue")
plot(g1, edge.arrow.size=.2,vertex.size=20) 
g1[]

#Добавьте ребра между вершиной 53 и 50, 52 и 30,
#29 и 23, 30 и 31, 22 и 28, окрасьте их в черный цвет 
#Нарисуйте граф. 
#Выведите соседей 15 - й вершины, ребра,
#инцидентные этой вершине.
#Соединены ли вершины 25 и 27?
#Выведите матрицу смежности.
g1 = add.edges(g1, c(53,50,52,30,29,23,30,31,22,28),color='black')
plot(g1, edge.arrow.size=.2,vertex.size=20) 

neighbors(g1, 15)

E(g1)[incident(g1, 15)]

are.connected(g, V(g)[25], V(g)[27])

g1[]

#Добавьте еще одну вершину и подключите ее к той,
#которая имеет наибольшее количество связанных
#с ней узлов. Присвойте имена всем вершинам
#Выведите матрицу смежности.
#Выберите вершины, для которых значение связности
#меньше 5 и больше 2

g1 <- add_vertices(g1, 1)
max_degree <- which.max(degree(g1))
g <- add_edges(g, c(max_degree, length(V(g))))
g1[]
V(g1)$color <- ifelse(degree(g1) < 5 & degree(g1) > 2, "purple", "white")
plot(g1, edge.arrow.size=.2,vertex.size=20) 

#Испробуйте алгоритмы размещения Вашего графа
#(in_circle, in_tree, lattice).
#Результаты включить в отчет.
coords <- layout_(g1, in_circle())
plot(g1, layout = coords,edge.arrow.size=.2,vertex.size=10)

coords <- layout_(g1, as_tree())
plot(g1, layout =  coords,edge.arrow.size=.2,vertex.size=10)

g1<-graph.lattice(length=100,dim=1,nei=5, circular = TRUE)
plot(g1,vertex.size=2,vertex.label=NA,layout=layout.kamada.kawai)

#Выполните измерение диаметра графа g1,
#выведите список самых коротких путей  для
#каждой вершины и откалибруйте величины вершин
#согласно их степеней.
diameter(g1)
all_shortest_paths(g1,1:V(g1), to = V(g1), mode = c("out", "all", "in"),weights = NULL)
plot(g1, vertex.size=degree(g1))
degree(g1)

#Вводится N - количество домов и 
#К - количество дорог. 
#Дома пронумерованы от 1 до N. 
#Каждая дорога определяется тройкой чисел - 
#двумя номерами домов - концов дороги и длиной дороги. 
#В каждом доме живет по одному человеку.
#Найти точку - место встречи всех людей, 
#от которой суммарное расстояние до всех домов 
#будет минимальным. Указать номер дома.  
#Примечание: длины дорог - положительные целые числа.

min_sum_path = G_size * G_size
v_ans = -1
for (v in V(g1)){
  sum_path = 0
  ways = shortest_paths(g1, v)[1]$vpath
  for (path in ways){
    sum_path = sum_path + length(path)
  }
  if(sum_path < min_sum_path)
  {
    min_sum_path = sum_path
    v_ans = v
  }

}
