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

#Removing empty rows and filtering data to Feb. 1 and Feb. 2, 2007
Feb2DayDataFiltered <- FullData %>% drop_na() %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02")

#Plotting Frequency per Global Active Power and saving it as a PNG:
png(filename = "plot1.png")
hist(Feb2DayDataFiltered$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()