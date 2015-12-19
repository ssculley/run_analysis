##Following section is for setting the working directory and read in the data sets

setwd("c:/Users/ssculley/Desktop/data")

xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")
subtest <- read.table("./test/subject_test.txt")

xtraining <- read.table("./train/X_train.txt")
ytraining <- read.table("./train/y_train.txt")
subtraining <- read.table("./train/subject_train.txt")

##Following section is for merging data

xboth <- rbind(xtraining, xtest)

yboth <- rbind(ytraining, ytest)

subjectboth <- rbind(subtraining, subtest)



##Following section is for pulling only mean and std data

features <- read.table("./features.txt")
target <- grep("-mean\\(\\)|-std\\(\\)", features[,2])	
xtarget <- xboth[,target]

names(xtarget) <- features[target, 2]



##Following section is for putting names on activity and subject
## then combine all data 

activity <- read.table("./activity_labels.txt")
names(activity) <- c("activity_id", "activity_name")
yboth[, 1] = activity[yboth[, 1], 2]

names(yboth) <- "Activity"
names(subjectboth) <- "Subject"

completeTidyData <- cbind(subjectboth,yboth, xtarget)


##Following section is for creating a tidy data set and write the results to a txt file

measurementonly <- completeTidyData[,3:68] 
AVGTidyData <- aggregate(measurementonly,list(completeTidyData$Subject, completeTidyData$Activity), mean)

names(AVGTidyData)[1] <- "Subject"
names(AVGTidyData)[2] <- "Activity"


write.csv(AVGTidyData, file = "AVGTidyData.txt",row.names=FALSE)
