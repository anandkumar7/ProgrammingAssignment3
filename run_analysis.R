##course 3 project

## set the working dir
setwd("C:/anand/coursera_working_dir")
## get the library paths
.libPaths( c( .libPaths(), "C:/anand/software/r-analytics/packages") )

## load the libraries
packages <- c("data.table","plyr","dplyr")
sapply(packages, require, character.only = TRUE, quietly = TRUE)

 
##Download the Zip file of the assignment
##url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##f <- file.path(getwd(),"c3w3_project", "Dataset.zip")
##download.file(url, f)

##Unzip the file
##unzip(f,exdir="./c3w3_project")

##Read the training label data
y_train_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","train","y_train.txt")
train_label_data <- read.table(y_train_path)

##Read the training data
x_train_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","train","X_train.txt")
train_data <- read.table(x_train_path)

## Read the training subject data
train_subject_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","train","subject_train.txt")
train_subject_data <- read.table(train_subject_path)

##Read the test label data
y_test_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","test","y_test.txt")
test_label_data <- read.table(y_test_path)

##Read the test data
x_test_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","test","X_test.txt")
test_data <- read.table(x_test_path)

## Read the test subject data
test_subject_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","test","subject_test.txt")
test_subject_data <- read.table(test_subject_path)

##Read the feature labels
feature_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","features.txt")
feature_name <- read.table(feature_path)

##Read the activity names
activity_label_path <- file.path(getwd(),"c3w3_project","UCI HAR Dataset","activity_labels.txt")
activity_labels <- read.table(activity_label_path)



##Get a list of non duplicate columns from Feature lables
feature_name$duplicate_name <- duplicated(feature_name[,2])
non_dup_cols <- feature_name[feature_name$duplicate_name == FALSE,1]

##assign feature names as column names to test data
names(test_data) <- feature_name[,"V2"]

##assign feature names as column names to train data
names(train_data) <- feature_name[,"V2"]

##Remove duplicate columns from training and test observations
test_data <- test_data[,non_dup_cols]
train_data <- train_data[,non_dup_cols]

## assign the activity column name to activity observations 
##to test and training data
names(test_label_data) <- "activity"
names(train_label_data) <- "activity"

## assign the subject column name to subject observations 
##to test and training data
names(train_subject_data) <- "subject"
names(test_subject_data) <- "subject"


##column bind the activity number and subject name to test data
test_data <- cbind(test_label_data,test_subject_data,test_data)

##column bind the activity number and subject name to training data
train_data <- cbind(train_label_data,train_subject_data,train_data)

##merge the training and test data based upon activity and subject
mergedData_all <- merge(train_data,test_data,by=c("activity","subject"), all=TRUE)

##get a column list of activity, subject and mean and std observations from 
##training and test merged observations

toMatch <- c("mean","std")
get_mean_std_col_names <- grep(paste(toMatch,collapse="|"), names(mergedData_all), value=TRUE)
column_list <- c("activity","subject",c(get_mean_std_col_names))

##select the activity, subject, mean and std columns from merged data
selected_data <- mergedData_all[,column_list]

##rename the training observations ending with train
##rename the test observations ending with test
column_list <- names(selected_data)
column_list <- gsub(".x",".train",column_list,fixed=TRUE)
column_list <- gsub(".y",".test",column_list,fixed=TRUE)
names(selected_data) <- column_list

##Add the descriptive activity name in the dataset
selected_data$activity_name <- activity_labels[selected_data$activity,"V2"]

##Summarize the observations on group by activity and then by subject
## get the summary data as mean values of all the selected observations
summary_data <- summarise_each(group_by(selected_data,activity,subject),funs(mean),c(3:160))

##add the activity name column in summary data
summary_data$activity_name <- activity_labels[summary_data$activity,"V2"]

##select the activity name column first then the rest of columns 
summary_data <- summary_data[,c(161,1:160)]

##write the summary data to a text file course_3_project.txt
write.table(summary_data,"course_3_project_result.txt",row.names = FALSE)
