## Read data into R
mydata <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", stringsAsFactors= FALSE, dec= ".") 

library(lubridate)    ## open lubridate for easy Date/Time management

## make new column with merged date and time
mydata$date_time <- dmy_hms(paste(mydata$Date, mydata$Time))   

## subset data for dates 2007-02-01 through 2007-02-02
newdata <- subset(mydata, Date == "1/2/2007" | Date == "2/2/2007", select= c(Global_active_power:date_time))


GAP <- as.numeric(newdata$Global_active_power)
sm1 <- as.numeric(newdata$Sub_metering_1)
sm2 <- as.numeric(newdata$Sub_metering_2)
sm3 <- as.numeric(newdata$Sub_metering_3)
volt <- as.numeric(newdata$Voltage)
GRP <- as.numeric(newdata$Global_reactive_power)

## Create plot as .png
png(file = "plot4.png", width = 480, height = 480)

## set plot parameters to arrange 4 plots as 2x2
par(mfrow = c(2,2))

## top left plot
plot(newdata$date_time, GAP, xlab = "", ylab = "Global Active Power", type = "l", col = "black")

## top right plot
plot(newdata$date_time, volt, xlab = "datetime", ylab = "Voltage", type = "l", col = "black")

## bottom left plot
plot(newdata$date_time, sm1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")

## Add additional Sub metering lines
lines(newdata$date_time, sm2, col = "red", type = "l")
lines(newdata$date_time, sm3, col = "blue", type = "l")

## Add Legend to top right 
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, lwd = 1, bty = "n")

## bottom right plot
plot(newdata$date_time, GRP, xlab = "datetime", ylab = "Global_reactive_power", type = "l", col = "black")
dev.off()