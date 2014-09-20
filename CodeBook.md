---
title: "CodeBook for Coursera getdata-007"
author: "Eric Bratt"
date:   "Wednesday, September 17, 2014"
---

The goal of this analysis "...is to prepare tidy data that can be used for later analysis."

This code book "...describes the variables, the data, and any transformations or work that [I] performed to clean up the data..."

Raw data comes from:

......................................................................

Human Activity Recognition Using Smartphones Dataset

Version 1.0

......................................................................

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Università degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition@smartlab.ws

www.smartlab.ws

......................................................................

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

(taken from the `README.txt` file)

For each record it is provided:

......................................................................

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

(taken from the `README.txt` file)


The dataset includes the following files:

......................................................................

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

(taken from the `README.txt` file)

There are other files included in the data that are not required by this analysis.

Each feature vector is a row on the text file.

(taken from the `README.txt` file)

####The variables, the data, and any transformations or work that I performed to clean up the data
#####Functions
`load_package()` is a function that checks to see if a package is installed and,if not,installs it

portions of this code came from http://stackoverflow.com/questions/9341635/how-can-i-check-for-installed-r-packages-before-running-install-packages

```
load_package <- function(x) {
  if (x %in% rownames(installed.packages())) { print("package already installed...") }
  else { install.packages(x) }
}
```

`read_file()` is a function that reads a file and returns a data.frame
```
read_file <- function(x) {
    result <- read.table(x,header=F,strip.white=T)
    return(result)
}
```

`concat()` is a function that concatenates strings (useful for directory paths)
```
concat <- function(x1,x2) {
  result <- paste(x1,x2,sep="")
  return(result)
}
```

#####Variables
- `DATA_DIR`          data directory created by `run_analysis.R`
- `DATASET_DIR`       dataset directory
- `TEST_DIR`          directory storing the test data
- `TRAIN_DIR`         directory storing the training data
- `TEST_FILE`         test data
- `TEST_LABELS_FILE`  test data labels
- `TRAIN_FILE`        training data
- `TRAIN_LABELS_FILE` training data labels
- `FEATURES_FILE`     features data
- `DATA_FILE`         downloaded archive (.zip) file
- `FILE_URL`          connection to the archived data source
- `LABELS_FILE`       activity labels data
- `EXTRACT_FILE`      output file

#####Data
- `test`              data.frame of test data
- `train`             data.frame of training data
- `labels`            data.frame of activity labels data
- `test_labels`       data.frame of activity labels for each test observation
- `train_labels`      data.frame of activity labels for each training observation
- `data`              data.frame of combined test and training data
- `cols`              vector of feature columns
- `mean_cols`         vector of column names containing `%Mean%`
- `STD_cols`          vector of column names containing `%STD%`
- `extract_cols`      vector of column names for the extract file
- `extract`           data.frame of a the `data` including only the `extract_cols`
- `tidy_extract`      tbl_df (from the `dplyr` package) containing the output

#####Transformations
- set column names of `labels`
- set column names of `test_labels`
- set column names of `train_labels`
- joined `labels` with `test_labels` and `train_labels` to get the activity type for each test and training observation
- added `activityid` and `activity` columns to `test` and `train` data.frame(s)
- renamed the feature names in `cols` to make more sense (I decided to use mixed-case due to the length of the column names)
- set column names of `data`
- created `extract` including only the `extract_cols`
- created `tidy_extract` using `group_by()` and `summarise_each` from `dplyr` package
- saved the `tidy_extract` as a comma-separated value in `tidy_data.txt`