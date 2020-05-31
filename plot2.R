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

#Plotting Global Active Power per a day and saving it as a PNG:
png(filename = "plot2.png")
plot(Feb2DayDataFilteredDateTime$Global_active_power ~ Feb2DayDataFilteredDateTime$DateTime, ylim = c(0,8), xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()