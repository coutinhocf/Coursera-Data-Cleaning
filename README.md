# Coursera-Data-Cleaning
The files for the test and training datasets raw data, activity labels and test subjects are imported into the following r objects

X_train
y_train
subject_train
features
X_test
y_test
subject_test
activity_labels
Then the features id of mean and standard deviation where selecten into a vector "features_v".

Having it the previos data frames of "X_train" and "X_test" where delimited to te features_v and the corresponding name of the feature where set as column.

After the "Train" dataset was created by adding the subject id and the id of the activity the subject made to de X_train data frame, also te "Test" dataset was created using the same.

Having the "Train" and "Test" datasets the name of the activity was found on activity_lables dataframe and the extra variable was descarted.

Once the Train and Test dataset was made they were binded into the "dataset" dataframe.

In order to make a tidy dataset there was the need to gather the dataset into the new dataset2 having the fields "measute", "type_of_measute" and "dimension" (where nedeed).

To get the final summarized dataframe "dataset3" the dataset2 was grouped by subject,activity,measure,type_of_measure and dimension while the value was set to the mean of values.
