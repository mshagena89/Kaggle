#Digits Data
#Neural Network classifier for Digit Recognizer Kaggle Competition
#michael.shagena@gmail.com
#6/17/2015

#USE PCA for variable reduction, then feed pca inputs into neural net model
library(caret)


#run neural network with 10 hidden layers
#PCA thresh captures 99% of variance in components

#create new data frame for nnet model fitting (10,000 obs)
nobs <- 10000
digits.train.nnet <- digits.train[sample(nrow(digits.train), nobs), ]

#convert label to factor
digits.train.nnet$label <- factor(digits.train.nnet$label)

#need to use formula call of nnet for classification
#size (hidden values) limited by ram on local machine
digits.nnet <- pcaNNet(label ~ ., data = digits.train.nnet, size = 20, MaxNWts = 20000)

#output class predictions basd
digits.nnet.predictions <- predict(digits.nnet, digits.test, type = "class")
head(digits.nnet.predictions)


#create a predictions data frame, for output to CSV submission
predictions <- data.frame(ImageId=1:nrow(digits.test), Label= digits.nnet.predictions)
head(predictions)

#output csv file
outPath <- "C:\\Users\\Mike\\Desktop\\Digits Data\\neuralNetout.csv"
write.csv(predictions, file = outPath, row.names = FALSE )
