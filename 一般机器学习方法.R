rm(list = ls())
options(warn = -1)

# -------------------------------------------
# ###########################################
# 
# 机器学习
# 
# ###########################################
# -------------------------------------------
# 
# 神经网络 Neural Networks and Deep Learning
# 
# -------------------------------------------
# 包
# nnet：这个包（package）中含有单隐藏层神经网络
# rnn：实现了循环神经网络
# deepnet：前馈神经网络（feed-forward neural network）
# tensorflow：提供了面向TensorFlow的接口
# 
# install.packages('nnet')
library(nnet)

seeds <-read.table("E:/数据学习/R语言机器学习模块/seeds_dataset.txt", header=FALSE, sep="")
names(seeds) <-c("A", "P", "C", "L", "W","AC", "LKG", "Label")
# 把seed数据集划分为训练70%的训练数据集和30%的测试数据集
trainIndex <-sample(1:210, 147)
trainIndex
testIndex <-setdiff(1:210, trainIndex)
testIndex
# 利用神经网络对训练数据集获得模型
ideal <-class.ind(seeds$Label)
seedsANN <-nnet(seeds[trainIndex, -8], ideal[trainIndex, ], size=10, softmax=TRUE)
# 对测试数据及进行测试
testLabel <-predict(seedsANN, seeds[testIndex, -8], type="class")
# 计算测试误差率
# 混淆矩阵
my_table <-table(seeds[testIndex,]$Label, testLabel)
# 误差
test_error <- 1 - sum(diag(my_table)) / sum(my_table)

# -------------------------------------------
# 
# 决策树 Recursive Partitioning
# 
# -------------------------------------------
# 包
# rpart: 递归拆分利用树形结构模型，来做回归、分类和生存分析
# maptree: 用于树的可视化的图形工具
# party和partykit: 提供二分支树和节点分布的可视化展示
library(rpart)
loc<-"http://archive.ics.uci.edu/ml/machine-learning-databases/"
ds<-"breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url<-paste(loc,ds,sep="")
data<-read.table(url,sep=",",header=F,na.strings="?")
names(data)<-c("编号","肿块厚度","肿块大小","肿块形状","边缘黏附","单个表皮细胞大小","细胞核大小","染色质","细胞核常规","有丝分裂","类别")

data$类别[data$类别==2]<-"良性"
data$类别[data$类别==4]<-"恶性"

data<-data[-1] #删除第一列元素#

set.seed(1234) #随机抽样设置种子
train<-sample(nrow(data),0.7*nrow(data)) #抽样函数，第一个参数为向量，nrow()返回行数 后面的是抽样参数前
# 训练集
tdata<-data[train,] #根据抽样参数列选择样本，都好逗号是选择行
# 测试集
vdata<-data[-train,] #删除抽样行
# 训练
dtree<-rpart(类别~.,data=tdata,method="class", parms=list(split="information"))
print(dtree)
printcp(dtree)

# 剪枝
tree<-prune(dtree,cp=dtree$cptable[which.min(dtree$cptable[,"xerror"]),"CP"])

# 画图
library(rpart.plot)
rpart.plot(dtree,branch=1,type=2, fallen.leaves=T,cex=0.8, sub="剪枝前")
rpart.plot(tree,branch=1, type=4,fallen.leaves=T,cex=0.8, sub="剪枝后")
#利用预测集进行预测
predtree<-predict(tree,newdata=vdata,type="class") 
#输出混淆矩阵
table(vdata$类别,predtree,dnn=c("真实值","预测值"))    

# -------------------------------------------
# 
# 随机森林 Random Forests
# 
# -------------------------------------------
# 包
# randomForest: 提供了用于回归和分类的随机森林算法
# 
library(randomForest)

data <- iris

Randommodel <- randomForest(Species ~ ., data=data,importance = TRUE, proximity = FALSE, ntree = 100)
print(Randommodel)

importance(Randommodel,type=1)  #重要性评分
importance(Randommodel,type=2)  #Gini指数
varImpPlot(Randommodel)         #可视化

prediction <- predict(Randommodel, data[,1:5],type="class")  #还有response回归类型
# 混肴矩阵
table(observed =data$Species,predicted=prediction)

# -------------------------------------------
# 
# 支持向量机和核方法 Support Vector Machines and Kernel Methods
# 
# -------------------------------------------
# 包
# e1071: 函数svm()提供了LIBSVM库的接口
# kernlab: 实现了一个灵活的核学习框架（包括SVMs，RVMs和其他核学习算法）
library(e1071)
library(lattice)
data(iris)
attach(iris)
xyplot(Petal.Length ~ Petal.Width, data = iris, groups = Species,auto.key=list(corner=c(1,0)))

