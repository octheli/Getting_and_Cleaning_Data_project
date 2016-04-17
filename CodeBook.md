The Code Book
Project of Getting and Cleaning Data
Li He

### Introduction

“Result.txt” is a secondary, independent data set based on Davide Anguita et al.’s Human Activity 
Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) 
while carrying a waist-mounted smartphone with embedded inertial sensors. Details about the database 
are available at the site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Information about the variables in "Result.txt".

“Result.txt” is the output file from running the “run_analysis.R”. It contains the average values of mean 
or standard deviation variables for every activity and every subject.

There are 68 variables.
Variable 1, "activity": Subjects’ activities.
       Class: factor.
       Units: none.
       There are 6 kinds of activities:
-	WALKING
-	WALKING_UPSTAIRS
-	WALKING_DOWNSTAIRS
-	SITTING
-	STANDING
-	LAYING
Variable 2, "subject": integers 1, 2, 3… 30, representing 30 persons performing activities.
       Class: integer.
	Units: none.
Variables 3-68, the average variables for each activity and each subject, normalized and bounded within 
[-1, 1].
       Class: numeric.
       Unites: none.
       They are: 
"tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z",
"tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z",
"tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z",
"tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z",
"tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z",
"tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z",
"tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z",
"tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z",
"tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z",
"tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z",
"tBodyAccMag-mean()","tBodyAccMag-std()",
"tGravityAccMag-mean()","tGravityAccMag-std()"
"tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()",
"tBodyGyroMag-mean()","tBodyGyroMag-std()",
"tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()",
"fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z",
"fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z",
"fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z",
"fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z"
"fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z"
"fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z"
"fBodyAccMag-mean()", "fBodyAccMag-std()",
"fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()"
"fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()"
"fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()"
Details about the original variables are available at this site:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Partial printout of the result data

average
Source: local data frame [180 x 68]
Groups: activity [?]
      activity        subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
      (fctr)          (int)             (dbl)             (dbl)             (dbl)           
 1    LAYING            1         0.2215982       -0.04051395        -0.1132036      
 2    LAYING            2         0.2813734       -0.01815874        -0.1072456      
 3    LAYING            3         0.2755169       -0.01895568        -0.1013005      
  ..      ...     ...               ...               ...               ...              
 180  WALKING_UPSTAIRS  30        0.2714156       -0.02533117        -0.1246975
 Variables not shown: tBodyAcc-std()-X, tBodyAcc-std()-Y (dbl), tBodyAcc-std()-Z (dbl), ..., fBodyBodyGyroJerkMag-std() (dbl)

### Study design

“run_analysis.R” carries out the following work. The commands in  every steps are included.

Step 1: Download the dataset. Unzip it to the current working directory. 

	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    	download.file(url, "projectData.zip", mode = "wb")
	dataFilePath <- unzip("projectData.zip")

Step 2: Read “X-train.txt” and “X-test.txt”. Merge them to become a new data “mergeTrainTest”.

	x_train <- read.table(dataFilePath[27])
	x_test <- read.table(dataFilePath[15])
	mergeTrainTest <- rbind(x_train, x_test)

Step 3: Read “feature.txt”. Use it to name the 561 variables in “mergeTrainTest”.

	feature <- read.table(dataFilePath[2])
	names(mergeTrainTest) <- feature$V2

Step 4: Extract the variables in “mergeTrainTest” with names containing either “mean()” or “std()”, 
meaning mean or standard deviation. Store the 66 variables in a new data “meanAndStd”.

	meanAndStd_index <- grep("mean\\(\\)|std\\(\\)", names(mergeTrainTest))
	meanAndStd <- mergeTrainTest[, meanAndStd_index]

Step 5: Read “y_train.txt” and “y_test.txt”. Merge them to “activity”, a vector containing integers 1-6.

	y_train <- read.table(dataFilePath[28])
    	y_test <- read.table(dataFilePath[16])
	activity <- append(y_train$V1, y_test$V1)

Step 6: Read “activity_labels.txt”. Replacing the numbers in “activity” with their corresponding labels
such as WALKING, SITTING, etc.

	activity_labels <- read.table(dataFilePath[1])
 	activity <- as.character(activity_labels$V2[match(activity, activity_labels$V1)]

Step 7: Read “subject_train.txt” and “subject_test.txt”. Merge them to “subject”.

	subject_train <- read.table(dataFilePath[26])
    	subject_test <- read.table(dataFilePath[14])
    	subject <- append(subject_train$V1, subject_test$V1)

Step 8: Add variables “activity” and “subject” into “meanAndStd”.

	meanAndStd <- cbind(activity=activity, subject=subject, meanAndStd)

Step 9: Create a new data “average”, the average of the variables in “meanAndStd” grouped by each 
activity and each subject.

	library(dplyr)
    	meanAndStd <- as.tbl(meanAndStd)
	average <- summarize_each(group_by(meanAndStd, activity, subject), funs(mean))

Final step 10: Write “average” into a “Result.txt”.
	
	write.table(average, file = "Result.txt")


