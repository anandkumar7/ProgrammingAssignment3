# ProgrammingAssignment3
Getting And Cleaning Data.

## Introduction

This program uses data from the accelerometers from the Samsung Galaxy S smartphone which is provided in the assignment web link.  It uses R Programming functionalities to achive the result. It calculates the average of each  mean and standard deviation variable for each activity and each subject for test and training data.

## It applies the following functionalities to get the final result.

*1.Merges the training and the test sets to create one data set.
*2.Extracts only the measurements on the mean and standard deviation for each measurement. 
*3.Uses descriptive activity names to name the activities in the data set
*4.Appropriately labels the data set with descriptive variable names. 
*5.Calculate the average of each  mean and standard deviation variable for each activity and each subject for test and training data.

## Following are the activities performed on the web link data to get the desired result.

### Setting the working dir
It sets the working dir to my working directory of R.
### setting the package path and loading the packages
It sets the packages paths and loads the libraries  data.table, plyr and dplyr which are used.
### Download the zip and unzip it (This is commented as this is not part of assignment)
It download the Zip file of the assignment. Though this step is commented out since it is not part of assignment.
It unzips the file in a directory.  Though this step is commented out since it is not part of assignment.
The data has already been downloaded, unzipped and kept in c3w3_project directory in the R working directory. The c3w3_project has been pre created to easily distinguish a folder for Course 3 assignment.
### Reading the training and test data along with lables and subjects 
It reads the training data, training lable data, training subject data in separate tables.
It reads the test data, test lable data, test subject data in separate tables.
It reads the feature label and activity labels in separate tables.
### Finding the duplicates in feature labels
The feature lables has some duplicate columns. 
It finds the list of unique(de-duplicated) columns and store in a variable.
It assigns all the feature labels (561) to the test and training data column names, since they have 561 columns.
### Remove the duplicate columns from the test and training data.
It uses the de-duplicated columns list to get the unique columns (de -duplicated) from the training  and test data.
### Assign the activity and subject columns to training and test data
It assignes the training and test columns to training and test data sets using cbind.
Now both the test and training data sets are ready to be merged.
### Merge the training and test data
It merges the training and test data sets on activity and subject columns, since the data is for specific activity performed by specific subject.
### Get only mean and std columns from the merged data set
It uses grep and match fuction to select only the mean and std columns from the merged dataset.
### Add the activity name to clearly read the activity.
### Distinguish the training and test variables
It uses gsub function to rename the columns of training data ending with .train and rename the test data ending with .test.
### summarize the mean and std columns on activity and subject to get the final mean of each columns.
It uses summarize_each function to get this.
### bring the activity name column from the end of data set to the begining of the data set.
It brings the activity name column from the end to the begining by rearranging the column list.
### write the data to a file
It writes the summary data to a file.

## How to run the run_analysis.R file

*Open the R.
*Then run the following command to get the final result.
*source("C:/anand/coursera_working_dir/run_analysis.R")