subdata <- iris[iris$Species != 'virginica',]
subdata$Species <- factor(subdata$Species)
# model1 <- svm(Species ~ Petal.Length + Petal.Width, data = subdata)
# plot(model1, subdata, Petal.Length ~ Petal.Width)
model2 <- svm(Species ~ ., data = iris)
summary(model2)
 
# -------------------------------------------
# 
# 贝叶斯方法 Bayesian Methods
# 
# -------------------------------------------
# 包
# install.packages("caret")
# install.packages("bnlearn")
# caret
# bnlearn
# 加载扩展包和数据
library(caret)
data(PimaIndiansDiabetes2,package='mlbench')
# 对缺失值使用装袋方法进行插补
preproc <- preProcess(PimaIndiansDiabetes2[-9],method="bagImpute")
data <- predict(preproc,PimaIndiansDiabetes2[-9])
data$Class <- PimaIndiansDiabetes2[,9]

# 加载包
library(bnlearn)
# 数据离散化
data2 <- discretize(data[-9],method='quantile')
data2$class <- data[,9]
# 使用爬山算法进行结构学习
bayesnet <- hc(data2)
# 显示网络图
plot(bayesnet)
# 修改网络图中的箭头指向
bayesnet<- set.arc(bayesnet,'age','pregnant')
# 参数学习
fitted <- bn.fit(bayesnet, data2,method='mle')
# 训练样本预测并提取混淆矩阵
pre <- predict(fitted,data=data2,node='class')
confusionMatrix(pre,data2$class)
# 进行条件推理
cpquery(fitted,(class=='pos'),(age=='(36,81]'&mass=='(34.8,67.1]'))


# -------------------------------------------
# 
# 遗传算法进行优化 Optimization using Genetic Algorithms
# 
# -------------------------------------------
# 包
# install.packages("mcga")
# mcga包，多变量的遗传算法，用于求解多维函数的最小值。 
# genalg包，多变量的遗传算法，用于求解多维函数的最小值。 
# rgenoud包，复杂的遗传算法，将遗传算法和衍生的拟牛顿算法结合起来，可以求解复杂函数的最优化化问题。 
# gafit包，利用遗传算法求解一维函数的最小值。不支持R 3.1.1的版本。 
# GALGO包，利用遗传算法求解多维函数的最优化解。不支持R 3.1.1的版本。
library(mcga)
f<-function(x){
  return ((x[1]-5)^2 + (x[2]-55)^2 +(x[3]-555)^2 +(x[4]-5555)^2 +(x[5]-55555)^2)
}

m <- mcga(  popsize=200,chsize=5,minval=0.0,
            maxval=999999,maxiter=2500,crossprob=1.0,
            mutateprob=0.01,evalFunc=f)

# 最优化的个体结果
print(m$population[1,])

# 执行时间
m$costs[1]
# -------------------------------------------
# 
# 关联规则 Association Rules
# 
# -------------------------------------------
# 包
# install.packages("arules")
# arules: 提供有效处理稀疏二元数据的数据结构，以及Apriori和Eclat实现的接口，
# 用于挖掘频繁项集，最大频繁项集，封闭频繁项集和关联规则
library(arules)
data <- Groceries
inspect(Groceries)

rules <- apriori(data = data, parameter = list(support=0.01,confidence=0.5))

inspect(rules)


# -------------------------------------------
# 
# 基于模糊规则的系统 Fuzzy Rule-based Systems
# 
# -------------------------------------------
# 包
# frbs: 实现了许多标准方法，用于从回归和分类问题数据中学习基于模糊规则的系统
# RoughSets: 提供粗糙集理论（RST）和模糊粗糙集理论（FRST）的全面实现




# -------------------------------------------
# 
# GUI包rattle是R语言数据挖掘的图形用户界面包
# 
# -------------------------------------------
# 包
# install.packages("rattle")
# rattle
library(rattle)
rattle()

# -------------------------------------------
# 
# 可视化（最初由Brandon Greenwell提供）
# 
# -------------------------------------------
# 包
# ggRandomForests包提供了基于ggplot2的工具，
# 用于从randomForest包和randomForestSRC包中对随机森林模型
# （例如变量重要性图和PDP）进行图形化探索







