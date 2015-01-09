# Download and clean data
 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- tempfile()
download.file(fileUrl, destfile, method = "curl")
downloaded_file <- unzip(destfile)
unlink(destfile)

power_usage <- read.table(downloaded_file, header=TRUE, sep=";")
power_usage$Date <- as.Date(power_usage$Date, format="%d/%m/%Y")
twoday_usage <- subset(power_usage, power_usage$Date == "2007-02-01" | power_usage$Date == "2007-02-02")
twoday_usage$Global_active_power <- as.numeric(as.character(twoday_usage$Global_active_power))

#transform dates

timestamp <- paste(as.Date(twoday_usage$Date), twoday_usage$Time)
twoday_usage$Datetime <- as.POSIXct(timestamp)

# Plot data as plot1.png

plot(twoday_usage$Datetime,twoday_usage$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type ="l")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
unlink(downloaded_file)
