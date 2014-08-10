plot4 <- function() {
  #Using sqldf to pull only related data for this project.
  library(sqldf)
  #Connect to file and pull data for first two days of Feb 2007
  electricdataF <- file("./household_power_consumption.txt")
  attr(electricdataF,"file.format") <- list(sep=";",header=TRUE)
  electricData <- sqldf("select * from electricdataF where Date in ('1/2/2007','2/2/2007')")
  close(electricdataF)
  electricData$DateTime <- paste(electricData$Date,electricData$Time) 
  electricData$DateTime <- strptime(electricData$DateTime,"%d/%m/%Y %H:%M:%S")
  #set plot boundaries
  par(mfrow = c(2,2))
  #generate plots
  #generate global active power vs Datetime
  with(electricData,plot(DateTime,Global_active_power,type="n",
                         ylab = "Global Active Power",
                         xlab = "",bg="blue",cex=0.5,
                         cex.axis=0.75,cex.lab=0.9,font=2))
  with(electricData,lines(DateTime,Global_active_power))
  #generate voltage vs Datetime
  with(electricData,plot(DateTime,Voltage,type="n",
                         ylab = "Voltage",
                         xlab = "",bg="blue",cex=0.5,
                         cex.axis=0.75,cex.lab=0.9,font=2))
  with(electricData,lines(DateTime,Voltage))
  #generate energy sub metering vs Datetime
  with(electricData,plot(DateTime,Sub_metering_1,type="n",
                         ylab = "Energy sub metering",
                         xlab = "",bg="blue",cex=0.5,
                         cex.axis=0.75,cex.lab=0.9,font=2))
  with(electricData,lines(DateTime,Sub_metering_1,col="darkblue"))
  with(electricData,lines(DateTime,Sub_metering_2,col="red"))
  with(electricData,lines(DateTime,Sub_metering_3,col="blue"))
  legend("topright",lty=c(1,1,1),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
         col=c("darkblue","red","blue"),cex=0.75,bty="n")
  #generate global reactive power vs Datetime
  with(electricData,plot(DateTime,Global_reactive_power,type="n",
                         ylab = "Global Reactive Power",
                         xlab = "",bg="blue",cex=0.5,
                         cex.axis=0.75,cex.lab=0.9,font=2))
  with(electricData,lines(DateTime,Global_reactive_power))
  #copy into a .png file
  dev.copy(png,file="plot4.png")
  dev.off()
}