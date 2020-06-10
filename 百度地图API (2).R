rm(list = ls()) #删除目前环境的所有东西

setwd("E:/数据学习/20180306")#设置自己的工作目录

##install.packages("rjson")
library(rjson)
library(bitops)
library(RCurl)
library(baidumap)#这个包需要在github上下载，官方cran没有#下面的包需要这些函数


options(warn =-1)#别那么多没用的warning报告
showConnections(all = T)#看看现在r的网络链接情况

closeAllConnections()#关闭现在r形成的所有链接
##########################################################################

##########################################################################
#定义一些基本变量
AK <- "4wAjx3T4AQtpbqfwuNByB83XkWWVhN0o"
keyname <- "高等院校"
city <- "西安"
tags <- "教育培训"
page_num_p <- 1
###########################################################################
##百度地图API中包含的数据
page_data <- function(keyname,city,tags,page_num_p) {
  get_result1 <- c()
  df <- c()
  
  url <- paste0("http://api.map.baidu.com/place/v2/search?query=",keyname,"&tag=",tags,"&page_size=20","&page_num=",page_num_p,"&scope=2","&region=",city,"&output=json&ak=",AK)
  url_string <- URLencode(url)
  conncet <- url(url_string)
  get_json <- fromJSON(paste(readLines(conncet,warn = F),collapse = ""))
  get_result <- get_json$results
  get_result1 <- c(get_result1,get_result)
  
  closeAllConnections()
  get_result1
}

##测试
# test_page_data_xa <- test_page_data(keyname,city,tags,page_num_p)
#############################################################################
  
##########################################################################
##查询某页有多少数据的函数
find_page_data <- function(keyname,x0,y0,x1,y1,tags,page_num_p) {
  get_result1 <- c()
  df <- c()
  
  url <- paste0("http://api.map.baidu.com/place/v2/search?query=",keyname,"&tag=",tags,"&page_size=20","&page_num=",page_num_p,"&scope=2","&bounds=",x0,",",y0,",",x1,",",y1,"&output=json&ak=",AK)
  url_string <- URLencode(url)
  connect <- url(url_string)
  
  get_json <- fromJSON(paste(readLines(connect,warn = F),collapse = ""))
  get_result <- get_json$results
  get_result1 <- c(get_result1,get_result)
  
  closeAllConnections()
  get_result1
  
  location <- data.frame(t(sapply(get_result1,function(x) x$location)))
  nums <- as.numeric(nrow(location))
  
  nums
}

##测试
# AK <- "4wAjx3T4AQtpbqfwuNByB83XkWWVhN0o"
# keyname <- "便利店"
# tags <- "购物"
# page_num_p <- 1
# test_find_page_data <- find_page_data(keyname,39.915,116.404,39.975,116.414,tags,page_num_p)
##########################################################################
##提取某页内容的函数
find_page_content <- function(keyname,x0,y0,x1,y1,tags,page_num_p) {
  
  get_result1 <- c()
  df <- c()
  
  url <- paste0("http://api.map.baidu.com/place/v2/search?query=",keyname,"&tag=",tags,"&page_size=20","&page_num=",page_num_p,"&scope=2","&bounds=",x0,",",y0,",",x1,",",y1,"&output=json&ak=",AK)
  url_string <- URLencode(url)
  connect <- url(url_string)
  
  get_json <- fromJSON(paste(readLines(connect,warn = F),collapse = ""))
  get_result <- get_json$results
  get_result1 <- c(get_result1,get_result)
  
  closeAllConnections()
  
  get_result1
  location <- data.frame(t(sapply(get_result1,function(x) x$location)))
  if(dim(location)[2] == 0) {
    print("方格中不存在内容")
    df <- NULL
  }
  else {
    name<-sapply(get_result1,function(x) x$name)
    address <- sapply(get_result1,function(x) x$address)
    detail_info <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$tag))
    detail_price <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$price))
    detail_overall_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$overall_rating))
    detail_service_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$service_rating))
    detail_environment_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$environment_rating))
    detail_technology_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$technology_rating))
    
    
    
    detail_image_num <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$image_num))
    detail_comment_num <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$comment_num))
    
    df <- cbind(name,location,address,detail_info,detail_price,
                detail_overall_rating,detail_service_rating,
                detail_environment_rating,detail_technology_rating,
                detail_image_num,detail_comment_num)
    
    df <- df[!duplicated(df),]
    print("提取了一个box数据")
  }
  df
}

