Reading in the dataset
======================

    setwd("~/Desktop/CourseraDataScience/")
    activity_data <- read.csv("activity 2.csv", header=TRUE, stringsAsFactors = FALSE)

Variables:

-   steps: Number of steps taking in a 5-minute interval (missing values
    are coded as NA)

-   date: The date on which the measurement was taken in YYYY-MM-DD
    format

-   interval: Identifier for the 5-minute interval in which measurement
    was taken

What is mean total number of steps taken per day?
=================================================

Histogram of the total number of steps taken each day

    activity_data$date <- as.Date(activity_data$date)

calculate the total number of steps per day

    steps_per_day <- tapply(activity_data$steps, activity_data$date, sum)

plot the histogram

    hist(steps_per_day, breaks = length(steps_per_day), xlab = "Steps per Day", main = "Histogram of the total number of steps taken each day")

![](PA1_template_files/figure-markdown_strict/histogram_with_NAs-1.png)

Mean and median number of steps taken each day
==============================================

calculate the mean of steps taken per day (including missing values)

    mean(steps_per_day, na.rm = TRUE)

    ## [1] 10766.19

calculate the median of steps taken per day (including missing values)

    median(steps_per_day, na.rm = TRUE)

    ## [1] 10765

take out missing values in steps and the entire data frame

    activity_full <- activity_data[!is.na(activity_data$steps), ]

What is the average daily activity pattern?
===========================================

averaged steps per interval

    averageInterval <- tapply(activity_full$steps, activity_full$interval, mean)

    plot(as.numeric(names(averageInterval)), averageInterval, type="l", xlab = "Intervals", ylab = "Average Steps")

![](PA1_template_files/figure-markdown_strict/daily_activity_with_NAs-1.png)
The 5-minute interval that, on average, contains the maximum number of
steps

    names(averageInterval[which.max(averageInterval)])

    ## [1] "835"

Imputing missing values
=======================

replace missing values in variable steps with mean of all steps

    activity_data[is.na(activity_data)] <- mean(activity_data$steps, na.rm = TRUE)

Histogram of the total number of steps taken each day after missing
values are imputed

    steps_per_day <- tapply(activity_data$steps, activity_data$date, sum)
    hist(steps_per_day, breaks = length(steps_per_day), xlab = "Steps per Day", main = "Histogram of the total number of steps taken each day", sub = "with missing values imputed")

![](PA1_template_files/figure-markdown_strict/histogram_without_NAs-1.png)
\# Are there differences in activity patterns between weekdays and
weekends? add a column to the data frame "activity\_data" displaying the
weekdays

    activity_data$days <- weekdays(activity_data$date)

filter 2 data frames for weekdays and weekends

    weekdays_data <- activity_data[(activity_data$days != "Saturday") & (activity_data$days != "Sunday"), ]
    weekends_data <- activity_data[(activity_data$days == "Saturday") & (activity_data$days == "Saturday"), ]

take the mean of the steps per interval for each of the newly generated
data frames

    weekdays_ave <- tapply(weekdays_data$steps, weekdays_data$interval, mean)
    weekends_ave <- tapply(weekends_data$steps, weekends_data$interval, mean)

make a panel plot comparing the average number of steps taken per 5
minute interval across weekdays and weekends

    par(mfrow=c(2,1))
    plot(as.numeric(names(weekdays_ave)), weekdays_ave, type="l", xlab = "Intervals", ylab = "Average Steps", main = "Average Steps on Weekdays")
    plot(as.numeric(names(weekends_ave)), weekends_ave, type="l", xlab = "Intervals", ylab = "Average Steps", main = "Average Steps on Weekends")

![](PA1_template_files/figure-markdown_strict/planel_plot-1.png)
