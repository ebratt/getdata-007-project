getdata-007-project
===================

This is my final project for the getdata-007 Coursera class. 

#### How do I run the analysis?
Run the `run_analysis.R` script with R (or RStudio)

#### What will happen when I do this?
The `run_analysis.R` script will perform the following:
1. Load the packages: `lubridate` and `dplyr`, 
2. Create a directory called `data` in your working directory, 
2. Download an archive file called `data.zip` inside the `data` directory, 
3. Unzip the `data.zip` file into another sub-folder called `UCI HAR Dataset`, 
4. Inside the `UCI HAR Dataset` sub-folder you will see the following:
  - `activity_labels.txt`
  - `features.txt`
  - `features_info.txt`
  - `README.txt`
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
    - `X_test.txt`
    - `Y_test.txt`
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
    - `X_train.txt`
    - `Y_train.txt`

The `data` folder will have a file called `tidy_data.txt`. This is the output of the `run_analysis.R` script. 