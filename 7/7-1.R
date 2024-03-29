library("e1071")
library(kernlab)
data(spam)
sampleindices <- sample(1:nrow(spam), nrow(spam)/2)
training <- spam[sampleindices, ]
test <- spam[-sampleindices, ]

svm_model_predict <- function(train, test, kernel="radial"){
	model <- svm(type ~ ., data=train, kernel=kernel, probability=TRUE)
	print(model)
	result <- predict(model, newdata=test, probability=TRUE, decision.values=TRUE)
	print(tb <- table(result, test$type))
	print(sum(diag(tb))/sum(tb))
}

tuned_svm_model_predict <- function(train, test, kernel="radial"){
	tuned <- tune.svm(type ~ ., data=train, gamma=2^c(seq(-15,0,1)), cost=2^c(seq(-2,1,0.5)), tunecontrol=tune.control(cross=3))
	print(summary(tuned))
	model <- svm(type ~ ., data=train, kernel=kernel, gamma=tuned$best.parameters["gamma"][[1]], cost=tuned$best.parameters["cost"][[1]], probability=TRUE)
	print(model)
	result <- predict(model, newdata=test, probability=TRUE, decision.values=TRUE)
	print(tb <- table(result, test$type))
	print(sum(diag(tb))/sum(tb))
}


svm_model_predict(training, test, kernel="linear")
svm_model_predict(training, test, kernel="polynomial")
svm_model_predict(training, test, kernel="radial")
svm_model_predict(training, test, kernel="sigmoid")

tuned_svm_model_predict(training, test, kernel="radial")