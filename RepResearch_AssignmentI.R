# read in activity data
# 1. Code for reading in the dataset and/or processing the data
setwd("~/Desktop/CourseraDataScience/")
activity_data <- read.csv("activity 2.csv", header=TRUE, stringsAsFactors = FALSE)

# variables:     
## steps: Number of steps taking in a 5-minute interval (missing values are coded as NA)
## date: The date on which the measurement was taken in YYYY-MM-DD format
## interval: Identifier for the 5-minute interval in which measurement was taken

# What is mean total number of steps taken per day?
# 2. Histogram of the total number of steps taken each day
activity_data$date <- as.Date(activity_data$date)
# calculate the total number of steps per day
steps_per_day <- tapply(activity_data$steps, activity_data$date, sum)
# plot the histogram
hist(steps_per_day, breaks = length(steps_per_day), xlab = "Steps per Day", main = "Histogram of the total number of steps taken each day")

# 3. Mean and median number of steps taken each day
# calculate the mean of Steps taken per Day
mean(steps_per_day, na.rm = TRUE)
# calculate the median of Steps taken per Day
median(steps_per_day, na.rm = TRUE)

#What is the average daily activity pattern?
# 4. Time series plot of the average number of steps taken
library(plyr)
activity_full <- activity_data[!is.na(activity_data$steps), ]
# dailySteps <- ddply(activity_full,.(date), summarize, sum=ave(steps, FUN=sum))
# plot(activity_full$interval, dailySteps$sum, type="l")
# plot(dailySteps$date, dailySteps$sum, type="l")

# averaged steps per interval
averageInterval <- tapply(activity_full$steps, activity_full$interval, mean)

plot(as.numeric(names(averageInterval)), averageInterval, type="l", xlab = "Intervals", ylab = "Average Steps")

# 5. The 5-minute interval that, on average, contains the maximum number of steps
names(averageInterval[which.max(averageInterval)])

# Imputing missing values
# 6. Code to describe and show a strategy for imputing missing data
activity_data[is.na(activity_data)] <- mean(activity_data$steps, na.rm = TRUE)

# 7. Histogram of the total number of steps taken each day after missing values are imputed
steps_per_day <- tapply(activity_data$steps, activity_data$date, sum)
hist(steps_per_day, breaks = length(steps_per_day), xlab = "Steps per Day", main = "Histogram of the total number of steps taken each day", sub = "with missing values imputed")

# Are there differences in activity patterns between weekdays and weekends?
# 8. Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends

# add a column to the data frame "activity_data" displaying the weekdays
activity_data$days <- weekdays(activity_data$date)
# filter 2 data frames for weekdays and weekends
weekdays_data <- activity_data[(activity_data$days != "Saturday") & (activity_data$days != "Sunday"), ]
weekends_data <- activity_data[(activity_data$days == "Saturday") & (activity_data$days == "Saturday"), ]

# take the mean of the steps per interval for each of the newly generated data frames
weekdays_ave <- tapply(weekdays_data$steps, weekdays_data$interval, mean)
weekends_ave <- tapply(weekends_data$steps, weekends_data$interval, mean)

# make a panel plot comparing the average number of steps taken per 5 minute interval across weekdays and weekends
par(mfrow=c(2,1))
plot(as.numeric(names(weekdays_ave)), weekdays_ave, type="l", xlab = "Intervals", ylab = "Average Steps", main = "Average Steps on Weekdays")
plot(as.numeric(names(weekends_ave)), weekends_ave, type="l", xlab = "Intervals", ylab = "Average Steps", main = "Average Steps on Weekends")

# 9. All of the R code needed to reproduce the results (numbers, plots, etc.) in the report

install.packages("knitr")
library(knitr)
knit2html("PA1_template.md")