##测试
# AK <- "4wAjx3T4AQtpbqfwuNByB83XkWWVhN0o"
# keyname <- "便利店"
# tags <- "购物"
# page_num_p = 1
# test_find_page_content <- find_page_content(keyname,39.915,116.404,39.975,116.414,tags,page_num_p)
##############################################################################
##提取20页内容
find_page_content20 <- function(keyname,x0,y0,x1,y1,tags) {
  
  get_result1 <- c()
  df <- c()
  i <- 0
  for (page_num_p in 0 : 19) {
    
    url <- paste0("http://api.map.baidu.com/place/v2/search?query=",keyname,"&tag=",tags,"&page_size=20","&page_num=",page_num_p,"&scope=2","&bounds=",x0,",",y0,",",x1,",",y1,"&output=json&ak=",AK)
    url_string <- URLencode(url)
    connect <- url(url_string)
    get_json <- fromJSON(paste(readLines(connect,warn = F),collapse = ""))
    get_result <- get_json$results
    get_result1 <- c(get_result1,get_result)
    Sys.sleep(0.03)
    
    print(paste0("爬了一页",as.character(i <- i+1)))
    closeAllConnections()
    
  }
  location <- data.frame(t(sapply(get_result1,function(x) x$location)))
  if(dim(location)[2] == 0) {
    print("没有数据")
    df <- NULL
  }
  else {
    name<-sapply(get_result1,function(x) x$name)
    address <- sapply(get_result1,function(x) x$address)
    detail_info <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$tag))
    detail_price <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$price))
    detail_overall_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$overall_rating))
    detail_service_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$service_rating))
    detail_environment_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$environment_rating))
    detail_technology_rating <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$technology_rating))
    
    
    
    detail_image_num <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$image_num))
    detail_comment_num <- gsub("NULL",NA,sapply(get_result1,function(x) x$detail_info$comment_num))
    
    df <- cbind(name,location,address,detail_info,detail_price,
                detail_overall_rating,detail_service_rating,
                detail_environment_rating,detail_technology_rating,
                detail_image_num,detail_comment_num)
    
    df <- df[!duplicated(df),]
    print("提取20页内容")
  }
  
  df
}

##测试
# AK <- "4wAjx3T4AQtpbqfwuNByB83XkWWVhN0o"
# keyname <- "便利店"
# tags <- "购物"
# test_find_page_content20 <- find_page_content20(keyname,39.915,116.404,39.975,116.414,tags)
##################################################################################
##爬取行内容
find_a_row <- function(keyname,x0,y0,x1,tags,long,high,steps) {
  
  df2 <- c()
  x0s <- x0 + long
  y0s <- y0 + high
  
  while (x0s < x1 + long) {

    test1 <- find_page_data(keyname,x0,y0,x0s,y0s,tags,0)
    Sys.sleep(0.1)
    test19 <- find_page_data(keyname,x0,y0,x0s,y0s,tags,19)
    Sys.sleep(0.1)
    
    if(test1 == 1 & test19 == 1) {#都没有数据
      
      print("发现第一页和最后一页都是空的")
      df <- find_page_content(keyname,x0,y0,x0s,y0s,tags,0)
      Sys.sleep(0.1)
      df2<-rbind(df2,df)
      
      long <- long * steps
      x0 <- x0s
      x0s <- x0s + long
    }
    
    else if(test19 == 20){#都没有数据最后一页满了，调整long
      
      print("发现最后一页是满的")
      long <-  long * ((1 / 2) ^ steps)#减少long的值
      x0s <- x0 + long #不移动，调整一个值
      print("不移动，调整一个值")
      
    }
    else if(test1 <= 19){
      
      print("只有第一页只爬第一页")
      df <- find_page_content(keyname,x0,y0,x0s,y0s,tags,0)
      Sys.sleep(0.1)
      df2<-rbind(df2,df)
      
      i <- 0
      long <- long * steps
      x0 <- x0s
      x0s <- x0s + long
      
    }
    else if(test1 > 1 & test19 < 20){
      
      print("发现20页内有数据")
      
      df2<-rbind(df2,find_page_content20(keyname,x0,y0,x0s,y0s,tags))
      Sys.sleep(0.1)
      long <- long * steps
      x0 <- x0s#新起点
      x0s<-x0s+long#拓展点点右移动
    }
  }
  df2
}

