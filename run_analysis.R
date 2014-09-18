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
load_package("reshape2")  # for reshaping data structures
load_package("stringr")   # for string processing
load_package("dplyr")     # for data manipulation and querying
load_package("tidyr")     # for tidying-up data
load_package("xtable")    # for pretty exporting of data

# load necessary libraries
library(lubridate)
library(reshape2)
library(stringr)
library(dplyr)
library(tidyr)

# source other R scripts
source("xtable.r")

################################################################################
## UTILITY FUNCTIONS
## function that reads a file and returns a data.frame
read_data_file <- function(x) {
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
DATA_DIR    <- "./data"
DATASET_DIR <- concat(DATA_DIR,"/UCI HAR Dataset")
TEST_DIR    <- concat(DATASET_DIR,"/test")
TRAIN_DIR   <- concat(DATASET_DIR,"/train")

################################################################################
# define the data archive URL
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# ensure the local data directory exists
if (!file.exists(DATA_DIR)) { dir.create(DATA_DIR) }
# log the date the archive was downloaded
dateDownloaded <- now()
# download the archive file
download.file(fileURL,destfile = concat(DATA_DIR,"/data.zip"))
# unzip the archive file to the data directory
unzip(concat(DATA_DIR,"/data.zip"),exdir = DATA_DIR)

################################################################################
# step 1. Merge the training and the test sets to create one data set.         #
################################################################################
test  <- read_data_file(concat(TEST_DIR,"/X_test.txt"))
train <- read_data_file(concat(TRAIN_DIR,"/X_train.txt"))
data  <- rbind(test,train)

# clean-up the feature names
cols<-read_data_file(concat(DATASET_DIR,"/features.txt"))
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
names(data) <- cols