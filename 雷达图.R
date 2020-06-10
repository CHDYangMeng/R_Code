rm(list = ls()) #删除目前环境的所有东西
options(warn =-1)

setwd("E:\\crawler\\20180813_data")

library(recharts)
library(REmap)
library(ggplot2)
library(readxl)
library(knitr)
library(reshape2)

data = read_xlsx("abc.xlsx",sheet = 1)
data_scale <- data.frame(data[,10])
kable(data,format="markdown") 

#
for (i in c(1:9)) {
  k <- data[,i]/sum(data[,i])
  data_scale <- cbind(data_scale,k)
}
k11 <- data[,i]/sum(data[,11])
data_scale <- cbind(data_scale,k11)

data_1 <- melt(data_scale, id.vars = c("teamname"),variable.name = "modle", value.name = "score")

#单个雷达图
echartr(data_1,modle,score,teamname, type='radar', sub='fill') %>%
  setTitle('LPL夏季赛')
#多个雷达图
echartr(data_1,modle,score,facet = teamname, type='radar', sub='fill') %>%
  setTitle('LPL夏季赛')

















