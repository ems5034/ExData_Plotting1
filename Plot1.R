## Read data into R
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", stringsAsFactors= FALSE, dec= ".") 

library(lubridate)    ## open lubridate for easy Date/Time management

## make new column with merged date and time
mydata$date_time <- dmy_hms(paste(mydata$Date, mydata$Time))   

## subset data for dates 2007-02-01 through 2007-02-02
newdata <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007", select= c(Global_active_power:date_time))

## Create plot as .png
png(file = "plot1.png", width = 480, height = 480)

## Global_active_power from Character class to numeric class
GAP <- as.numeric(newdata$Global_active_power)

## Create histogram with red bars titled Global Active Power
hist(GAP, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()