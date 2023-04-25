#install.packages("rvest")
#var Греция, Швейцария, Корея, Вьетнам, Индия
library(rvest)



urls <- paste0("https://www.numbeo.com/quality-of-life/rankings_by_country.jsp?title=", 
               c(2021:2014), "&displayColumn=-1")
df_list = list()
years = c(2021,2020,2019,2018,2017,2016,2015,2014)
yearS = c(2021,2014)
countries = c("Switzerland","Greece","South Korea","Vietnam","India")
colorsForCountries = c("blue3","green3","pink3","red3","orange3")
opar = par(no.readonly = TRUE)
par(mar = c(5, 4, 4, 8),xpd = TRUE)


for (url in urls) {
  html <- read_html(url)
  nodes = html_nodes(html, 'table'); nodes
  df = html_table(nodes[[2]])%>%as.data.frame()
  newdf = subset(df, Country %in% countries)[2:10]
  rownames(newdf) = newdf[,1]
  if (length(rownames(newdf)) < length(countries)) {
    missing_names <- setdiff(countries, rownames(newdf))
    temp_df = data.frame(matrix(ncol = ncol(newdf), nrow = 1))
    colnames(temp_df) = colnames(newdf)
    newdf <- rbind(newdf, temp_df)
    rownames(newdf)[nrow(newdf)] <- missing_names
  }
  df_list = append(df_list, list(newdf))
}


for (i in 2:9) {
  countCountries = length(countries)
  countYears = length(years)
  
  temp_df = data.frame(df_list[[1]][i])
  
  for(j in 2:countYears)
    temp_df = cbind(temp_df, df_list[[j]][i])

  if (any(is.na(temp_df))) {
    temp_df <- t(apply(temp_df, 1, function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x)))
  }
  #temp_df <- replace(temp_df, is.na(temp_df), 0)

  yrange = range(temp_df)
  plot(0, 0, type = 'n', ann = FALSE, xlim = yearS, ylim = yrange)
  for (k in 1:countCountries) {
    color = colorsForCountries[k]
    points(years,temp_df[k,], pch=20, col = color) 
    lines(years,temp_df[k,], pch=20, col = color) 
    title(colnames(temp_df)[2],xlab = 'Year', ylab = 'Value')
    legend("topright",inset = c(-0.42, 0), legend = countries, lwd = 2,pch = 20, col = colorsForCountries)
  }
}
par(opar)
