url <- "http://dx.doi.org/10.1787/723137538677"
download.file(url, destfile = "./ukindia.xls", quiet = TRUE, mode = "wb")
library(readxl)
ukindia <- read_xls("./ukindia.xls", sheet = "TAB 2-30", range = "B7:F8", col_names = FALSE)
ukindia <- t(ukindia)
years <- c("1600","1700","1757","1857","1947")
ukindia <- cbind(years,ukindia)
colnames(ukindia)<- c("Year","India","UK")
ukindia <- as.data.frame(ukindia)
ukindia$India <- as.numeric(ukindia$India)
for(i in 1:5)
ukindia$UK[i] <- gsub("(*UCP)\\s","",ukindia$UK[i], perl = TRUE)
ukindia$UK <- as.numeric(ukindia$UK)
library(ggplot2)
g <- ggplot(ukindia, aes(x=Year,India,group=1,col="India"))
g <- g + geom_point()+geom_line(show.legend = T)+
        geom_point(aes(Year,UK,col="UK"))+
        geom_line(aes(Year,UK,group=1,col="UK"),show.legend = T)+
        ylab("GDP per capita")+labs(color="Legend")
g