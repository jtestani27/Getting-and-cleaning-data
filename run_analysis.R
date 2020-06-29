#Run Analysis 6/27/20
## data from Samsung Galaxy S smartphone accelerometers
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Download files and save to the workspace
        filename <- "DS3_Project.zip"

        # does the archive already exist? if n: download
        if (!file.exists(filename)) {
                fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(fileURL,filename,method="curl")
        }

        # does the unzipped file already exist? if n: unzip the download
        if (!file.exists("UCI HAR Dataset")) {
                unzip(filename)
        }
        
# read unzipped data
        # read the features table -> what each column means
        features <- read.csv("./UCI HAR Dataset/features.txt", header=FALSE, sep=' ')
        features <- as.character(features[,2]) 
        
        # read the test tables -> .activity & .subject are keys of who & what
        test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
        test.activity <- read.csv("./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep=' ')
        test.subject <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep=' ')
        
        # combine the test tables into one so we know who did what + the data
        test <- data.frame(test.subject,test.activity,test.x)
        names(test) <- c(c('subject','activity'),features)
        
        # read the train tables -> .activity & .subject are keys of who & what
        train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
        train.activity <- read.csv("./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep=' ')
        train.subject <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep=' ')
        
        # combine the train tables into one so we know who did what + the data
        train <- data.frame(train.subject,train.activity,train.x)
        names(train) <- c(c('subject','activity'),features)

# open needed libraries
        library(dplyr)
        library(reshape2)
        
# 1. Merges the training and the test sets to create one data set.
        # add the test and train datasets together
        data.all <- rbind(test,train)
        
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
        data.sub <- data.all %>% select(subject,activity,contains("mean()"),contains("std()"))
        
# 3. Uses descriptive activity names to name the activities in the data set
        # read in activity labels and set as a vector
        activities <- read.csv("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep=' ')
        activities <- as.character(activities[,2])
        data.sub$activity <- factor(data.sub$activity,labels=activities)
        
# 4. Appropriately labels the data set with descriptive variable names.
        # use gsub to replace the abbreviations with full words
        names(data.sub) <- gsub("^t","Time_",names(data.sub))
        names(data.sub) <- gsub("^f","Frequency_",names(data.sub))
        names(data.sub) <- gsub("Acc","Accelerometer",names(data.sub))
        names(data.sub) <- gsub("Mag","Magnitude",names(data.sub))
        names(data.sub) <- gsub("Gyro","Gyroscope",names(data.sub))
        names(data.sub) <- gsub("BodyBody","Body",names(data.sub))
        
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        # dplyr - group_by subect and activity
        # summarize_all --> don't need to list variable names from summarize
        data_tidy <- data.sub %>%
                group_by(subject, activity) %>%
                summarize_all(funs(mean))
        
        # write the final table, hooray!
        write.table(data_tidy, "data_tidy.txt", row.name=FALSE)
        
        
        