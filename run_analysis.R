## subject: Coursera getdata-007 final project
## title: "run_analysis.R"
## author: "Eric Bratt"
## date: "Wednesday, September 17, 2014"
## output: R script
## clear out the environment
rm(list=ls())
# load necessary libraries
require("lubridate")
library(lubridate)

## function that reads a file and returns a data.frame
read_file <- function(file_loc) {
    result <- read.table(file_loc, header=F, strip.white=T)
    return(result)
}

# define the file's URL
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# ensure the data directory exists
if (!file.exists("./data")) {
    dir.create("./data")
}
# track the data the data was downloaded
dateDownloaded <- now()
# download the archive file
download.file(fileURL, destfile = "./data/data.zip")
# unzip the archive file to the data directory
unzip("./data/data.zip", exdir = "./data")

# step 1. Merges the training and the test sets to create one data set.
test <- read_file("./data/UCI HAR Dataset/test/X_test.txt")
train <- read_file("./data/UCI HAR Dataset/train/X_train.txt")




