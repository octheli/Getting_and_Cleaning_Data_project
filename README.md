README
Project of Getting and Cleaning Data
Li He

### Introduction

The "run_analysis.R" script gets and cleans the Human Activity Recognition database built from the 
recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted 
smartphone with embedded inertial sensors. Details about the database are available at the site:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Input and output of "run_analysis.R"

Input parameters: none.
-	The raw data is automatically downloaded from the following site:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Output: "Result.txt".
-	It contains a tidy data with the average of selected variables grouped by each activity and 
each subject.
-	The selected variables are either mean or standard deviation of measurements.
-	For example, the "tBodyAcc-mean()-X" is one variable. It is the average of the mean body 
acceleration along the x-axis for every combination of activities and subjects.
-	For 6 different activities and 30 subjects, there are 6×30 = 180 rows.
-	See "The code book.txt" for details about "Result.txt".

### Instruction of using "run_analysis.R"

Step 1 - Save "run_analysis.R" in a directory that you will use as the working directory.

Step 2 - Run R version 3.2.4.
	To check R version, key in the following in the command window:
	> R.version.string
	
Step 3: If you have not used the "dplyr" package before, install "dplyr". 
	> install.packages("dplyr")

Step 3: Set the working directory as the one containing "run_analysis.R". Let dir to be the character 
	string of the directory path,
	> setwd(dir)

Step 4: Key in the following lines:
	> source("run_analysis.R")
	> run_analysis()

Step 5: Find the raw data in the "projecData.zip" file and the "./UCI HAR Dataset" folder.
	The output data is in the "Result.txt".