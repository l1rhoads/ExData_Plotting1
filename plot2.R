# Exploratory Data Analysis
# Assignment: Course Project 1
# Data location: 
#        https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip


options(stringsAsFactors = FALSE)
library(ggplot2)

#####################
#Set some variables:
#####################

#URL location of data:
URL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#get current directory location:
ProjDir = getwd()
#here is where we'll put the data that we download:
DataDir = "data/"
#destZipFile
destZipFile="data.zip" 
destFileName = "household_power_consumption.txt"

PNGFileName <- "plot2.png"

#download, unzip then delete zip file.
if (!file.exists(destFileName)) {
        download.file(url=URL, destfile = destZipFile)
        unzip(destZipFile, exdir = ".")
        file.remove(destZipFile)
}

#we unzipped to working directory...
#now, load the data from the unzipped text files:
f <- read.table(destFileName, sep = ";", header=TRUE) #note it is ; delimited

#but we don't want it all, we only want 2 dates: 2007-02-01 and 2007-02-02.
#first covert to date
f$Date<-as.Date(f$Date,  "%d/%m/%Y" ) #is in format like: 16/12/2006

#subset for just those 2 dates:
f<-f[f$Date=="2007-02-01" | f$Date=="2007-02-02", ]

#put date time together
localDateTime <- paste(f$Date, f$Time)
#now add:
f$DateTime <- as.POSIXct(localDateTime)

#turn any "?" into NA
f$Global_active_power[f$Global_active_power=="?"] <- NA 
f$Global_reactive_power[f$Global_reactive_power=="?"] <- NA 
f$Voltage[f$Voltage=="?"] <- NA 
f$Global_intensity[f$Global_intensity=="?"] <- NA 
f$Sub_metering_1[f$Sub_metering_1=="?"] <- NA 
f$Sub_metering_2[f$Sub_metering_2=="?"] <- NA 
f$Sub_metering_3[f$Sub_metering_3=="?"] <- NA 

#turn rest into numeric formats:
f$Global_active_power <- as.numeric(f$Global_active_power)
f$Global_reactive_power<-as.numeric(f$Global_reactive_power)
f$Voltage<-as.numeric(f$Voltage)
f$Global_intensity<-as.numeric(f$Global_intensity)
f$Sub_metering_1<-as.numeric(f$Sub_metering_1)
f$Sub_metering_2<-as.numeric(f$Sub_metering_2)
f$Sub_metering_3<-as.numeric(f$Sub_metering_3)

#start up device
png(file=PNGFileName, width = 480, height = 480, units = "px")

plot(Global_active_power ~ DateTime, data=f, type="l",ylab="Global Active Power (kilowatts)", xlab="")
        
dev.off()

