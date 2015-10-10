#Exploratory Data - Plot 3

library(dplyr)
library(lubridate)

#Step 1. Download the data for the project
library(downloader)
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileurl, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = ".")  # this command extracts the household power consumption text file to the working directory 

#Filter the data to extract only 2007-02-01 and 2007-02-02. 
           
filenam <- "./household_power_consumption.txt"        
hpcdata <- read.table(filenam, header = TRUE, sep = ";", na.strings = c("?","")) 
studydata <- filter(hpcdata, Date == "1/2/2007" | Date == "2/2/2007")
remove(hpcdata)  #free up RAM   

#plot3
studydata <- mutate(studydata,DateII=as.Date(Date, format = "%d/%m/%Y"))
studydata$timetemp <- paste(studydata$DateII, studydata$Time)
studydata$Time <- strptime(studydata$timetemp, format = "%Y-%m-%d %H:%M:%S")
png(file = "plot3.png",width=480,height=480) ## Call png device
with(studydata, plot(Time, Sub_metering_1, type="l", xlab = "", ylab="Energy Sub metering"))  #plot chart 
with(studydata, points(Time, Sub_metering_2, type="l", col ="red"))
with(studydata, points(Time, Sub_metering_3, type="l", col ="blue"))
legend("topright", pch = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off() ## close the PNG device