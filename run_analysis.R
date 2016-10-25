##Extracting the training data
#set the working directory for the train folder
subtrain_raw <- read.table("subject_train.txt")
acttrain_raw <- read.table("y_train.txt")
xdatatrain_raw <- read.table("X_train.txt")

##Extracting the testing datasubtest_raw <- read.table("subject_test.txt")
# set the working directory for the testfolder
acttest_raw <- read.table("y_test.txt")
xdatatest_raw <- read.table("X_test.txt")
xdatatrain <-data.table(xdatatrain_raw)
xdatatest <- data.table(xdatatest_raw)

##Merging the different columns
mergesub <- rbind(subtrain_raw,subtest_raw)
setnames(mergesub,"V1","subject")
mergeact <- rbind(acttrain_raw,acttest_raw)
setnames(mergeact,"V1","activity_num")
datamerge <- rbind(mergesub,mergeact)
xdatamerge <- rbind(xdatatrain,xdatatest)
datasub <- cbind(mergesub,mergeact)
alldata <- cbind(datasub,xdatamerge)
setkey(alldata, subject, activity_num)
library(dplyr)
arrange(alldata, "subject", "activity_num")
arrange(alldata, subject, activity_num)
alldata <- arrange(alldata, subject, activity_num)

##Extracting features' names
#Set the working directory for the UCI HAR Dataset folder.
dtFeatures <- fread("features.txt")
setnames(dtFeatures, names(dtFeatures), c("featureNum", "featureName"))
dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]
dtFeatures$featureCode <- dtFeatures[, paste0("V", featureNum)] ##Creating a new set of variables Vnumber

#Extracting activity names
activitynames <- read.table("activity_labels.txt")
setnames(activitynames, names(activitynames), c("activity_num", "activity_name"))
data_merged <- merge(data,activitynames,by= "activity_num",all.x = TRUE)
data_merged <- arrange(data_merged,subject, activity_num, activity_name)

data_merged <- data.table(melt(data_merged, key(data_merged), variable.name="featureCode"))


###Up to this point I am having problems. Please consider this for partial credit
