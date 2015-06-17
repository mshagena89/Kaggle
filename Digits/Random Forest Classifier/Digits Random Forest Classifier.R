#Digits Data
#Random Forest classifier for Digit Recognizer Kaggle Competition
#michael.shagena@gmail.com
#6/16/2015



#################################################
# Load test and training data / req'd libraries
#################################################

library(readr)
library(randomForest)

#read in training and test data
path <- "C:\\Users\\Mike\\Desktop\\Digits Data\\train.csv"
path.test <- "C:\\Users\\Mike\\Desktop\\Digits Data\\test.csv"

digits.train <- read.csv(path, header = TRUE )
digits.test <- read.csv(path.test, header = TRUE )


#take a first look at train dataset
print(digits.train[1:5,1:5])
head(digits.train)
summary(digits.train)
dim(digits.train)

#################################################
# End load test and training data
#################################################


#################################################
# Random Forest classifier
#################################################


#sample training data for quick processing, use only 5000 obs for first pass
set.seed(1234)
nobs <- 5000

#created sampled dataset
digits.train.sample <- digits.train[sample(nrow(digits.train), nobs), ]

#create matrix of predictor training variables
predictors <- digits.train.sample[,-1]

#create matrix of response training variables 
response <- as.factor(digits.train.sample[,1])
response[1:50]

#run random forest algo on sampled training data 
#xtest will scored test dataset while RF is running
rfDigits <- randomForest(predictors, response, ntree=500, xtest = digits.test )


#check out the predicted values on test set
head(rfDigits$predicted)

#create a predictions data frame, for output to CSV submission
predictions <- data.frame(ImageId=1:nrow(digits.test), Label= rfDigits$test$predicted)
head(predictions)


#output csv file
outPath <- "C:\\Users\\Mike\\Desktop\\Digits Data\\out.csv"
write.csv(predictions, file = outPath, row.names = FALSE )


#################################################
# End Random Forest classifier
#################################################
