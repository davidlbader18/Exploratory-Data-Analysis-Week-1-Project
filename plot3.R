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

png(filename="plot3.png")
par(mar=c(3,4,2,1), oma=c(0.5,0.5,0,0))
with(tab,plot(datetime,type="n",Sub_metering_1,xlab="",ylab="Energy sub metering"))
with(tab,points(datetime,Sub_metering_1,type="l"))
with(tab,points(datetime,Sub_metering_2,type="l",col="blue"))
with(tab,points(datetime,Sub_metering_3,type="l",col="red"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, bty="o", col=c("black","red","blue"))
dev.off()