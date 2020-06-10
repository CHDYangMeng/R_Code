rm(list = ls())
# setwd()
options(warn = -1)

library(ggplot2)
library(RODBC)

chan <- odbcConnect("R_SQL", uid = "sa", pwd = "123")
data <- sqlQuery(chan, " SELECT * FROM dbo.v_210102_h WHERE TIME >= '2014-02-01 00:00:00.000' AND TIME < '2014-02-02 00:00:00.000' ORDER BY TIME")
odbcClose(chan)

P <- ggplot(data, aes(x = TIME, y = PRICE)) +
  geom_line()
datebreaks <- seq(as.POSIXct('2014-02-01 00:00:00.000'),as.POSIXct('2014-02-02 00:00:00.000'), by = "1 hour")
P + scale_x_datetime(datebreaks) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))
















