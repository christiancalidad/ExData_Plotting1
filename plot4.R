## Install and load  packakes
if(!"sqldf"%in%installed.packages()){
      install.packages("sqldf")
}
library(sqldf)
library(dplyr)
library(lubridate)

## Set Working directory

setwd("C:/Users/CHRISTIAN/Desktop/Coursera/Specialization/1/Tarea1Exploratory/ExData_Plotting1")


## Download data if doesn't exist

file <- 'exdata_data_household_power_consumption.zip'

bd<- 'household_power_consumption.txt'



if (!file.exists(file)){
      URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(URL, file, method="curl")
      if (!file.exists(bd)) {
            unzip(file)
            
      }
} 


## Read files into dataframes


data<- read.csv.sql(bd, "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", 
                    sep=";")

data<-mutate(data,FullDate = dmy_hms(paste(Date,Time)))
data <-mutate(data,Date =dmy(Date))
data <-mutate(data,Time =hms(Time))

data <-mutate(data,WeekDay =wday(Date,locale = "English",label=TRUE))

## Set PNG Device

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")



# plot 4

par(mfrow=c(2,2),cex=0.5)



plot(data$FullDate,data$Global_active_power,type='S',xlab="",
     ylab='Global Active Power (kilowatts)')

plot(data$FullDate,data$Voltage,type='S',xlab="",
     ylab='Voltage')


plot(data$FullDate,data$Sub_metering_1,type='S',xlab="",
     ylab='Energy sub metering')
lines(data$FullDate,data$Sub_metering_2,col='red')
lines(data$FullDate,data$Sub_metering_3,col='blue')
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"),lty=1)


plot(data$FullDate,data$Global_reactive_power,type='S',xlab="",
     ylab='Global Reactive power')

## Device off

dev.off()