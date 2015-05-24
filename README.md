The details of the variables can be found in "codeBook.txt"

The script 'run_analysis.R' works according the following outline:
1) Create the complete training set by reading in 'subject_train', 'X_train', 'y_train' from the 'train' folder.
2) Merge subjects and activities.
3) Select the feature columns which have mean or std in their description names.
4) Merge these columns with step 2 to finish training set.
5) Repeat step 1-4 for test set
6) Add descriptive labels for activities.
7) Merge the 2 to create the complete merged data set- MergedTrainTestFinal.csv
8) Split the data according to subject and activity.
9) Calculate the means of all the variables and store the output- TidyDataSet.txt/ TidyDataSet.csv