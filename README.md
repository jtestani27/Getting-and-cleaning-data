# Getting and Cleaning Data Course Project


### Download and read data

        The data was downloaded from the following URL and unzipped in the project folder: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

        The features table was read as characters. This provided the names of the recorded variables. The features in the database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
        
        The test tables were read into R. X_test contains the features data. y_test contains the activity. subject_test contains the subject. The test tables were combined into a single test data frame with subject, activity, and features.
        
        The train tables were read into R. X_train contains the features data. y_train contains the activity. subject_train contains the subject. The train tables were combined into a single train data frame with subject, activity, and features.
        
### 1. Merges the training and the test sets to create one data set.

        The test and train data frames were combined into a single data frame, data.all, using rbind.
        
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

        Using the dplyr library, the subset of feature columns in data.all with mean and standard deviation values were selected and saved in a new data frame, data.sub.
        
### 3. Uses descriptive activity names to name the activities in the data set

        The activity_labels dataset was read into R as a character vector. The activity variable in the data.sub data frame was transformed into a factor variable with the activities character vector as labels. 
        
### 4. Appropriately labels the data set with descriptive variable names.

        Abbreviations in the features variable names were replaced with full words using the gsub command.
        Specifically, the following replacements were made:
        - "^t" was replaced with "Time_"
        - "^f" was replaced with "Frequency_"
        - "Acc" was replaced with "Accelerometer"
        - "Mag" was replaced with "Magnitude"
        - "Gyro" was replaced with "Gyroscope"
        - "BodyBody" was replaced with "Body"

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

        Using dplyr, the data.sub data frame was grouped by subject and activity. All other columns were summarized by mean using summarize all and saved as a new data frame, data_tidy. data_tidy was writen to the working directory as "data_tidy.txt".

