####################################################
#
# Freddolino Lab
# Author : Taeho Jo
#
####################################################


require(randomForest) || install.packages("randomForest")
require(ggplot2) || install.packages("ggplot2")
require(pROC) || install.packages("pROC")
require(foreign) || install.packages("foreign")
require(RSofia) || install.packages("RSofia", repos = "https://cran.r-project.org/src/contrib/Archive/RSofia/RSofia_1.1.tar.gz", type="source")
require(verification) || install.packages("verification")

library(randomForest)
library(ggplot2)
library(pROC)
library(foreign)
library(RSofia)
library(verification)

setwd("/srv/taehojo/feature_extraction")

alldata = read.svmlight("./ml-results/145/seta/145-plus.all")
alldata.train = read.svmlight(""./ml-results/145/seta/145-1.trn")
alldata.test = read.svmlight(""./ml-results/145/seta/145-1.test")

set.seed(4543)

# all data
alldata$labels <- as.factor(alldata$labels)
alltrain.rf <- randomForest(alldata$labels ~ . , data = alldata$data, importance=T)
alltrain.rf
import <- importance(alltrain.rf, type=2, sort = TRUE)
import <- import[order(import, decreasing=TRUE),,drop = FALSE]
import[1:30,,drop = FALSE]

qplot(y=alltrain.rf$err.rate[,1], xlab="Number of trees", ylab="Error rate") 
varImpPlot(alltrain.rf)
plot(alltrain.rf)

alldata.train$labels <- as.factor(alldata.train$labels)
train.rf <- randomForest(alldata.train$labels ~ . , data = alldata.train$data, importance=T)

# predict test data
alldata.test$labels <- as.factor(alldata.test$labels)
Prediction.test <- predict(train.rf, alldata.test$data, type="prob")

Prediction.test.response = as.factor(ifelse(Prediction.test[,2] >= 0.5, "1", "0"))
conftable = table(Prediction.test.response, alldata.test$labels)
conftable
cat("\n")

cat(paste(paste("sensitivity(TPR)", conftable[2,2]/(conftable[2,2]+conftable[1,2])*100), 
          paste("specificity(TNR)", conftable[1,1]/(conftable[1,1]+conftable[2,1])*100), 
          sep="\n"))
cat("\n\n")

alldata.test$response <- ifelse(alldata.test$labels=="1", 1, 0)
roc.plot(alldata.test$response, Prediction.test[,2], xlab="False positive rate", ylab="True positive rate")
paste("AUC:", roc.area(alldata.test$response, Prediction.test[,2])$A)
cat("\n")

ldata.test$label <- ifelse(alldata.test$labels=="1", "positive", "negative")
qplot(y = Prediction.test[,2], color = alldata.test$label) + 
  xlab("") + ylab("score") + theme(axis.title.y = element_text(size = rel(1.5))) +
  guides(color=guide_legend(title=NULL), shape=guide_legend(title=NULL)) +
  geom_hline(aes(yintercept=0.5))

boxdata <- data.frame(Type = alldata.test$label, Prediction = Prediction.test[,2])
ggplot(data = boxdata, aes(Type, Prediction)) + geom_boxplot(outlier.shape = 1, notch = FALSE)

