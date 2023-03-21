setwd('C:/Users/Tsinana/GitHub/6-th_semester/big_data/lab2')

#Выгрузка данных
df<-read.csv("csv_for_lab2.csv", sep=";", header=T, fileEncoding="cp1251")
View(df)

#вычислить max, min, mean по каждому столбцу
apply(df[3:12],2, FUN = min)
apply(df[3:12],2, FUN = max)
apply(df[3:12],2, FUN = mean)

#подсчитать количество людей, отдавших предпочтение >7 и <3 (составить вектор)
maxInRow = apply(df[3:12],1, FUN = max)
men = subset(df[2], (maxInRow < 7 & maxInRow > 3))[['ФИО']]
length(men)

#вывести рейтинг специй в списке по убыванию
numderOfSpices = order(apply(df[3:12],2, FUN = median),decreasing =TRUE)
list = colnames(df[3:12])
list[numderOfSpices]

#построить столбчатую диаграмму оценок (можно сделать разными способами)
barplot(apply(df[3:12],2, FUN = median),density = 20, col = "red",
        ylab = "Специя", xlab = "Рейтинг",horiz = T,las = 1)