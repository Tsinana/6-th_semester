analysis_func<- function() {
  setwd("C:/Users/Tsinana/GitHub/6-th_semester/WpfCourseWork/WpfCourseWork/analysis")
  library(plotly)
  opar = par(no.readonly = TRUE)
  
  #Подготовка к работе
  a <- as.matrix(read.csv("a.csv", header = FALSE))[1,]
  temp <- as.matrix(read.csv("temp.csv", header = FALSE))[1,]
  cf <- as.matrix(read.csv("cf.csv", header = FALSE))[1,]
  
  a <- head(a, -1)
  temp <- head(temp, -1)
  cf <- head(cf, -1)
  
  cf <- matrix(cf, nrow = length(a), ncol = length(temp))
  ЦФ = cf
  axx <- list(
    title = "Параментр принятия нового решения"
  )
  
  axy <- list(
    title = "Начальная температура"
  )
  
  axz <- list(
    title = "Знацение ЦФ"
  )
  
  fig <- plot_ly(
    type = 'surface',
    x = ~a,
    y = ~temp,
    z = ~ЦФ
  )
  
  fig <- fig %>% layout(scene = list(xaxis = axx, yaxis = axy, zaxis = axz))
  
  return(fig)
}
fig1 = analysis_func()
fig1
