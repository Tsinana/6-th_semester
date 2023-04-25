library(rvest)

url<-read_html("https://kudago.com/spb/list/33-luchshih-muzeya-peterburga/")

nodes<-html_nodes(url, ".post-list-big .post-list-item")

namesAndAdrass <- html_nodes(nodes, "span:nth-child(1)") %>% html_text(trim = TRUE)

even_index <- seq(from = 2, to = length(namesAndAdrass), by = 2)
odd_index <- seq(from = 1, to = length(namesAndAdrass), by = 2)

df = data.frame(namesAndAdrass[odd_index],namesAndAdrass[even_index])
colnames(df) = c('Музей','адрес')

EmailAdress <- html_nodes(nodes, ".post-list-item-preview") %>%  html_attr("href") %>% as.data.frame()
colnames(EmailAdress) = c('Ссылки')

df = cbind(df,EmailAdress)
