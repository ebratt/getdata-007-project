getdata-007-project
===================

This is my final project for the getdata-007 Coursera class. 

#### How do I run the analysis?
Run the `run_analysis.R` script with R (or RStudio)

#### What will happen when I do this?
The `run_analysis.R` script will perform the following:
- Load the packages: `lubridate` and `dplyr`, 
- Create a directory called `data` in your working directory, 
- Download an archive file called `data.zip` inside the `data` directory, 
- Unzip the `data.zip` file into another sub-folder called `UCI HAR Dataset`, 
- Inside the `UCI HAR Dataset` sub-folder you will see the following:
  - `activity_labels.txt` (contains the labels for the activities data)
  - `features.txt` (contains the raw feature column names)
  - `features_info.txt` (contains meta-data regarding the features)
  - `README.txt` (contains high-level summary of the data)
  - `test` (folder)
    - `Inertial Signals` (folder)
      - `body_acc_x_test.txt`
      - `body_acc_y_test.txt`
      - `body_acc_z_test.txt`
      - `body_gyro_x_test.txt`
      - `body_gyro_y_test.txt`
      - `body_gyro_z_test.txt`
      - `total_acc_x_test.txt`
      - `total_acc_y_test.txt`
      - `total_acc_z_test.txt`
    - `subject_test.txt`
    - `X_test.txt` (contains the test data observations)
    - `Y_test.txt` (contains the test data participant id's)
  - `train` (folder)
    - `Inertial Signals` (folder)
      - `body_acc_x_train.txt`
      - `body_acc_y_train.txt`
      - `body_acc_z_train.txt`
      - `body_gyro_x_train.txt`
      - `body_gyro_y_train.txt`
      - `body_gyro_z_train.txt`
      - `total_acc_x_train.txt`
      - `total_acc_y_train.txt`
      - `total_acc_z_train.txt`
    - `subject_train.txt`
    - `X_train.txt` (contains the training data observations)
    - `Y_train.txt` (contains the training data participant id's)

The `data` folder will have a file called `tidy_data.txt`. This is the output of the `run_analysis.R` script. 