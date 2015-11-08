## This R script will create Plot3 of he Assignment 1,
## Global Active Power usage between 2007-02-01 and 2007-02-02
## The print statements provide a clue as to what steps are
## to be executed.
##
## The datafile must already exist in a relative directory "../data"
##
## To execute:  > source("plot3.R")
##
## This is a single line graph with three variables

print("Set the beginning and ending dates to filter data.")
dateStart <- as.Date("2007-02-01", format = "%Y-%m-%d")
dateEnd <- as.Date("2007-02-02", format = "%Y-%m-%d")

print("Reading Data File ...")
dfHpcOrig <- read.csv2("../data/household_power_consumption.txt", sep = ";", as.is = TRUE)
print("Reading Data File - Done")

print("Make copy of original data to work with")
dfHpc <- dfHpcOrig

print("Convert 2nd column - Time, to datetime stamp class.")
dfHpc[[2]] <- strptime(paste(dfHpc$Date,dfHpc$Time), format = "%d/%m/%Y %H:%M:%S")

print("Convert 1st column - Date, to a date class.")
dfHpc[[1]] <- as.Date(dfHpc$Date, format = "%d/%m/%Y")

print("Filter date for begin and ending dates")
dfHpc <- dfHpc[which(dfHpc$Date >= dateStart & dfHpc$Date <= dateEnd), ]
#str(dfHpc)

print("Convert Global_active_power to a number")
suppressWarnings(dfHpc$Global_active_power <- as.numeric(dfHpc$Global_active_power))

print("Convert Sub_Metering_x to a number")
suppressWarnings(dfHpc$Sub_metering_1 <- as.numeric(dfHpc$Sub_metering_1))
suppressWarnings(dfHpc$Sub_metering_2 <- as.numeric(dfHpc$Sub_metering_2))
suppressWarnings(dfHpc$Sub_metering_3 <- as.numeric(dfHpc$Sub_metering_3))
#str(dfHpc)

# str(dfHpc)
# head(dfHpc, 3)

print("Plot Sub_Meter_1 in black")
plot(dfHpc$Time, dfHpc$Sub_metering_1, type="l",
	  ylab = "Energy sub metering", xlab = "")

print("Plot Sub_Meter_2 in red")
points(dfHpc$Time, dfHpc$Sub_metering_2, type="l", col = "red")

print("Plot Sub_Meter_3 in blue")
points(dfHpc$Time, dfHpc$Sub_metering_3, type="l", col = "blue")

print("Add Legend")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
		 col=c("black","red","blue"), lwd=c(1,1,1))

print("Creating png file")
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()