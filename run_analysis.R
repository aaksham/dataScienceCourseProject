library(plyr)
setwd("C:/Users/LBS-Finance/Documents/CourseProject/UCI HAR Dataset")

##Create the complete training set
train_subjects<-read.table("./train/subject_train.txt")
str(train_subjects)
train_subjects<-rename(train_subjects, c("V1"="Subject"))
train_activities<-read.table("./train/y_train.txt")
train_activities<-rename(train_activities, c("V1"="Activity"))
str(train_activities)
train_features<-read.table("./train/x_train.txt")
dim(train_features)
names(train_features)[1:5]

#Read in the feature names to properly name the variables
feature_names<-read.table("features.txt",stringsAsFactors=FALSE)

#Find the columns containing mean and stds of the variables
target_cols=as.numeric()
for (i in seq_len(nrow(feature_names))){
        if (grepl("mean",feature_names[i,2])){
                target_cols<-rbind(target_cols,i)
        }
        else if (grepl("std",feature_names[i,2])){
                target_cols<-rbind(target_cols,i)
        } 
}
length(target_cols)
train_set<-cbind(train_subjects,train_activities)
dim(train_set)

#Rename variables with descriptive variable names
for (i in target_cols){
        print (feature_names[i,2])
        train_set<-cbind(train_set,train_features[,i])
        train_set<-rename(train_set,c("train_features[, i]"=feature_names[i,2]))
}
dim(train_set)

##Create the complete test set
test_subjects<-read.table("./test/subject_test.txt")
str(test_subjects)
test_subjects<-rename(test_subjects, c("V1"="Subject"))
test_activities<-read.table("./test/y_test.txt")
test_activities<-rename(test_activities, c("V1"="Activity"))
str(test_activities)
test_features<-read.table("./test/x_test.txt")
dim(test_features)
names(test_features)[1:5]
test_set<-cbind(test_subjects,test_activities)
dim(test_set)
#Rename variables with descriptive variable names
for (i in target_cols){
        print (feature_names[i,2])
        test_set<-cbind(test_set,test_features[,i])
        test_set<-rename(test_set,c("test_features[, i]"=feature_names[i,2]))
}
dim(test_set)
dim(train_set)
merged<-rbind(train_set,test_set)
dim(merged)
str(merged)

#Add the descriptive label of each activity
activity_labels<-read.table("activity_labels.txt",stringsAsFactors=FALSE)
activity_descr<-as.character()
for (i in merged$Activity){
        activity_descr<-rbind(activity_descr,activity_labels[i,2])
}
merged_final<-data.frame(merged,activity_descr,stringsAsFactors=FALSE)
colnames(merged_final)<-c(names(merged),"ActivityLabelDescription")
#Record merged data set
write.csv(merged_final,"MergedTrainTestFinal.csv")
#Create the tidy data set with the required aggregates
merged_ag<-merged_final
merged_ag$ActivityLabelDescription<-NULL
s<-split(merged_ag,list(merged_ag$Subject,merged_ag$Activity))
ag<-sapply(s,function(x) colMeans(x))
write.csv(ag,"AG.csv")
agt<-base::t(ag)
write.csv(agt,"TidyDataSet.csv")
write.table(agt,"TidyDataSet.txt",row.name=FALSE)