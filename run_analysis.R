# run_analysis.R

setwd("~/Documents/R_kursusse/Getting_and_Cleaning_Data/Course project")

# if(!file.exists("./data")){dir.create("./data")}
# projectDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
# dateDownloaded <- date()

# read the requisite datafiles for the project 
subject_test_data = read.table("./data/UCI HAR Dataset/test/subject_test.txt")
X_test_data       = read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test_data       = read.table("./data/UCI HAR Dataset/test/y_test.txt")

subject_train_data = read.table("./data/UCI HAR Dataset/train/subject_train.txt")
X_train_data       = read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train_data       = read.table("./data/UCI HAR Dataset/train/y_train.txt")

features_data      = read.table("./data/UCI HAR Dataset/features.txt")
activity_labels    = read.table("./data/UCI HAR Dataset/activity_labels.txt")


# step 1
# use row bind to concatenate train and test data
# change column names to those in the features list, read previously
X_all_data <- rbind(X_train_data, X_test_data)
names(X_all_data) <- features_data[,2]

# also row bind subject data, giving descriptive column name
subject_all_data <- rbind(subject_train_data, subject_test_data)
names(subject_all_data) <- "subjectID"

# and then row bind activity codes, giving descriptive column name
y_all_data <- rbind(y_train_data, y_test_data)
names(y_all_data) <- "act_code"

# as the final data merging step, column bind subjectID, activity code and Xdata
# use column bind to merge the training data and then the test data
subject_yX_all <- cbind(subject_all_data, y_all_data, X_all_data)

# can now remove the variable into which the datafiles have been read
rm(subject_test_data, X_test_data, y_test_data)
rm(subject_train_data, X_train_data, y_train_data)
rm(subject_all_data, y_all_data, X_all_data, features_data)

# step 2
# extract only the measurements on the mean and standard deviation
meancols <- select(subject_yX_all[,1:563], contains("mean", ignore.case=TRUE))
stdcols  <- select(subject_yX_all[,1:563], contains("std",  ignore.case=TRUE))
SubActM  <- cbind (subject_yX_all[,1:2],   meancols, stdcols)


# step 3
# include a column with activity labels, retain activity codes
SubActMeasurements <- cbind(SubActM[,1], activity_labels[SubActM[,2],], SubActM[,3:dim(SubActM)[2]])
# some more cleaning up
rm(activity_labels, subject_yX_all, meancols, stdcols, SubActM)

# step 4
# descriptive variable names have already been imported from features_data
# clean up column headings and row.names
names(SubActMeasurements)[1:3] <- c("subjectID", "act_code", "activity") 
row.names(SubActMeasurements) <- NULL

# step 5
# Now create second independent data set, the final tidy data set
util <- SubActMeasurements
sub_x_activity <- as.factor(paste(util[,1], util[,3], sep = '&'))
wtil <- ddply(util, "sub_x_activity", function(x){ 
    y <- subset(x, select =  -(1:3) ); apply(y, 2, mean) 
})

colnames(wtil)[2:length(wtil)] <- paste("s_x_a mean ", names(wtil[2:length(wtil)]))

# parse sub_x_activity to get back columns for subject and for activity
x   <- strsplit(as.character(wtil$sub_x_activity), '&')
mat <- matrix(unlist(x), ncol=2, byrow=TRUE)
df  <- as.data.frame(mat)
nf  <- cbind(df, wtil)
colnames(nf)[1:2] <- c("subject", "activity")

# this is just to make the table look nice,
#   with subjects in numerical and activities in alphabetical order
nearly_presentable <- nf[order(as.numeric(as.character(nf$subject)), nf$activity), ]
row.names(nearly_presentable) <- NULL

# also drop the sub_x_activity column as it has served its purpose
MyTidyDataSet <- select(nearly_presentable, -sub_x_activity)

# final clean-up to leave only SubActMeasurements of step 4, and
# presentable_means as result of step 5
rm(util, sub_x_activity, wtil, x, mat, df, nf, nearly_presentable)

write.table(MyTidyDataSet, file ="./data/MyTidyDataSet.txt", row.name = FALSE)
checkMyTidyDataSet <- read.table("./data/MyTidyDataSet.txt", header = TRUE)
View(checkMyTidyDataSet)

#rm(checkMyTidyDataSet)



