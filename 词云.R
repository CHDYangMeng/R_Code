rm(list = ls())
# setwd()
options(warn = -1)

library(Rwordseg) 
library(RColorBrewer)
library(wordcloud2)

lecture<-read.csv("E:\\crawler\\20180809_auto\\movie_review\\data.txt",stringsAsFactors=FALSE,header=FALSE)

words=unlist(lapply(lecture, FUN=segmentCN))
#unlist将list类型的数据，转化为vector

word <- lapply(words, FUN=strsplit, " ") 
v <- table(unlist(word))
#table统计数据的频数

v <- rev(sort(v))
d <- data.frame(词汇=names(v), 词频=v)
d <- subset(d, nchar(as.character(d$词汇))>1)  #字符的个数
d <- data.frame(d[,1],d[,3])
names(d) <- c("词汇","词频")

wordcloud2(d, size = 2, fontFamily = "微软雅黑",  color = "random-light", backgroundColor = "grey")  


