# GetCleanDataProject
Course Project for Getting and Cleaning Data

ReadMe.md

This markdown document is the ReadMe file for my Getting and Cleaning Data Course Project.

The other files are the run_analysis.R script, the codebook in CodeBook.md and the tidy data set MyTidyDataSet.txt.

In this ReadMe file I give an explanation of each of these files,  and specifically how they meet the criteria for the course project.

run_analysis.R

The course project brief provided a data set of smartphone accelerometer measurements for different individuals, called subjects, doing various activities. This complete data set consists of various files that had to be combined, certain variables extracted, means performed and finally to produce a tidy data set.

In the data set the data files are grouped into “training” and in a “test” sets.  After reading these files into data frames it was clear that the subject_test.txt and subject_train.txt files contained subject identifiers of the individuals participating in the study. The y_test.txt and y_train.txt files contained numerical identifiers of the activities.  

The measurement variables, already processed as explained by the authors of the original study, were in the files X_test.txt and X_train.txt.

The following numbering follows the steps in the brief o the assignment:

1.  Merge the training and test sets to create one data set.

Upon inspection of the sizes of the data frames, it became apparent that the  X_test.txt and X_train.txt, the files with the measurements, had the same number of columns, and that this number was the same as that of the length of the data frame obtained from the features.txt file.
The measurements data frames were therfore combined with a row bind.
The column headings, the names of the measurement variables, were then renamed using the features data frame.

The subjects data frames and the activity codes data frames were row bound in a similar manner and then column bound with the combined measurements data frame.  This produced one big combined data set in a single data frame, the first column being the subject identifier, then the activity code, followed by 561 columns of measurements. 


2. Extracts only the measurements of the mean and standard deviation for each measurement.

I used select to extract all the columns containing “mean” and another one to extract all columns containing “std”, both case insensitive.


3. Uses descriptive activity names to name the activities in the data set.

The activity_labels.txt file provided descriptive labels for the numerical activity codes, namely

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

I introduced a column for activity labels, converting the activity codes, originally from the y-test and y_train data sets, to the descriptive codes above.


4.  Appropriately labels the data set with descriptive variable names.

The columns with measurements have already been descriptively named in step 1, using the names of the variables from from the features file. For this step only the subject and activity columns needed to be descriptively named.


5.  Create a second independent data set with the average of each variable for each activity for each subject.

By combining the subject identifier column and the activity label column, I created a column of factors called sub_x_activity, for “Subject by Activity”.  This factor variable was now used to obtain the means of all the measurement variables. The column headings were renamed by preficxing “s_x_a mean “, also for “subject by activity”, to each of the measurement column names. 

After taking the means, the factor variable was parsed to separate the subject identifier and the activity label.  At this point I also dropped the activity code, as it and the activity label gave the same information. 

Following some final cleaning up, I had a presentable data frame of a tidy data set in wide format.  This wide format seemed the most natural as it retained a similar appearance to that of the combined data set.

My data set meets the requirements of a tidy data set, specifically the column headings have descriptive names, each column is a different variable, and there are no duplicate columns, which was the reason for removing the activity code.

The tidy data set was written to the file MyTidyDataSet.txt using write.table(0 with the row.name = FALSE option.
The text file is uploaded to Coursera.

Following the explanation in the David’s personal course project FAQ, 
the tidy data set can be read and viewed using 
data <- read.table(file_path, header = TRUE)
folowed by View(data)

I specifically used 

write.table(MyTidyDataSet, file ="./data/MyTidyDataSet.txt", row.name = FALSE)
checkMyTidyDataSet <- read.table("./data/MyTidyDataSet.txt", header = TRUE)
View(checkMyTidyDataSet)


