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

png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")


#Plot 2


plot(data$FullDate,data$Global_active_power,type='S',xlab="",
     ylab='Global Active Power (kilowatts)')


# Devide off

dev.off()