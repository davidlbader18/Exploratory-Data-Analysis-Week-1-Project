setwd("~/R/graph project")

library(utils)
library(dplyr)

tab <- 
  read.table("household_power_consumption.txt",header=TRUE,sep=";",
             na.strings="?") %>%
  filter(as.character(Date) %in% c("1/2/2007","2/2/2007")) %>%
  mutate(Date=as.character(Date),Time=as.character(Time)) %>%
  mutate(datetime=paste(Date,Time,sep=" ")) %>%
  select(c(10, 3:9)) %>%
  mutate(datetime=as.POSIXct(strptime(datetime,format="%d/%m/%Y %H:%M:%S")))

png(filename="plot2.png")
with(tab,plot(datetime,Global_active_power,type="l",
              xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()