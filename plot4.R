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

png(filename="plot4.png")
par(mfrow=c(2,2),mar=c(4,4.2,2,2))

with(tab,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

with(tab,plot(datetime,Voltage,type="l", xlab="",ylab="Voltage"))

with(tab,plot(datetime,type="n",Sub_metering_1,xlab="",ylab="Energy sub metering"))
with(tab,points(datetime,Sub_metering_1,type="l"))
with(tab,points(datetime,Sub_metering_2,type="l",col="blue"))
with(tab,points(datetime,Sub_metering_3,type="l",col="red"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, bty="n", cex=0.7, col=c("black","red","blue"))

with(tab, plot(datetime,Global_reactive_power,type="l",
               xlab="datetime",ylab="Global_reactive_power"))
dev.off()

