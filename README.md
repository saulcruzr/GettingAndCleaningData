This projec contains the following files:
-README file (you're reading it)
-CodeBook.md
-run_analysis.R

------------
Objective
------------
The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

------
Steps followed (details in run_analysis.R)
------
1.-Loaded the required data using read.table()

2.-Assigned the appropriate column names to the already loaded data (using data frames)

3.-Extracted only measurements on the mean and standard deviation for each measurement features are In (Step 2 in the instructions), this by using grep and regular expressions.

4.-Added missing ID column to data sets in order to join tables

5.-Merged Training Data Sets with Activity Labels and Subjects

6.-Merged Test Data Sets with Activity Labels and Subjects

7.-Removed unnecessary columns

8.-Merged(Unioned) Test and Training clean data (without the unnecessary features)

9.-Created and stored an Independent tidy data set with the average of each variable for each activity AND each subject. (File Name=Tidy.TXT)
