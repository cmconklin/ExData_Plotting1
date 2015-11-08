print("Set the beginning and ending dates to filter data.")
dateStart <- as.Date("2007-02-01", format = "%Y-%m-%d")
dateEnd <- as.Date("2007-02-02", format = "%Y-%m-%d")

print("Reading Data File ...")
dfHpcOrig <- read.csv2("household_power_consumption.txt", sep = ";", as.is = TRUE)
print("Reading Data File - Done")

print("Make copy of original data to work with")
dfHpc <- dfHpcOrig

print("Convert 2nd column - Time, to datetime stamp class.")
dfHpc[[2]] <- strptime(paste(dfHpc$Date,dfHpc$Time), format = "%d/%m/%Y %H:%M:%S")

print("Convert 1st column - Date, to a date class.")
dfHpc[[1]] <- as.Date(dfHpc$Date, format = "%d/%m/%Y")

print("Convert Global_active_power to a number")
suppressWarnings(dfHpc$Global_active_power <- as.numeric(dfHpc$Global_active_power))

# str(dfHpc)
# head(dfHpc, 3)

print("Filter date for begin and ending dates")
dfHpc <- dfHpc[which(dfHpc$Date >= dateStart & dfHpc$Date <= dateEnd), ]

# hist(dfHpc$Global_active_power, col = "red", main = "Global Active Power")
hist(dfHpc$Global_active_power, col = "red", main = "Global Active Power",
	  ylab = "Frequency", xlab = "Global Active Power (kilowatts)")

print("Creating png file")
dev.copy(png, file="plot1.png")
dev.off()