# Entire code which reconstructs plot4.png

# Download data
 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- tempfile()
download.file(fileUrl, destfile, method = "curl")
downloaded_file <- unzip(destfile)
unlink(destfile)

# Load and clean data

power_usage <- read.table(downloaded_file, header=TRUE, sep=";", na.strings = "?")
power_usage$Date <- as.Date(power_usage$Date, format="%d/%m/%Y")
twoday_usage <- subset(power_usage, power_usage$Date == "2007-02-01" | power_usage$Date == "2007-02-02")
twoday_usage$Global_active_power <- as.numeric(as.character(twoday_usage$Global_active_power))
twoday_usage$Sub_metering_1 <- as.numeric(as.character(twoday_usage$Sub_metering_1))
twoday_usage$Sub_metering_2 <- as.numeric(as.character(twoday_usage$Sub_metering_2))
twoday_usage$Sub_metering_3 <- as.numeric(as.character(twoday_usage$Sub_metering_3))
twoday_usage$Global_reactive_power <- as.numeric(as.character(twoday_usage$Global_reactive_power))
twoday_usage$Voltage <- as.numeric(as.character(twoday_usage$Voltage))

# Transform dates

timestamp <- paste(as.Date(twoday_usage$Date), twoday_usage$Time)
twoday_usage$Datetime <- as.POSIXct(timestamp)

# Plot data as plot4.png

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

with(twoday_usage, {

# 1st of 4 plots
plot(twoday_usage$Datetime,twoday_usage$Global_active_power, xlab="", ylab="Global Active Power", type ="l")

# 2nd of 4 plots
plot(twoday_usage$Datetime,twoday_usage$Voltage, xlab="datetime", ylab="Voltage", type ="l")

# 3rd of 4 plots
plot(twoday_usage$Datetime,twoday_usage$Sub_metering_1, xlab="", ylab="Energy sub metering", type ="l")
lines(twoday_usage$Datetime,twoday_usage$Sub_metering_2, col="red")
lines(twoday_usage$Datetime,twoday_usage$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1 ","Sub_metering_2", "Sub_metering_3"), lwd=2, lty=1, cex=0.90, bty="n" )

# 4th of 4 plots
plot(twoday_usage$Datetime,twoday_usage$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type ="l")

})

dev.off()

# Delete the downloaded file

unlink(downloaded_file)
