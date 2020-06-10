rm(list = ls()) #删除目前环境的所有东西
# setwd("")#设置自己的工作目录
options(warn =-1)

#使用windows字体
#install.packages("extrafont")
library(extrafont)
# #查找并复制字体
# font_import()
# #列出字体
fonts() 
loadfonts()


library(ggplot2)
#自定义主题
mytheme <- theme_bw() +
  theme(
    
    ##轴的设定axis
    axis.title = element_text(family="Times New Roman", colour="black", face="bold", size=10.5),     #plain：普通；italic：斜体；bold：粗体
    # axis.title.x = element_text(family="Times New Roman", colour="black", face="bold", size=10.5),
    # axis.title.y = element_text(family="Times New Roman", colour="black", face="bold", size=10.5),
    axis.text = element_text(family="Times New Roman", colour="black", face="plain", size=8),     #bold.italic：粗体+斜体
    # axis.text.x = element_text(family="Times New Roman", colour="black", face="bold", size=8),
    # axis.text.y = element_text(family="Times New Roman", colour="black", face="bold", size=8),
    axis.line = element_line(colour="black", size=0.5),
    
    ##图例的设定legend
    legend.background = element_rect(fill="white", colour="white", size=1),  #图例填充颜色和外框颜色
    legend.title = element_text(family="Times New Roman", colour="black", face="bold.italic", size=6), #图例标题
    legend.text = element_text(family="Times New Roman", colour="black",  face="bold", size=6),        #图例文本
    legend.key = element_rect(colour="white", size=0.25),                                              #每个图例外框 
    legend.position=c(.9,1), 
    #legend.position="bottom",          #"bottom" 
    #legend.justification=c(1,1),           #"bottom" 
    
    ##图的设定panel
    panel.background = element_rect(fill = "gray90"),
    panel.grid.major.y = element_line(colour = "grey", size = 0.25),
    panel.grid.minor.y = element_line(colour = "white", size = 0.25),
    panel.grid.major.x = element_line(colour = "grey", size = 0.25),
    
    ##整个图的设定plot
    plot.title = element_text(family="Times New Roman", colour="black",  face="bold", size=10.5),
    strip.text = element_text(family="Times New Roman", colour="black",  face="bold", size=9)
  ) 
########################################################################################################################

##散点图
mytheme_scatterplot <- mytheme +
  theme(
    legend.position=c(0.85,0.71),
    legend.background = element_rect(fill = "transparent",colour = NA, size = 1),  #图例填充颜色和外框颜色
    legend.title = element_text(family = "Times New Roman", colour = "black", face = "bold.italic", size = 6), #图例标题
    legend.text = element_text(family = "Times New Roman", colour = "black",  face = "bold", size = 6),       #图例文本
    legend.key = element_rect(fill ="transparent",colour = NA, size = 0.5), 
    # legend.key.size = unit(0.4,"cm"),
    legend.key.height = unit(0.7,"cm"),
    legend.key.width = unit(0.5,"cm")
  ) 

##柱状图
mytheme_barplot <- mytheme +
  theme(
    legend.position=c(0.85,0.71), 
    legend.background = element_rect(fill = "transparent",colour = NA, size=1),  #图例填充颜色和外框颜色
    legend.title = element_text(family="Times New Roman", colour="black", face="bold.italic", size=6), #图例标题
    legend.text = element_text(family="Times New Roman", colour="black",  face="bold", size=6),       #图例文本
    legend.key = element_rect(fill = "transparent",colour = NA, size=0.5), 
    legend.key.size=unit(0.3,"cm")
  ) 

##折线图
mytheme_lineplot <- mytheme +
  theme(
    legend.position=c(0.85,0.71), 
    legend.background = element_rect(fill = "transparent",colour = NA, size=1),  #图例填充颜色和外框颜色
    legend.title = element_text(family="Times New Roman", colour="black", face="bold.italic", size=6), #图例标题
    legend.text = element_text(family="Times New Roman", colour="black",  face="bold", size=6),       #图例文本
    legend.key = element_rect(fill = "transparent",colour = NA, size=0.5), 
    legend.key.size=unit(0.3,"cm")













