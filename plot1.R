# Entire code which reconstructs plot1.png

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

# Plot data as plot1.png

png(filename = "plot1.png", width = 480, height = 480)
hist(twoday_usage$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()

# Delete the downloaded file

unlink(downloaded_file)
