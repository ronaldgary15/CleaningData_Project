# OBJECTIVE
#
#  1. Merge the training and the test sets to create one data set.
#  2. Extract only the measurements on the mean and standard deviation 
#     for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, 
#     independent tidy data set with the average of each variable for each 
#     activity and each subject.

library(plyr); library(dplyr)

# Location of relevant files
x_train_loc <- "./UCI_HAR_Dataset/train/X_train.txt"
x_test_loc <- "./UCI_HAR_Dataset/test/X_test.txt"
features <- "./UCI_HAR_Dataset/features.txt"
y_train_loc <- "./UCI_HAR_Dataset/train/Y_train.txt"
y_test_loc <- "./UCI_HAR_Dataset/test/Y_test.txt"
subject_train_loc <- "./UCI_HAR_Dataset/train/subject_train.txt"
subject_test_loc <- "./UCI_HAR_Dataset/test/subject_test.txt"

## LOAD FILES
xTrain <- read.table(x_train_loc, header = TRUE, sep = "")
xTest <- read.table(x_test_loc, header = FALSE, sep = "")
feature_list <- read.table(features, header = FALSE, sep = "")
yTrain <- read.table(y_train_loc, header = TRUE, sep = "")
yTest <- read.table(y_test_loc, header = FALSE, sep = "")
subjectTrain <- read.table(subject_train_loc, header = TRUE, sep = "")
subjectTest <- read.table(subject_test_loc, header = FALSE, sep = "")

## RENAME HEADERS
# Convert feature_list to vector of names and add as column names for
# xTrain and xTest
feature_vector <- feature_list[,2]
colnames(xTrain) <- feature_vector
colnames(xTest) <- feature_vector

## SUBSET DATA BY HEADER
# Subset to columns containing mean and std
xTrain_MeanSTD <- xTrain[grepl("-mean|-std", colnames(xTrain))]
xTest_MeanSTD <- xTest[grepl("-mean|-std", colnames(xTest))]

## ADD ACTIVITY COLUMN
# Match activity level names to values on Y_train and Y_test
mapping <- c("1"="WALKING",
             "2"="WALKING_UPSTAIRS",
             "3"="WALKING_DOWNSTAIRS",
             "4"="SITTING",
             "5"="STANDING",
             "6"="LAYING")

# convert dataframe to vector
yTrainList <- yTrain[,1]
yTestList <- yTest[,1]

# Replace activity level number with name
yTrainListNames <- revalue(as.character(yTrainList), mapping)
yTestListNames <- revalue(as.character(yTestList), mapping)

# Add Activity list to Test and Train Dataframes
xTrain_ACT_MeanSTD <- cbind(yTrainListNames, xTrain_MeanSTD)
xTest_ACT_MeanSTD <- cbind(yTestListNames, xTest_MeanSTD)

# Rename Column headers for Activity
names(xTrain_ACT_MeanSTD)[1] <- "activity"
names(xTest_ACT_MeanSTD)[1] <- "activity"

## ADD TEST or TRAIN COLUMN
# Add test.train column to identify observation in combined table
xTrain_TT_ACT_MeanSTD <-cbind("test.train"= "TRAIN", xTrain_ACT_MeanSTD)
xTest_TT_ACT_MeanSTD <-cbind("test.train"= "TEST", xTest_ACT_MeanSTD)

## ADD SUBJECT ID COLUMN
# convert df to vector
subjectTrainList <- subjectTrain[,1]
subjectTestList <- subjectTest[,1]

# Add sublect lists to test and train datatables
xTrain_Tidy <- cbind(subjectTrainList, xTrain_TT_ACT_MeanSTD)
xTest_Tidy <- cbind(subjectTestList, xTest_TT_ACT_MeanSTD)

# Rename Column header to subject.id
names(xTrain_Tidy)[1] <- "subject.id"
names(xTest_Tidy)[1] <- "subject.id"

## MERGE Tables TOGETHER
tidydata <- rbind(xTrain_Tidy, xTest_Tidy)

## PRINT tidydata.csv
write.csv(tidydata, file="tidydata.csv")

