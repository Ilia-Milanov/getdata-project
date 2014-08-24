getdata-project
===============

Coursera | Geting and Cleaning Data - Course Project

================================================================================
The project includes the following files:

- "README.md" - current file

- "run_analysis.R" - The R script wich is uesd for creation of "tidyData.txt" dataset

- "tidyData.txt" - Dataset with the average of each variable for each activity 
and each subject.

- "codebook.txt" - Codebook of variables in tidyData dataset.

================================================================================

The raw data is downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Then is unziped in the script directory.
The script "run_analysis.R" merges the traing and test datasets. Then subset 
only the measurements on the mean and standard deviation for each measurement. 
Then it change the value of activities variables with descriptive activity names.
Next it removing the special characters from variable names from features.txt 
and label with them the measurments in the dataset.
After this the "reshape2" library is loaded for melting the dataset. Seting the 
"subject" and "activity" as id vars. The rest are measure vars. Then the script 
cast new dataframe "tidyData" with the average of each variable for each subject 
and each activity. At the end the script write the tidy dataset into text file - 
"tidyData.txt".