#!/usr/bin/Rscript

library(foreign)
library(RSofia)
library(randomForest)

writeLines("=====Start random forest training=====")
train = read.svmlight("145-1.trn")
train$labels <- as.factor(train$labels)
train.rf <- randomForest(train$labels ~ ., data = train$data, ntree=300, importance=TRUE)
print(train.rf)
save(train.rf,file = "1-model")
imp <- importance(train.rf, type=1)
print(imp)
varImpPlot(train.rf)
writeLines("..Model file has been saved!"); 

