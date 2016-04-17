run_analysis <- function(){
## A project in the course of Getting and Cleaning Data.
## The data is collected from the accelerometers from the Samsung Galaxy S smartphone.
## A full description is available at the site below:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## run_analysis.R does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.  

## Download the data file and save it as "projectData.zip" in the current working directory.

    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, "projectData.zip", mode = "wb")
    
## Unzip "projectData.zip" to the current working directory.
    
    dataFilePath <- unzip("projectData.zip")

## "dataFilePath" is a character vector containing all the unzipped file paths.
## dataFilePath 
##  [1] "./UCI HAR Dataset/activity_labels.txt"                         
##  [2] "./UCI HAR Dataset/features.txt"
##  ...
##  [14] "./UCI HAR Dataset/test/subject_test.txt"                       
##  [15] "./UCI HAR Dataset/test/X_test.txt"                             
##  [16] "./UCI HAR Dataset/test/y_test.txt"                             
##  ...
##  [26] "./UCI HAR Dataset/train/subject_train.txt"                     
##  [27] "./UCI HAR Dataset/train/X_train.txt"                           
##  [28] "./UCI HAR Dataset/train/y_train.txt"
    
## Read the training data "X_train.txt".
    
    x_train <- read.table(dataFilePath[27])
    
## Read the test data "X_test.txt".
    
    x_test <- read.table(dataFilePath[15])
    
## Task 1: Merges the training and the test sets to create one data set.
    
    mergeTrainTest <- rbind(x_train, x_test)
    
## Read the column names from "feature.txt".
    
    feature <- read.table(dataFilePath[2])

## "feature" is a data frame.
## Its V2 column contains the variable names of the trainining and test data.

## Task 4: Appropriately labels the data set with descriptive variable names.
    
    names(mergeTrainTest) <- feature$V2
    
## Find the variable names containing "mean()" or "std()".
## They are the mean and standard deviation for each measurement.
    
    meanAndStd_index <- grep("mean\\(\\)|std\\(\\)", names(mergeTrainTest))
    
## Task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
    
    meanAndStd <- mergeTrainTest[, meanAndStd_index]

## Read activity from "y_train.txt" and "y_test.txt".
    
    y_train <- read.table(dataFilePath[28])
    y_test <- read.table(dataFilePath[16])
    
## Append the activity of the test data after that of the training data.
## This is the activity of the merged data.
    
    activity <- append(y_train$V1, y_test$V1)
    
## Read "activity_labels.txt".
    
    activity_labels <- read.table(dataFilePath[1])

## "activity" is an integer vector.
## The meanning of the numbers is given in "activity_labels.txt".
##  activity_labels
##   V1                 V2
##    1            WALKING
##    2   WALKING_UPSTAIRS
##    3 WALKING_DOWNSTAIRS
##    4            SITTING
##    5           STANDING
##    6             LAYING
    
## Change "activity" from numbers to the descriptive activity names.
    
    activity <- as.character(activity_labels$V2[match(activity, activity_labels$V1)])

## "subject_train.txt" and "subject_test.txt" contain the person IDs (1-30).
## Read and combine the subject list.
    
    subject_train <- read.table(dataFilePath[26])
    subject_test <- read.table(dataFilePath[14])
    subject <- append(subject_train$V1, subject_test$V1)
    
## Task 3: Uses descriptive activity names to name the activities in the data set.
    
## Include the "activity" and "subject" variables to the "meanAndStd" dataset.
    
    meanAndStd <- cbind(activity=activity, subject=subject, meanAndStd)
    
## Use the package "dplyr". Let "meanAndStd" to be a table.
    
    library(dplyr)
    meanAndStd <- as.tbl(meanAndStd)

## meanAndStd
## Source: local data frame [10,299 x 68]
    
##        activity        subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z 
##        (fctr)          (int)             (dbl)             (dbl)             (dbl)
##  1     STANDING          1          0.2885845         -0.020294171   -0.1329051     
##  2     STANDING          1          0.2784188         -0.016410568   -0.1235202     
##  3     STANDING          1          0.2796531         -0.019467156   -0.1134617
##  ...
##  10299 WALKING_UPSTAIRS  24         0.1536272         -0.01843651    -0.1370185
##  Variables not shown: tBodyAcc-std()-X, tBodyAcc-std()-Y (dbl), tBodyAcc-std()-Z (dbl),
##  ...,fBodyBodyGyroJerkMag-std() (dbl)
    
## Task 5: From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.        

    average <- summarize_each(group_by(meanAndStd, activity, subject), funs(mean))
    
## average
## Source: local data frame [180 x 68]
## Groups: activity [?]
##      activity        subject tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
##      (fctr)          (int)             (dbl)             (dbl)             (dbl)           
## 1    LAYING            1         0.2215982       -0.04051395        -0.1132036      
## 2    LAYING            2         0.2813734       -0.01815874        -0.1072456      
## 3    LAYING            3         0.2755169       -0.01895568        -0.1013005      
##  ..      ...     ...               ...               ...               ...              
## 180  WALKING_UPSTAIRS  30        0.2714156       -0.02533117        -0.1246975
## Variables not shown: tBodyAcc-std()-X, tBodyAcc-std()-Y (dbl), tBodyAcc-std()-Z (dbl),
## ..., fBodyBodyGyroJerkMag-std() (dbl)

## "average" is the result. Write it into a file.
    
    write.table(average, file = "Result.txt")
}