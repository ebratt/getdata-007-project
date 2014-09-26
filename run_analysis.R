## subject: Coursera getdata-007 final project
## title: "run_analysis.R"
## author: "Eric Bratt"
## date: "Wednesday,September 17,2014"
## output: R script
################################################################################
## clear out the environment
rm(list=ls())

################################################################################
## function that checks to see if a package is installed and,if not,installs it
## portions of this code came from http://stackoverflow.com/questions/9341635/how-can-i-check-for-installed-r-packages-before-running-install-packages
load_package <- function(x) {
  if (x %in% rownames(installed.packages())) { print("package already installed...") }
  else { install.packages(x) }
}

################################################################################
# install necessary packages
load_package("lubridate") # for easy date-handling
load_package("dplyr")     # for data manipulation (ie, joining data frames)

# load necessary libraries
library(lubridate)
library(dplyr)

################################################################################
## UTILITY FUNCTIONS
## function that reads a file and returns a data.frame
read_file <- function(x) {
    result <- read.table(x,header=F,strip.white=T)
    return(result)
}

## function that concatenates strings (useful for directory paths)
concat <- function(x1,x2) {
  result <- paste(x1,x2,sep="")
  return(result)
}

################################################################################
## define some global variables
DATA_DIR          <- "./data"
DATASET_DIR         <- concat(DATA_DIR,"/UCI HAR Dataset")
TEST_DIR            <- concat(DATASET_DIR,"/test")
TRAIN_DIR           <- concat(DATASET_DIR,"/train")
TEST_FILE           <- concat(TEST_DIR,"/X_test.txt")
TEST_LABELS_FILE    <- concat(TEST_DIR,"/Y_test.txt")
TEST_SUBJECTS_FILE  <- concat(TEST_DIR,"/subject_test.txt")
TRAIN_FILE          <- concat(TRAIN_DIR,"/X_train.txt")
TRAIN_LABELS_FILE   <- concat(TRAIN_DIR,"/Y_train.txt")
TRAIN_SUBJECTS_FILE <- concat(TRAIN_DIR,"/subject_train.txt")
FEATURES_FILE       <- concat(DATASET_DIR,"/features.txt")
DATA_FILE           <- concat(DATA_DIR,"/data.zip")
FILE_URL            <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
LABELS_FILE         <- concat(DATASET_DIR,"/activity_labels.txt")
EXTRACT_FILE        <- concat(DATA_DIR,"/tidy_data.txt")

################################################################################
# ensure the local data directory exists
if (!file.exists(DATA_DIR)) { dir.create(DATA_DIR) }
# log the date the archive was downloaded
dateDownloaded <- now()
# download the archive file
if (.Platform$OS.type == "unix") {
    download.file(FILE_URL,destfile = DATA_FILE,method="curl")
} else {
    download.file(FILE_URL,destfile = DATA_FILE)
}
# unzip the archive file to the data directory
unzip(DATA_FILE,exdir = DATA_DIR)

################################################################################
# step 1. Merge the training and the test sets to create one data set.         #
################################################################################
test  <- read_file(TEST_FILE)
train <- read_file(TRAIN_FILE)

# replace activity labels
labels              <- read_file(LABELS_FILE)
names(labels)       <- c("activityid", "activity")
test_labels         <- read_file(TEST_LABELS_FILE)
names(test_labels)  <- c("activityid")
test_labels         <- inner_join(test_labels, labels)
train_labels        <- read_file(TRAIN_LABELS_FILE)
names(train_labels) <- c("activityid")
train_labels        <- inner_join(train_labels, labels)

# add a column to each data table for labels
test$activityid  <- test_labels$activityid
test$activity    <- test_labels$activity
train$activityid <- train_labels$activityid
train$activity   <- train_labels$activity

# add a column to each data table for subjects
test_subjects         <- read_file(TEST_SUBJECTS_FILE)
names(test_subjects)  <- c("subject")
test$subject          <- test_subjects$subject
train_subjects        <- read_file(TRAIN_SUBJECTS_FILE)
names(train_subjects) <- c("subject")
train$subject         <- train_subjects$subject

