#Create plot4

## read data
powerdata <- read.table(unzip("C:-/household_power_consumption.zip","household_power_consumption.txt"), stringsAsFactors = FALSE, header = TRUE, sep =";"  )

## Create column in table with date and time merged together
FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerdata <- cbind(powerdata, FullTimeDate)

## change class of all columns to correct class
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
powerdata$Voltage <- as.numeric(powerdata$Voltage)
powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

## subset data from 2007-02-01 and 2007-02-02
subsetdata <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")

globalActivePower <- as.numeric(subsetdata$Global_active_power)
globalReactivePower <- as.numeric(subsetdata$Global_reactive_power)
voltage <- as.numeric(subsetdata$Voltage)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)


## plot the 4 graphs
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
with(subsetdata, plot(FullTimeDate, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2))
with(subsetdata, plot(FullTimeDate, voltage, type="l", xlab="datetime", ylab="Voltage"))
with(subsetdata, plot(FullTimeDate, subMetering1, type="l", ylab="Energy Submetering", xlab=""))
lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_2,type="l", col= "red")
lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_3,type="l", col= "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
with(subsetdata, plot(FullTimeDate, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()