##测试
# AK <- "4wAjx3T4AQtpbqfwuNByB83XkWWVhN0o"
# keyname <- "便利店"
# tags <- "购物"
# test_find_a_row <- find_a_row(keyname,39.915,116.404,40.975,tags,0.05,0.05,2)
############################################################################
##爬取列内容
find_a_line <- function(keyname,x0,y0,x1,y1,tags,long,high,steps) {
  df3 <- c()
  y0s <- y0 + high
  i2 <- 0
  
  while (y0s < y1 + high) {
    
    df <- find_a_row(keyname,x0,y0,x1,tags,long,high,steps)
    df3 <- rbind(df3,df)
    
    y0 <- y0 + high
    y0s <- y0s + high
    print(paste0("high的line计数",as.character(i2 <- i2+1)))
  }
  df3
}

#####################################################################################
##测试
AK <- "4wAjx3T4AQtpbqfwuNByB83XkWWVhN0o"
keyname <- "停车场"
tags <- "交通设施"
long <- 0.05
high <- 0.05
steps <- 2

# 108.919842,34.237011
# 108.938599,34.247277

test_find_a_line <- find_a_line(keyname,34.237011,108.919842,34.247277,108.938599,tags,long,high,steps)

data_SXGX <- test_find_a_line

data_SXGX$lat <-  as.numeric(as.character(data_SXGX$lat)) 
data_SXGX$lng <-  as.numeric(as.character(data_SXGX$lng))



# install.packages("sp")
library(sp)

data_SXGX_map <- SpatialPointsDataFrame(data.frame(as.numeric(data_SXGX$lng),as.numeric(data_SXGX$lat)),data_SXGX)

plot(data_SXGX_map)
write.csv(data_SXGX,file = "data_TCC_map.csv",row.names = F)
data_SXGX_map <- read.csv("data_TCC_map.csv",stringsAsFactors = F)

# install.packages("ggmap")
library(ggmap)
library(ggplot2)

# install.packages("devtools")
library(devtools)
# install_github('badbye/baidumap')
# install_github('lchiffon/REmap')
library(baidumap)
library(REmap)

options(baidumap.key = '4wAjx3T4AQtpbqfwuNByB83XkWWVhN0o')

p3 <- getBaiduMap(c(lon = 108.9292205,lat = 34.242144),width = 400, height = 400,zoom = 15)
ggmap(p3)
map_layer <- ggmap(p3)

mymap <- map_layer +
  stat_density2d(data = data_SXGX_map,aes(lng, lat, alpha=..level.., fill=..level..),size=2,bins=100, geom="polygon")+
  scale_fill_gradient(low = "blue", high = "yellow")+
  scale_alpha(range = c(0.001, 0.03), guide = FALSE)+
  geom_density2d(data = data_SXGX_map,aes(lng, lat), bins = 10,show.legend=F)+
  geom_point(data = data_SXGX_map,aes(lng, lat))

# print(mymap)
ggsave("map.tiff", width = 9, height = 15, units = "cm", dpi=500)

# p3 <- get_map(location = c(lon = 114.0441518,lat = 22.5550996),
#               color = "color",
#               source = "google",
#               maptype = "roadmap",
#               language = "ch",
#               zoom = 11)
# ggmap(p3)

mymap3 <- map_layer_shenzhen +
  
  stat_density2d(data = data_shenzhen,aes(lng, lat, alpha=..level.., fill=..level..),size=2,bins=100, geom="polygon")+
  
  scale_fill_gradient(low = "blue", high = "yellow")+
  
  scale_alpha(range = c(0.001, 0.03), guide = FALSE)+
  
  geom_density2d(data = data_shenzhen,aes(lng, lat), bins = 10,show.legend=F)+
  
  geom_point(data = data_shenzhen,aes(lng, lat))

print(mymap3)