# combine test and train data
data <- rbind(test,train)

# clean-up the feature names
cols<-read_file(FEATURES_FILE)
cols<-as.vector(cols[,2])                              # convert to a character vector
cols<-gsub("-","",cols)                                # remove -'s
cols<-gsub("^t","Time",cols)                           # replace t with Time
cols<-gsub("^f","Frequency",cols)                      # replace f with Frequency
cols<-gsub("Acc","Acceleration",cols)                  # replace Acc with Acceleration
cols<-gsub("gyro","AngularVelocity",cols)              # replace gyro with AngularVelocity
cols<-gsub("Mag","Magnitude",cols)                     # replace Mag with Magnitude
cols<-gsub("X","Xdirection",cols)                      # replace X with Xdirection
cols<-gsub("Y","Ydirection",cols)                      # replace Y with Ydirection
cols<-gsub("Z","Zdirection",cols)                      # replace Z with Zdirection
cols<-gsub("mean","Mean",cols)                         # replace mean with Mean
cols<-gsub("std","STD",cols)                           # replace std with STD
cols<-gsub("mad","MedianAbsoluteDeviation",cols)       # replace mad with MedianAbsoluteDeviation
cols<-gsub("max","Max",cols)                           # replace max with Max
cols<-gsub("min","Min",cols)                           # replace min with Min
cols<-gsub("sma","SignalMagnitudeArea",cols)           # replace sma with Signal MagnitudeArea
cols<-gsub("energy","Energy",cols)                     # replace energy with Energy
cols<-gsub("iqr","InterQuartileRange",cols)            # replace iqr with InterQuartileRange
cols<-gsub("entropy","Entropy",cols)                   # replace entropy with Entropy
cols<-gsub("arCoeff","AutoRegressionCoefficient",cols) # replace arCoeff with AutoRegressionCoefficient
cols<-gsub("correlation","Correlation",cols)           # replace correlation with Correlation
cols<-gsub("maxInds","MaxMagnitudeIndex",cols)         # replace maxInds with MaxMagnitudeIndex
cols<-gsub("Freq","Frequency",cols)                    # replace Freq with Frequency
cols<-gsub("skewness","Skewness",cols)                 # replace skewness with Skewness
cols<-gsub("kurtosis","Kurtosis",cols)                 # replace kurtosis with Kurtosis
cols<-gsub("bandsEnergy","BandsEnergy",cols)           # replace bandsEnergy with BandsEnergy
cols<-gsub("angle","Angle",cols)                       # replace angle with Angle
cols<-gsub("gravity","Gravity",cols)                   # replace gravity with Gravity
cols<-gsub("\\(","",cols)                              # remove ('s
cols<-gsub("\\)","",cols)                              # remove )'s
cols<-gsub(",","to",cols)                              # remove ,'s

# apply features to data
cols <- c(cols, "activityid", "activity", "subject")
names(data) <- cols

################################################################################
# step 2. Extracts only the measurements on the mean and standard deviation    #
#         for each measurement.                                                #
################################################################################
mean_cols    <- grep("Mean", cols,value=T)
STD_cols     <- grep("STD", cols,value=T)
extract_cols <- c(mean_cols, STD_cols, "activityid", "activity", "subject")
extract      <- data[,extract_cols]

################################################################################
# step 3. Use descriptive activity names to name the activities in the data set#
################################################################################
#summary(extract$activity)

################################################################################
# step 4. Appropriately labels the data set with descriptive variable names.   #
################################################################################
#names(extract)

################################################################################
# step 5. From the data set in step 4, creates a second, independent tidy data #
#         set with the average of each variable for each activity and each     #
#         subject.                                                             #
################################################################################
tidy_extract <- extract[, names(extract) != "activityid"] %>% group_by(activity, subject) %>% summarise_each(funs(mean))
write.table(tidy_extract, file=EXTRACT_FILE,sep=",",row.name=FALSE)
