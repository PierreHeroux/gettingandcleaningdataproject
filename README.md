## README file describing how run_analysis.R works ##

The script run_analysis contains some comment that should help to understand how it works.

Here are the main steps.

1. The script first downloads the Samsung data to a local directory. 
2. The file is unzipped
3. The working directory is set to the data directory
4. All data are read (X_test, X_training, y_test, y_training, subject_test, subject_training, activity, features)
5. test and training data are merged for X and y
6. selectedX is build as a copy of X but only features whose name contain mean() or std() are selected
7. y is associated descriptive activity name
8. descriptive feature names are given to variable in selectedX. These are from feature.txt. They are in lowercase and parentheses and hyphens are removed.
9. activity names are appended to each observation in selectedX
10. the subject id is appended to each observation in selectedX
11. a new data frame is create which contains the mean of each variable of selectedX for each subject and activity
12. this new data frame is saved to a file named tidyDF.txt
13. the working directory is finally set to its original value