# Load packages
library(randomForest)
library(verification)
library(ggplot2)
library(pROC)

set.seed(777)
setwd("~/Rho_prediction")

# Read in data
data_train = read.csv("./ml-result/145-trn.csv", header = TRUE)
data_test = read.csv("./ml-result/145-test.csv", header = TRUE)

# Select only the columns that you need for the model
df_train = data_train[, grep("^f", colnames(data_train))]
df_train = df_train[, -grep("distance", colnames(df_train))]

# Random Forest model
fit.all <- randomForest(as.factor(f0) ~ ., data = df_train)

# Error Rate
rfcv.res = rfcv(df_train[, -1], df_train[, 1])
plot(rfcv.res$n.var, rfcv.res$error.cv, log="x", type="o", lwd=2,
     xlab="Number of Variables", ylab="Error Rate")
lines(rfcv.res$n.var, rfcv.res$error.cv)
title(main="Estimated Error Rate")
print(rfcv.res$error.cv)

# 5-fold cross validation
k = 5
val_err = rep(0, k)
n = floor(nrow(df_train) / k)
sub_train <- df_train[sample(nrow(df_train)), ]

for (i in 1:k) {
  sub1 = ((i-1) * n + 1)
  sub2 = (i * n)
  subset = sub1:sub2
  cross_val.trn = sub_train[-subset, ]
  cross_val.test = sub_train[subset, ]
  fit.sub <- randomForest(as.factor(f0) ~ ., data = cross_val.trn)
  Prediction_crossval = predict(fit.sub, cross_val.test, type = "prob")
  cross_val.test$response <- ifelse(cross_val.test$f0 == "1", 1, 0)
  list_roc = roc(cross_val.test$response, Prediction_crossval[, 2])
  val_err[i] = list_roc$auc
  if (i == 1) {
    plot.roc(list_roc, legacy.axes = TRUE, print.auc = TRUE, print.auc.x = 0.30)
  } else {
    plot.roc(list_roc, legacy.axes = TRUE, print.auc = TRUE, add = TRUE, col = i, print.auc.y = 0.80)
  }
}

# Model evaluation
print(mean(val_err))
