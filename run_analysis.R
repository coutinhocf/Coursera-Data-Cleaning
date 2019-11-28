## Import libraries
require(dplyr)
require(tidyr)

## Import Datasests
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")

# Searchs for the features that are mean or standard deviation
features_v = grep("(mean\\W|std)",features[,2]) 

# Keep only the searched features for X_train and gives the appropriately name to the variables                 
X_train = X_train[,features_v]
colnames(X_train)=features[features_v,2]

# Keep only the searched features for X_test and gives the appropriately name to the variables                 
X_test = X_test[,features_v]
colnames(X_test)=features[features_v,2]

#Creates the Train dataset by adding the subject id and the id of the activity the subject made 
Train = bind_cols(subject_train,X_train,y_train)
colnames(Train)[1] = "subject"
colnames(Train)[ncol(Train)] = "activity"
#Creates the Test dataset by adding the subject id and the id of the activity the subject made 
Test = bind_cols(subject_test,X_test,y_test)
colnames(Test)[1] = "subject"
colnames(Test)[ncol(Test)] = "activity"

# Merges the Train dataset to activity_labels by the activity id
Train = merge(Train,activity_labels,by.x = "activity",by.y = "V1")

# Removes the column that has the activity id´s and assing the "activity" 
# name to the variable that was previously searched
Train = Train[,-which(is.element(colnames(Train),c("activity")))]
colnames(Train)[which(is.element(colnames(Train),c("V2")))] = "activity"

# Merges the Test dataset to activity_labels by the activity id
Test = merge(Test,activity_labels,by.x = "activity",by.y = "V1")

# Removes the column that has the activity id´s and assing the "activity" 
# name to the variable that was previously searched
Test = Test[,-which(is.element(colnames(Test),c("activity")))]
colnames(Test)[which(is.element(colnames(Test),c("V2")))] = "activity"

# Binds the Train and Test datasets into the final "dataset
dataset = bind_rows(Train,Test)

dataset2 = gather(dataset,type_of_measurements,value,
                  `tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`)

dataset2 = separate(dataset2,type_of_measurements,into = c("measure","type_of_measure","dimension"),
                    sep = "-",fill = "right")

dataset3 = dataset2 %>% group_by(subject,activity,measure,type_of_measure,dimension) %>%
              summarise(value = mean(value))

write.table(dataset3,"FinalTidySummary.txt", row.name=FALSE) 
