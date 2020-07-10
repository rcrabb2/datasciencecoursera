## Getting and Cleaning Data README
This R script utilizes the UCI HAR Dataset for the Getting and Cleaning Data course project from Coursera. This script doesn't need user-input.

## run_analysis
this is the main function that 
1.	Initializes the tidyr and dplyr libraries, both which are used throughout the script
2.	Creates the /data/ directory with the zip file that contains the UCI HAR Dataset, if not already there
3.	Calls the parseFeaturesFile function
4.	Creates the test and train datasets using the gettingData function
5.	Combines the 2 datasets together to create the master dataset which is returned

## parseFeaturesFile
takes the features.txt file, cleans it up, and makes a list from it. 
 
## gettingData
takes the parseFeaturesFile output (a list) as well as a the folder that I’m interested in for the call
1.	Makes data frames based on the input (X_folder.txt, y_folder.txt, and subject_folder.txt) 
2.	The y files are the activities. The code takes the y data frame and renames them values to match the activites_lable.txt file.
3.	The X file is the 561 columns of results of the analysis. In this part, the script sets the names of X equal to the parseFeaturesFile output.
4.	Extracts the std() and mean() values from the x data frame into separate data frames
5.	Combines the std and mean data frames to become x data frame again
6.	Combines x, y, and subject data frames together into 1 complete data frame which is returned

## forQuestion5
takes the result of cleaningData and calculates the mean of each variable based on subject and activity. The result is a text file of the data frame.

## License
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## All of the information regarding the UCI HAR Dataset can be found in its README.txt
