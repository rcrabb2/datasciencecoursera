run_analysis <- function(){
  library(dplyr)
  library(tidyr)
  
  ##I like to put all of the R code/files into the R folder for easy use
  if(!dir.exists("./R"))
    dir.create("R")
  setwd("~/R")
  
  ##I put the zip download into the ./R/data directory. Checking the directory seemed
  ##like the easiest way to verify it was there to prevent constant download.
  if(!dir.exists("./data")){
    temp <- tempfile()
    print("Data directory doesn't exist. Creating it now.")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
    unzip(temp,exdir="./data")
  }
  
  #This call the function to get the features list from the features txt
  features <- parseFeaturesFile()
  
  #This grabs the 2 data set files
  testData <- gettingFile("test",features)
  trainData <- gettingFile("train",features)
  
  #This combines the 2 tables and renames the first column
  allData <- rbind(testData,trainData)
  names(allData)[1] <- 'Subject'
  
  ##This calculates the mean for each subject-activity pairing
  allData <- allData %>%
    group_by(Subject,Activity) %>%
    summarise_all(list(mean))
  
  ##This writes the result as a file
  write.table(allData,"./data/question5result",row.names=FALSE)
}
##This, as the name implies, parses the Features File to make it usable
parseFeaturesFile <- function(){
  fileRead <- read.delim("./data/UCI HAR DATASET/features.txt", header = FALSE, sep = " ")
  
  #To use this with the dataframes as the names field, I made a list
  features_list <- as.list(as.data.frame(t(fileRead[2])))
}

##As the files all have the same naming convention, I made this code to simplify
##the main function
gettingFile <- function(folder,features){
  #This makes data frames of all of the files in their respective folders
  x <- read.table(paste("./data/UCI HAR Dataset/",folder,"/X_",folder,".txt",sep=""))
  y <- read.table(paste("./data/UCI HAR Dataset/",folder,"/y_",folder,".txt",sep=""))
  subject <- read.table(paste("./data/UCI HAR Dataset/",folder,"/subject_",folder,".txt",sep=""))
  
  #Since the acivities have a more descriptive information, I renamed the columns here.
  ##It's ugly, but works really well and correctly
  colnames(y) <- "Activity"
  
  y$Activity[y$Activity == 1] <- "Walking"
  y$Activity[y$Activity == 2] <- "Walking upstairs"
  y$Activity[y$Activity == 3] <- "Walking downstairs"
  y$Activity[y$Activity == 4] <- "Sitting"
  y$Activity[y$Activity == 5] <- "Standing"
  y$Activity[y$Activity == 6] <- "Laying"
  
  #As the x files have the same dimensions as the features file, I renamed the
  #columns to make them more human-readable
  x <- setNames(x,features)
  
  #As I only require the std and mean columns,I extract them from x
  std <- grepl('\\std()\\b',colnames(x))
  mean <- grepl('\\mean()\\b',colnames(x))
  
  x <- cbind(x[std],x[mean])
  
  #This merged the data together so that only 1 dataframe is returned
  combinedData <- cbind(y,x)
  combinedData <- cbind(subject,combinedData)
}
