############################  function definitions ########################
initial_setup <- function() {
    #set the working folder to the unzip folder with the original files
    setwd("~")
    setwd("./class/data-cleaning/project/UCI HAR Dataset")
    
    #load libraries
    library(dplyr)
    library(tidyr)
}

#1 Merges the training and the test sets to create one data set.
merge_data <- function() {
    xtrain<-read.table("./train/X_train.txt", colClasses = "numeric")
    xtest<-read.table("./test/X_test.txt", colClasses = "numeric")
    alldata<-bind_rows(xtrain, xtest)
}

#2 Extracts only the measurements on the mean and standard deviation for each measurement.
filter_columns <- function(alldata) {
    features<-read.table("./features.txt")
    index<-grep('mean|std',features$V2)
    alldata<-alldata[,index]
}

#3 Uses descriptive activity names to name the activities in the data set
name_columns <- function(alldata) {
    ytrain<-read.table("./train/y_train.txt")
    ytest<-read.table("./test/y_test.txt")
    act_labels<-read.table("./activity_labels.txt")
    
    act_list<- bind_rows(ytrain, ytest)
    colnames(act_list) = c("activity")
    alldata<-bind_cols(act_list, alldata)  
    
    for (i in seq_len(nrow(act_labels))) {
        alldata[alldata$activity==i,1]<- tolower(as.character(act_labels[i,2]))
    }
    return (alldata)
}

#4 Appropriately labels the data set with descriptive variable names.
rename_columns <- function(alldata) {
    features<-read.table("./features.txt")
    index<-grep('mean|std',features$V2)
    headers<-as.character(features[index,2])
    headers<-append(headers, "activity", 0)
    
    headers<-tolower(headers)
    headers<-sub("\\(\\)", "", headers)
    headers<-sub("mean-x", 'meanx', headers)
    headers<-sub("mean-y", 'meany', headers)
    headers<-sub("mean-z", 'meanz', headers)
    headers<-sub("std-x", 'standarddevx', headers)
    headers<-sub("std-y", 'standarddevy', headers)
    headers<-sub("std-z", 'standarddevz', headers)
    headers<-sub('acc', 'acceleration', headers)
    headers<-sub('fbody', 'frequencybody',headers)
    headers<-sub('tbody', 'timebody',headers)
    headers<-sub('tgravity', 'timegravity',headers)
    headers<-sub('bodybody', 'body', headers)
    headers<-sub('gyro', 'gyroscope', headers)
    headers<-sub('mag', 'magnitude', headers)
    headers<-gsub("-","",headers)
    headers<-sub('magnitudestd', 'magnitudestandarddev',headers)
    
    colnames(alldata) <-headers
    return(alldata)
}

#5From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
summary_data <- function(alldata) {
    subjecttrain<-read.table("./train/subject_train.txt")
    subjecttest<-read.table("./test/subject_test.txt")
    
    subjectid<-bind_rows(subjecttrain, subjecttest)
    colnames(subjectid) <- c("subjectid")
    
    alldata <- bind_cols(subjectid, alldata)
    alldata <- gather(alldata, variable, value, -subjectid, -activity)
    alldata <- group_by(alldata, subjectid, activity, variable )
    alldata <- summarize(alldata, value=mean(value))
    alldata <- spread(alldata,variable, value)
    return(alldata)
}

############################  run project ########################
initial_setup()
alldata <- merge_data()
alldata <- filter_columns(alldata)
alldata <- name_columns(alldata)
alldata <- rename_columns(alldata)
final_result <- summary_data(alldata)
write.csv (final_result, "result.csv", row.names = FALSE)
write.table(final_result, 'result.txt', row.names = FALSE)

# instructions on how to read the result.
#read_result <- read.table("result.txt", header = TRUE)
#View(read_result)
