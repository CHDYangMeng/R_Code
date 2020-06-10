rm(list = ls()) #删除目前环境的所有东西

setwd("E:/数据学习/elm_data")#设置自己的工作目录

options(warn =-1)#别那么多没用的warning报告


library(RCurl)# 抓取数据
library(XML)# 解析网页
library(stringr)# 字符串处理
library(dplyr)# 调用%>%管道
library(rvest)

library(RSelenium)
# library(devtools)
# install_github(repo = "crubba/Rwebdriver", username = "crubba")
library(Rwebdriver)

#### 打开浏览器  

start_session(root = 'http://localhost:4444/wd/hub/',browser ="chrome")# 默认端口是4444，我的浏览器是chorme，如果使用火狐改成firefox
list_url <-  "https://www.lagou.com/jobs/list_%E6%95%B0%E6%8D%AE%E5%88%86%E6%9E%90"
post.url(url = list_url)# 打开网页
pageSource <- page_source()#保存网页信息

webpage <- html(pageSource,encoding="UTF-8")

work_name <- webpage %>%
  html_nodes('h3') %>%
  html_text()

work_local <- webpage %>%
  html_nodes('#s_position_list em') %>%
  html_text()

work_time <- webpage %>%
  html_nodes('.format-time') %>%
  html_text()

work_price <- webpage %>%
  html_nodes('.money') %>%
  html_text()

work <- data.frame(work_name,work_local,work_time,work_price)

button <- element_xpath_find(value = ".pager_next")
element_click(ID=button)




write.csv(work,"work_data.csv",row.names = FALSE)

data <- read.csv("work_data.csv",encoding = 'UTF-8',header = TRUE)









