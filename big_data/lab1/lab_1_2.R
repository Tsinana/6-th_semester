rank = c(1,2,3,4,5,6,7,8,28)
country = c("Гремания","Австралия","Новая Зеландия","Дания","Норвегия","Исландия","США","Канада","Япония")
education_index = c(0.946,
                    0.923,
                    0.923,
                    0.92,
                    0.919,
                    0.918,
                    0.899,
                    0.891,
                    0.85
)
expenses = c(4.6,
             5.1,
             7.2,
             8.7,
             7.3,
             7.8,
             5.4,
             4.8,
             3.8
)

dr = data.frame(rank, country, education_index,expenses)

continent = c("Европа","Америка","Азия")

dr = data.frame(dr,continent)

sum_of_ei = sum(dr$education_index)
sum_of_e = sum(dr$expenses)
dr[nrow(dr)+1,] <- c(NA,NA,sum_of_ei,sum_of_e,NA)

dd = (df[order(df$expenses,decreasing = TRUE),])

dr = (dd[dd$continent == "Азия",])
