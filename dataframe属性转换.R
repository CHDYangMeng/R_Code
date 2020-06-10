rm(list = ls())
# setwd()
options(warn = -1)

library(ggplot2)
library(reshape2)
library(knitr)

id <- c(1,2,3,4)
name <- c("zhang","wang","li","zhao")
sex <- c("nan","nv","nan","nv")
english <- c(80,89,90,78)
math <- c(72,90,84,68)

student <- data.frame(id,name,sex,english,math)
kable(student,format="markdown")

data <- melt(student, id.vars = c("id","name","sex"),variable.name = "subject", value.name = "score")
kable(data,format="markdown")



















