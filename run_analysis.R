# First the script load 561-feature vectors from test and train sets and merged 
# them into mergedX
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
mergedX <- rbind(Xtest, Xtrain)

# Then load the names and position of feature vector variables
features <- read.table("./UCI HAR Dataset/features.txt")

# Subseting only the measurements on the mean and standard deviation
submean <- grep("mean()", features[, 2])
substd <- grep("std()", features[ ,2])
extract <- sort(c(submean,substd))

# Extracting the measurments
extractedset <- mergedX[, extract]

# Reading the subjects id and adding it to the dataset
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjects <- rbind(subjecttest, subjecttrain)
extractedset$subject <- unlist(subjects)

# Reading the activities id and adding it to the dataset
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
activities <- rbind(ytest, ytrain)

# Reading activities labels and used them for descriptives values
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
act <- as.factor(sapply(activities,function (x){ activitylabels[x,2]}))
extractedset$activity <- act

# Removing the special characters from variable names from features.txt and 
# label with them the measurments in the dataset
varnames <- as.character(features[sort(c(submean,substd)),2])
varnames <- gsub("\\()", "", varnames)
varnames <- gsub("-", "_", varnames)
names(extractedset) <- c(varnames, "subject", "activity")


library(reshape2)

# Seting the "subject" and "activity" as id vars. The rest are measure vars.
meltedset <- melt(extractedset, id = c("subject", "activity"))

# Then cast new dataframe "tidyData" with the average of each variable for each 
# subject and each activity
tidyData <- dcast(meltedset, subject + activity ~ variable, mean)

#Finaly the script write "tidyData" dataframe into "tidyData.txt" text file.
write.table(tidyData, "tidyData.txt", row.name=FALSE)
