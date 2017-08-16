features     = read.table('UCI HAR Dataset/features.txt',header=FALSE);
features.names <- features[,2];

##Appropriately labels the data set with descriptive variable names.
features.names = gsub('-mean', 'Mean', features.names);
features.names = gsub('-std', 'Std', features.names);
features.names = gsub('[-()]', '', features.names);
features.names = gsub("^t", "time", features.names)
features.names = gsub("^f", "frequency", features.names)
features.names = gsub("Acc", "Accelerometer", features.names)
features.names = gsub("Gyro", "Gyroscope", features.names)
features.names = gsub("Mag", "Magnitude", features.names)
features.names = gsub("BodyBody", "Body", features.names)

activityType = read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE); 
colnames(activityType)  = c('activityId','activityType');

traindata <- read.table("UCI HAR Dataset/train/X_train.txt");
trainact <- read.table("UCI HAR Dataset/train/y_train.txt");
trainsub <- read.table("UCI HAR Dataset/train/subject_train.txt");
train <- cbind(trainsub,trainact,traindata);

testdata <- read.table("UCI HAR Dataset/test/X_test.txt");
testact <- read.table("UCI HAR Dataset/test/y_test.txt");
testsub <- read.table("UCI HAR Dataset/test/subject_test.txt");
test <- cbind(testsub,testact,testdata);

##Merges the training and the test sets to create one data set
allData = rbind(train,test);
colnames(allData) <- c("subject", "activityId", features.names)

colNames  = colnames(allData); 

colWanted <- grepl("subject|activityId|.*Mean.*|.*Std.*", colNames)

##Extracts only the measurements on the mean and standard deviation for each measurement
finalData = allData[colWanted==TRUE];

##Uses descriptive activity names to name the activities in the data set
mergeData = merge(finalData,activityType,by='activityId',all.x=TRUE);

colNames  = colnames(mergeData); 

##From the data set above, 2nd independent tidy data set with the average of each variable, by activity & subject
newData<-aggregate(. ~subject + activityType, mergeData, mean)
newData<-newData[order(newData$subject,newData$activityType),]
write.table(newData, file = "tidydata.txt",row.name=FALSE,quote = FALSE, sep = '\t')