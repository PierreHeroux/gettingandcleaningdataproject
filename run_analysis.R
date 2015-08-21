## Download file
## Depending on your operating system, you may need to change the value for the method parameter

print("Downloading the data. Please wait")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI_HAR_Dataset.zip",method="wget")
print("Data dowloaded")

## Let us unzip the file
print("Unzipping the data")
unzip("UCI_HAR_Dataset.zip")
print("Data unzipped");

## Change directory
print("Setting the working directory")

olddir<-getwd()
setwd("UCI HAR Dataset")

## Let us read the data
print("Readind the data. Please wait...")
testX<-read.table("test/X_test.txt")
trainX<-read.table("train/X_train.txt")
testY<-read.table("test/y_test.txt")
trainY<-read.table("train/y_train.txt")
testSubject<-read.table("test/subject_test.txt")
trainSubject<-read.table("train/subject_train.txt")

## Let us read activity names
print("Reading activity label")
activity<-read.table("activity_labels.txt")

## Let us read the feature names
print("Reading feature names")
feature<-read.table("features.txt")

## Merging test and training data for X and Y
print("Merging the data")
X<-rbind(testX,trainX)
Y<-rbind(testY,trainY)

## Selecting only the features that contain mean() or std() in their names
## These are stored in a dataframe with the index of of the feature as the 1st variable and the feature name as the 2dn variable
print("Selecting feature")
selectedFeature<-data.frame(indices=grep("(mean|std)\\(\\)",feature[,2]),names=tolower(grep("(mean|std)\\(\\)",feature[,2],value=TRUE)))

## Selecting only interesting features
selectedX<-X[,selectedFeature$indices]

## Renamining the features with descriptive names
print("Using descriptive feature names")
selectedFeature$names=gsub("\\-|\\(\\)","",selectedFeature$names)
names(selectedX)<-selectedFeature$names

## Adding descriptive names of activity
print("Adding activity to data")
Y<-merge(Y,activity)
names(Y)[[2]]<-"activity"
selectedX<-cbind(selectedX,Y$activity)
names(selectedX)[length(selectedX)]<-"activity"

## At this point, selectedX is the tidy dataset described at step 4

## Adding a column for the subject
print("Adding subject to data")
subject<-rbind(testSubject,trainSubject)
names(subject)[[1]]<-"subject"
selectedX<-cbind(selectedX,subject)

## Create a tidy data set from the previous which computes the mean of each variable for each subject and activity
print("Compute feature means for each activity and subject")
library(reshape2)
meltdata <- melt(selectedX,id=c("activity","subject"))
tidyDF <- dcast(meltdata, activity + subject ~ variable, mean)

## Saving the result
print("Saving the data to tidyDF.csv")
write.table(tidyDF,file="../tidyDF.txt",row.name=FALSE)

## Unset the working directory
print("Back to your directory")
setwd(olddir)

print("Done")
