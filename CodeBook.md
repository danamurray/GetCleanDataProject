
CodeBook.md

This code book, accompanying my Gettinging and Cleaning Data Course Project, builds upon the original authors’ explanation of their variables in their code book, their file features_info.txt.

Another explanation of their variables would have been overdoing it. I therefore use a some brief extracts from their code book to explain how I have used their variables and to describe the variables I introduced for my combined data set of Step 4 and the final tidy data set.

The original authors used variables like 

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The suffix XYZ denotes that there are signals in the X, Y and Z directions, with separate suffixes ‘X’, ‘Y’, and ‘Z’  respectively.
The prefixes ’t’ and ‘f’ denote time and frequency domain signals.

Many quantities have been estimated from these signals, such as ‘mean()’, ‘std()’ , ‘max()’, ‘min()’ and a host of others. These labels were then suffixed to the variables names as explained above. The data sets contained meansurement for 561 variables for 30 subjects performing the 6 activities WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.

For the course project the data sets first had to be combined.

My  combined data set SubActMeasurements, for Subject, Activity and measurements, a data frame of 10299 by 89 data frame, contains the variables

"subjectID"        subject identifier, an integer variable from 1 to 30
”act_code"        activity code, an integer from 1 to 6
”activity"            activity label, a factor with 6 levels for the 6 activities

This data frame contains 86 measurement variables like 

 "tBodyAcc-mean()-X"    
 "tBodyAcc-mean()-Y" 

which contain “mean” or “std”, both case insensitive.

My tidy data set MyTidyDataSet contains these 86 variables as well as

"subject"      subject identifier, an integer variable from 1 to 30                   
"activity"      activity label, a factor with 6 levels for the 6 activities ,    

They are followed by the means of the 86 measurement variables, but with the description "s_x_a mean”, for “subject by activity mean” prefixed  to each variable name, with the first two being 

"s_x_a mean  tBodyAcc-mean()-X"    
"s_x_a mean  tBodyAcc-mean()-Y" ,

and similarly for the other measurement variables.

This yielded MyTidyDataSet, a data frame of 180 rows by 88 columns. 
