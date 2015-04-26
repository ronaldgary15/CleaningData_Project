
#CleaningData_Project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

#ABOUT THE DATA  
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R script called run_analysis.R does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 

#Summary of run_analysis.R script
1.  Read the relevant files (not all files used in UCI_HAR_Dataset)
	X_train.txt - Training set
	X_test.txt - Test set
	features.txt - Information on the Variables used ad solumn headers
	Y_train.txt - Training labels.
	Y_test.txt - Test labels.
	subject_train.txt - Identity of the subject for each training observation
	subject_test.txt - Identity of the subject for each test observation.
2.  Rename headers
	Assign features.txt to test and train tables as column headers.
3.  Subset Columns
	use grepl to match "-mean" and "-std" to identify required columns.
4.  Add activity column
	cbind Y_train and Y_test accordingly.
5.  Add subject id column 
	cbind cubject_train and subject_train to test and train tables
6.  Merge the test and train tables
	rbind train and test tables
7.  output tidy csv file
	write.csv the tidy table to csv file.
	
