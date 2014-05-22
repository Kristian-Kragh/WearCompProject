Getting and Cleaning Data. Course Project. run_analysis.R
========================================================

### Download a zip-file from the web: 
#### https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
### Date Downloaded: 2014-05-12 13:31 CEST

setwd("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project")

### Read raw data

raw.names <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/features.txt",header = FALSE)

raw.activty.labels <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/activity_labels.txt",header = FALSE)

#### Read Train-data

raw.train.x <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/train/X_train.txt",header = FALSE)
raw.train.y <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/train/y_train.txt",header = FALSE)
raw.train.subject <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/train/subject_train.txt",header = FALSE)

#### Read Test-data

raw.test.x <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/test/X_test.txt",header = FALSE)

raw.test.y <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/test/y_test.txt",header = FALSE)
raw.test.subject <- read.table("C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/test/subject_test.txt",header = FALSE)

### Explore the data
head(raw.train.x,2)
head(raw.test.x,2)

head(raw.names)
raw.activty.labels

nrow(raw.train.x)
nrow(raw.train.y)
nrow(raw.train.subject)
nrow(raw.test.x)
nrow(raw.test.y)
nrow(raw.test.subject)
table(raw.train.y)
hist(unlist(raw.train.y))
table(raw.test.y)
hist(unlist(raw.test.y))
table(raw.train.subject)
hist(unlist(raw.train.subject))
table(raw.test.subject)
hist(unlist(raw.test.subject))

### Merge the data

##### Make Column names (a little) more tidy.
modnames.tmp1 <- sub("()","",(raw.names[,2]),fixed=TRUE)
modnames.tmp2 <- sub("^t","Time",(modnames.tmp1))
modnames <- sub("^f","Freq",(modnames.tmp2))
##### Look-up activity-label
raw.train.y.activ <- merge(raw.train.y,raw.activty.labels,by=1,sort=FALSE)
raw.test.y.activ <- merge(raw.test.y,raw.activty.labels,by=1,sort=FALSE)
##### Column bind activity-labels and subject
cnames <- c(modnames,"activity","subject")
raw.train <- cbind(raw.train.x,raw.train.y.activ[ ,2],raw.train.subject)
colnames(raw.train) <- cnames
raw.test <- cbind(raw.test.x,raw.test.y.activ[ ,2],raw.test.subject)
colnames(raw.test) <- cnames
##### Row bind train and test data
raw.total <- rbind(raw.train,raw.test)

### Subset the data
##### subset to variables with mean- and std-measurements.
subset.total <- raw.total[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562,563)]
head(subset.total)

### Calculate averages of each variable by activity and subject.

averages <- aggregate(raw.total[,1:561], list(raw.total$activity,raw.total$subject), mean)
colnames(averages)[1:2] <- c("activity group", "subject group")
head(averages,2)

### Export results
write.table(subset.total, "C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/result1.txt", sep=",")
write.table(averages, "C:/Users/Kristian/SkyDrive/Coursera/Data Science Specialization/Getting and Cleaning Data/Assignment. Course Project/result2.txt", sep=",")

