# Download the file if necessary (29MB)
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
filePath <- "./data/repdata%2Fdata%2Factivity.zip"

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists(filePath)) {
  download.file(fileUrl, destfile = filePath)
   
  # And unzip it
  unzip(filePath, exdir="./data")
}

# Load the raw activity data
activityData <- read.csv("./data/activity.csv", stringsAsFactors=FALSE)


#Transform the date attribute to an actual date format
activityData$date <- as.POSIXct(activityData$date, format="%Y-%m-%d")

# Compute the weekdays from the date attribute
activityData <- data.frame(date=activityData$date, weekday=tolower(weekdays(activityData$date)), steps=activityData$steps, interval=activityData$interval)

activityData <- cbind(activityData,daytype=ifelse(activityData$weekday == "Saturday" | activityData$weekday == "Sunday", "weekend", "weekday"))


# Create the final data.frame
activity.frame <- data.frame(date=activityData$date, weekday=activityData$weekday, daytype=activityData$daytype, interval=activityData$interval,steps=activityData$steps)

# Clear the workspace
rm(activityData)


# Compute the total number of steps each day (NA values removed)
sumData <- aggregate(activity.frame$steps, by=list(activity.frame$date), FUN=sum, na.rm=TRUE)

# Rename the attributes
names(sumData) <- c("date", "StepsDay")



# Compute the histogram of the total number of steps each day
hist(sumData$StepsDay, breaks=seq(from=0, to=25000, by=2500), col="blue", xlab="Total number of steps", ylim=c(0, 20), main="Histogram of the total number of steps taken each day\n(NA removed)")


####Calculate and report the mean and median total number of steps taken per day

### The mean and median are computed like
mean(sumData$StepsDay)
median(sumData$StepsDay)


###Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

rm(sumData)


# Compute the means of steps accross all days for each interval
meanData <- aggregate(activity.frame$steps, by=list(activity.frame$interval), FUN=mean, na.rm=TRUE)

# Rename the attributes
names(mean_data) <- c("interval", "mean")


# Rename the attributes
plot(meanData$interval, meanData$mean, type="l", col="blue",lwd=2, xlab="Interval [minutes]", ylab="Average number of steps", main="Time-series of the average number of steps per intervals\n(NA removed)")


Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
# We find the position of the maximum mean
max_pos <- which(meanData$mean == max(meanData$mean))

# We lookup the value of interval at this position
max_interval <- meanDataata[max_pos, 1]

# Clear the workspace
rm(max_pos, meanData)

na_pos <- which(is.na(activity.frame$steps))

#Create a vector of means
meanVec <- rep(mean(activity.frame$steps, na.rm=TRUE), times=length(na_pos))



###Create a new dataset that is equal to the original dataset but with the missing data filled in.
# Replace the NAs by the means
activity.frame[na_pos, "steps"] <- meanVec

# Clear the workspace
rm(meanVec, na_pos)
head(activity.frame)



# Compute the total number of steps each day (NA values removed)
TotalStepsPerDay <- aggregate(activity.frame$steps, by=list(activity.frame$date), FUN=sum)

# Rename the attributes
names(TotalStepsPerDay) <- c("date", "Total")

# Compute the histogram of the total number of steps each day
hist(TotalStepsPerDay$Total, breaks=seq(from=0, to=25000, by=2500), col="blue", xlab="Total Steps", main="Histogram - Total steps taken each day\n(NA replaced by mean value)")

mean_data <- aggregate(activity.frame$steps, by=list(activity.frame$daytype, activity.frame$weekday, activity.frame$interval), mean)

names(mean_data) <- c("daytype", "weekday", "interval", "mean")

xyplot(mean ~ interval | daytype, mean_data, type="l", lwd=1, xlab="Interval",  ylab="Number of steps", layout=c(1,2))
