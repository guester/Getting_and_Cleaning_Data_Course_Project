Getting_and_Cleaning_Data_Course_Project
========================================
This GitHub repository contains a script written in the R programming language that is designed to generate single tidy data set from a group of Galaxy S Smarphone accelerometer data sets.

The script assumes that all neceassary files are located in the users current working directory

The first block of code reads in a file containing subject_id information and a file containing subject activity information.  The code then combines these two files into a single file using the cbind function

The 2nd block of code reads in the X_train file containing numeric values for all variables across each user/activity combination.  A file containing variable names is then read in and the variable names are extracted and used to replace the default variable names in X_train.  Finally, the dataframe generated in the first block of is appended to X_train in order to generate a dataframe named train.

The next two blocks of code repeat the first two blocks of code but do so using the test data files and result in the creation of the test dataframe. 

The 5th block of code combines the train dataframe with the test dataframe to generate the complete dataframe.

The 6th block of code renames the first two columns of complete with descriptive variable names

The 7th block of code extrcts only the desired columns of complete i.e. the first two columns and any colunm whose name contains the string "mean" or "std".  The complete dataframe is overwritten to now contain only these desired columns

The 8th block of code replaces the numeric values in the activity column with character strings describing the associated activity.

The 9th block of code replaces abbreviations and other non-descriptive character strings in the variable names of complete to be complete, descriptive variable names.

The 10th block of code generates a new dataframe named tidy_averages that contains averages of each variable grouped by user_id and activity.

The 11th block of code orders the data.table based on subject_id in ascending order.

The 12th block of code changes the variable names of tidy_averages to an appropriate descriptive name 




