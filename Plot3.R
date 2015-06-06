## Read data into R
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", stringsAsFactors= FALSE, dec= ".") 

library(lubridate)    ## open lubridate for easy Date/Time management

## make new column with merged date and time
mydata$date_time <- dmy_hms(paste(mydata$Date, mydata$Time))   

## subset data for dates 2007-02-01 through 2007-02-02
newdata <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007", select= c(Global_active_power:date_time))

## Create plot as .png
png(file = "plot3.png", width = 480, height = 480)

## Sub_metering from Character class to numeric class
sm1 <- as.numeric(newdata$Sub_metering_1)
sm2 <- as.numeric(newdata$Sub_metering_2)
sm3 <- as.numeric(newdata$Sub_metering_3)

## set the initial plot lines and titles/axis labeling
plot(newdata$date_time, sm1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")

## Add additional Sub metering lines
lines(newdata$date_time, sm2, col = "red", type = "l")
lines(newdata$date_time, sm3, col = "blue", type = "l")

## Add Legend to top right 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, lwd = 2)
dev.off()