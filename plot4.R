#Setting the working directory:
setwd("C:/RWorking/ExData_Plotting1/")
library(data.table)
library(dplyr)
library(tidyverse)

#unzipping the data source and creating the data set for data from 2007-02-01 to 2007-02-02
if(!file.exists("./household_power_consumption.txt")){
  unzip("exdata_data_household_power_consumption.zip")  
}
#Extracting data into a data table
ColumnFormat <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
FullData <- fread("household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";", dec = ".", colClasses = ColumnFormat)

#Formatting the first column as date
FullData$Date = as.Date(FullData$Date, format = "%d/%m/%Y")

#Removing empty rows and filtering data to Feb. 1 and Feb. 2, 2007. Introducing an additional column in daytime format
Feb2DayDataFiltered <- FullData %>% drop_na() %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02")
Feb2DayDataFilteredDateTime <- mutate(Feb2DayDataFiltered, DateTime = as.POSIXct(strptime(paste(Feb2DayDataFiltered$Date, Feb2DayDataFiltered$Time), "%Y-%m-%d %H:%M:%S")))

#Plotting 4 plots per a day and saving it as a PNG:
png(filename = "plot4.png")
par(mfcol = c(2,2))
plot(Feb2DayDataFilteredDateTime$Global_active_power ~ Feb2DayDataFilteredDateTime$DateTime, ylim = c(0,8), xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
plot(Feb2DayDataFilteredDateTime$Sub_metering_1 ~ Feb2DayDataFilteredDateTime$DateTime, ylim = c(0,40), xlab = "", ylab = "Energy sub-metering", type = "l")
lines(Feb2DayDataFilteredDateTime$Sub_metering_2 ~ Feb2DayDataFilteredDateTime$DateTime, ylim = c(0,40), col = "red")
lines(Feb2DayDataFilteredDateTime$Sub_metering_3 ~ Feb2DayDataFilteredDateTime$DateTime, ylim = c(0,40), col = "blue")
legend("topright",col = c("black","red","blue"), lty = c(1,1,1), lwd = c(1,1,1), legend = c("Sub-metering 1", "Sub-metering 2","Sub-metering 3"), )
plot(Feb2DayDataFilteredDateTime$Voltage ~ Feb2DayDataFilteredDateTime$DateTime, ylim = c(230,250), xlab = "Datetime", ylab = "Voltage", type = "l")
plot(Feb2DayDataFilteredDateTime$Global_reactive_power ~ Feb2DayDataFilteredDateTime$DateTime, ylim = c(0,0.5), xlab = "Datetime", ylab = "Global Reactive Power", type = "l")
dev.off()