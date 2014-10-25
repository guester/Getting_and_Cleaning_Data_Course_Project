#This is an R script written for the Getting and Cleaning Data Course Project
#It is designed to generate a tidy data set according to the assignment instructions

#Code Block 1: Reading in subject_id and activity data and combining them into a single dataframe
subject_train <- read.table("subject_train.txt")
y_train <- read.table("y_train.txt")
x <- cbind(subject_train, y_train)

#Code Block 2: Reading in Accelerometer dataframe and changing variable names to correspond
#with feature labes in the features.txt file 
X_train <- read.table("X_train.txt")
features <- read.table("features.txt")
features <- features$V2
names(X_train) <- features
train <- cbind(x,X_train)

#Code Blocks 3 and 4: Repeat code blocks 1 and 2 for the test data files
subject_test <- read.table("subject_test.txt")
y_test <- read.table("y_test.txt")
y <- cbind(subject_test, y_test)

X_test <- read.table("X_test.txt")
features <- read.table("features.txt")
features <- features$V2
names(X_test) <- features
test <- cbind(y,X_test)

#Code Block 5: Combine test and train dataframes into a single dataframe
complete <- rbind(train, test)

#Code Block 6: Renaming columns 1 and 2 to something descriptive
names <- names(complete)
names[1:2] <- c("subject_id", "activity")
names(complete) <- names

#Code Block 7: Pulling out only the desired columns from complete dataframe
mean_std_cols <- grep("mean|std", names(complete))
complete <- complete[,c(1,2,mean_std_cols)]

#Code Block 8: Replacing numbers in activity column with a descriptive name of the activity
complete[,2] <- gsub(1, "walking", complete[,2])
complete[,2] <- gsub(2, "walking_upstairs", complete[,2])
complete[,2] <- gsub(3, "walking_downstairs", complete[,2])
complete[,2] <- gsub(4, "sitting", complete[,2])
complete[,2] <- gsub(5, "standing", complete[,2])
complete[,2] <- gsub(6, "laying", complete[,2])

#Code Block 9: Change variable names to be more descriptive
names(complete) <- gsub("^t", "time domain signal of ", names(complete))
names(complete) <- gsub("Body", " Body ", names(complete))
names(complete) <- gsub("-", " ", names(complete))
names(complete) <- gsub("Acc", "Acceleration ", names(complete))
names(complete) <- gsub("Jerk", "Jerk Signal ", names(complete))
names(complete) <- gsub("Gravity", "Gravity ", names(complete))
names(complete) <- gsub("\\(\\)", "", names(complete))
names(complete) <- gsub("^f", "fast fourier transform of", names(complete))
names(complete) <- gsub("Mag", "Magnitude ", names(complete))
names(complete) <- gsub("[Mm]ean", "Mean value ", names(complete))
names(complete) <- gsub("std", "Standard deviation", names(complete))
names(complete) <- gsub("Gyro", "Gyroscope ", names(complete))
names(complete) <- gsub("Freq", "Frequency", names(complete))
names(complete) <- gsub("  ", " ", names(complete))
names(complete) <- gsub("Body Body", "Body", names(complete))

#Code Block 10: Generate a data.table with a column for the average of each variable grouped by subject and activity
library("data.table")
complete <- data.table(complete)
tidy_averages <- complete[,lapply(.SD, mean), by=c("subject_id", "activity"), .SDcols=3:81]

#Code Block 11: Order the rows of the data.table by subject_id in ascending order
tidy_averages <- tidy_averages[order(subject_id), ]

#Code Block 12: Convert the data.table to a dataframe and change variable names to proper description by adding
#"mean of" to the start of each variable name
tidy_averages <- as.data.frame(tidy_averages)
names(tidy_averages)[3:81] <- sub("^", "mean of ", names(tidy_averages)[3:81])
