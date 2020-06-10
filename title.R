rm(list = ls()) #ɾ��Ŀǰ���������ж���
# setwd("")#�����Լ��Ĺ���Ŀ¼
options(warn =-1)

#ʹ��windows����
#install.packages("extrafont")
library(extrafont)
# #���Ҳ���������
# font_import()
# #�г�����
fonts() 
loadfonts()


library(ggplot2)
#�Զ�������
mytheme <- theme_bw() +
  theme(
    
    ##����趨axis
    axis.title = element_text(family="Times New Roman", colour="black", face="bold", size=10.5),     #plain����ͨ��italic��б�壻bold������
    # axis.title.x = element_text(family="Times New Roman", colour="black", face="bold", size=10.5),
    # axis.title.y = element_text(family="Times New Roman", colour="black", face="bold", size=10.5),
    axis.text = element_text(family="Times New Roman", colour="black", face="plain", size=8),     #bold.italic������+б��
    # axis.text.x = element_text(family="Times New Roman", colour="black", face="bold", size=8),
    # axis.text.y = element_text(family="Times New Roman", colour="black", face="bold", size=8),
    axis.line = element_line(colour="black", size=0.5),
    
    ##ͼ�����趨legend
    legend.background = element_rect(fill="white", colour="white", size=1),  #ͼ�������ɫ�������ɫ
    legend.title = element_text(family="Times New Roman", colour="black", face="bold.italic", size=6), #ͼ������
    legend.text = element_text(family="Times New Roman", colour="black",  face="bold", size=6),        #ͼ���ı�
    legend.key = element_rect(colour="white", size=0.25),                                              #ÿ��ͼ����� 
    legend.position=c(.9,1), 
    #legend.position="bottom",          #"bottom" 
    #legend.justification=c(1,1),           #"bottom" 
    
    ##ͼ���趨panel
    panel.background = element_rect(fill = "gray90"),
    panel.grid.major.y = element_line(colour = "grey", size = 0.25),
    panel.grid.minor.y = element_line(colour = "white", size = 0.25),
    panel.grid.major.x = element_line(colour = "grey", size = 0.25),
    
    ##����ͼ���趨plot
    plot.title = element_text(family="Times New Roman", colour="black",  face="bold", size=10.5),
    strip.text = element_text(family="Times New Roman", colour="black",  face="bold", size=9)
  ) 
########################################################################################################################

##ɢ��ͼ
mytheme_scatterplot <- mytheme +
  theme(
    legend.position=c(0.85,0.71),
    legend.background = element_rect(fill = "transparent",colour = NA, size = 1),  #ͼ�������ɫ�������ɫ
    legend.title = element_text(family = "Times New Roman", colour = "black", face = "bold.italic", size = 6), #ͼ������
    legend.text = element_text(family = "Times New Roman", colour = "black",  face = "bold", size = 6),       #ͼ���ı�
    legend.key = element_rect(fill ="transparent",colour = NA, size = 0.5), 
    # legend.key.size = unit(0.4,"cm"),
    legend.key.height = unit(0.7,"cm"),
    legend.key.width = unit(0.5,"cm")
  ) 

##��״ͼ
mytheme_barplot <- mytheme +
  theme(
    legend.position=c(0.85,0.71), 
    legend.background = element_rect(fill = "transparent",colour = NA, size=1),  #ͼ�������ɫ�������ɫ
    legend.title = element_text(family="Times New Roman", colour="black", face="bold.italic", size=6), #ͼ������
    legend.text = element_text(family="Times New Roman", colour="black",  face="bold", size=6),       #ͼ���ı�
    legend.key = element_rect(fill = "transparent",colour = NA, size=0.5), 
    legend.key.size=unit(0.3,"cm")
  ) 

##����ͼ
mytheme_lineplot <- mytheme +
  theme(
    legend.position=c(0.85,0.71), 
    legend.background = element_rect(fill = "transparent",colour = NA, size=1),  #ͼ�������ɫ�������ɫ
    legend.title = element_text(family="Times New Roman", colour="black", face="bold.italic", size=6), #ͼ������
    legend.text = element_text(family="Times New Roman", colour="black",  face="bold", size=6),       #ͼ���ı�
    legend.key = element_rect(fill = "transparent",colour = NA, size=0.5), 
    legend.key.size=unit(0.3,"cm")












