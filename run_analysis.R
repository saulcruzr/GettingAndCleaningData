#Name: run_analysis.R#
#Description:
#This file will merge the training and the test sets to create one data set
#Extracts only the measurements on the mean and standard deviation for each measurement
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
#IMPORTANT NOTE: The ABOVE steps are not necessarily in order
#Author: Saul Cruz

##Loading required files
        #features=List of all features
        features<-read.table("./data/UCI HAR Dataset/features.txt")
        #activityLabels=Links the class labels with their activity name
        activityLabels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
        #Training set
        training<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
        #Training labels
        trainingLabels<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
        #Training subjects
        trainingSubjects<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
        #Test set
        test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
        #Test labels
        testLabels<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
        #Test subjects
        testSubjects<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##Assigning appropriate column names to previously loaded data frames
        colnames(features)<-c("id","feature")
        colnames(activityLabels)<-c("id","activity")
        ##Assigning descriptive names to variables (Step 4 in the instructions)
        colnames(test)[1:561]<-as.character(features$feature)
        colnames(training)[1:561]<-as.character(features$feature)

##Extracts only measurements on the mean and standard deviation for each measurement features are In (Step 2 in the instructions)
        featuresIn<-features[features$id %in% grep("*[mM]ean*|*std*",features$feature,value = FALSE),]
        featuresOut<-features[!(features$id %in% featuresIn$id),]
        testIn<-test[featuresIn$feature]
        trainingIn<-training[featuresIn$feature]
        
##Adding missing ID column to data sets
        trainingIn$id<-as.numeric(rownames(trainingIn)) ##index() can be used
        testIn$id<-as.numeric(rownames(testIn))
        trainingLabels$id<-as.numeric(rownames(trainingLabels))
        testLabels$id<-as.numeric(rownames(testLabels))
        testSubjects$id<-as.numeric(rownames(testSubjects))
        trainingSubjects$id<-as.numeric(rownames(trainingSubjects))
        colnames(testSubjects)<-c("subject","id")
        colnames(trainingSubjects)<-c("subject","id")
        
##Merge Training Data Sets with Activity Labels and Subjects
        trainingInActivity<-merge(trainingIn,trainingLabels,by.x="id",by.y="id")
        colnames(trainingInActivity)[88]<-"activityid"
        ##associate activity description (Step 3 in the instructions)
        trainingInActivity<-merge(trainingInActivity,activityLabels,by.x="activityid",by.y="id")
        trainingInActivitySubject<-merge(trainingInActivity,trainingSubjects,by.x="id",by.y = "id")
        
##Merge Test Data Sets with Activity Labels and Subjects
        testInActivity<-merge(testIn,testLabels,by.x="id",by.y = "id")
        colnames(testInActivity)[88]<-"activityid"
        ##associate activity description
        testInActivity<-merge(testInActivity,activityLabels,by.x="activityid",by.y = "id")
        testInActivitySubject<-merge(testInActivity,testSubjects,by.x="id",by.y = "id")
        
##Removing unnecessary columns
        trainingInActivitySubject$activityid<-NULL
        testInActivitySubject$activityid<-NULL

##Union/Merge of Test and Training (Step 1 in the instructions)
        fulldataset <- rbind(testInActivitySubject, trainingInActivitySubject)

##Independent tidy data set with the average of each variable for each activity AND each subject.
        library(dplyr)
        tidyData<-fulldataset %>% group_by(activity,subject) %>% summarise_each(funs(mean))
        write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
        
