rm(list = ls()) #删除目前环境的所有东西
setwd("E:\\项目\\ETC_data2017\\2017ShannxiETC\\201712")#设置自己的工作目录
options(warn =-1)#别那么多没用的warning报告
library(readxl)
library(RODBC)
table <- c(1:78)
sheet <- c(1:4)


channel<-odbcConnect("ETC_2017_data",uid="sa",pwd="123")

for (j in table) {
  data_Month_12 <- data.frame()
  print(paste0("表",j))
  for (i in sheet) {
    print(paste0("sheet",i))
    path <- paste0("消费流水",j,".xls")
    data <- read_excel(path, sheet = i)
    data_Month_12 <- rbind(data_Month_12,data)
  }
  data(data_Month_12)
  sqlSave(channel,data_Month_12,append=TRUE)
  rm(data)
  rm(data_Month_12)
}
#####################################################################################

data_Month_12 <- data.frame()
path <- paste0("消费流水",79,".xls")
data <- read_excel(path, sheet = 1)
data_Month_12 <- rbind(data_Month_12,data)
data(data_Month_12)
sqlSave(channel,data_Month_12,append=TRUE)
######################################################################################
data_Month_11 <- data.frame()
for (i in 1:3) {
  print(paste0("sheet",i))
  path <- paste0("消费流水",81,".xls")
  data <- read_excel(path, sheet = i)
  data_Month_11 <- rbind(data_Month_11,data)
}
data(data_Month_11)
sqlSave(channel,data_Month_11,append = TRUE)


#####################################################################################