rm(list = ls()) #删除目前环境的所有东西

setwd("E:/数据学习/20180317")#设置自己的工作目录

options(warn =-1)#别那么多没用的warning报告

library(devtools)     
install_github(repo = "Rwebdriver", username = "crubba")
install.packages("Rwebdriver")
library(Rwebdriver)
install.packages("RSelenium")
library(RSelenium)  
