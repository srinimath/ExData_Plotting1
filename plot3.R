plot3 <- function() {
  #Using sqldf to pull only related data for this project.
  library(sqldf)
  #Connect to file and pull data for first two days of Feb 2007
  electricdataF <- file("./household_power_consumption.txt")
  attr(electricdataF,"file.format") <- list(sep=";",header=TRUE)
  electricData <- sqldf("select * from electricdataF where Date in ('1/2/2007','2/2/2007')")
  close(electricdataF)
  electricData$DateTime <- paste(electricData$Date,electricData$Time) 
  electricData$DateTime <- strptime(electricData$DateTime,"%d/%m/%Y %H:%M:%S")
  #generate line plots
  with(electricData,plot(DateTime,Sub_metering_1,type="n",
                         ylab = "Energy sub metering",
                         xlab = "",bg="blue",cex=0.5,
                         cex.axis=0.75,cex.lab=0.9,font=2))
  with(electricData,lines(DateTime,Sub_metering_1,col="darkblue"))
  with(electricData,lines(DateTime,Sub_metering_2,col="red"))
  with(electricData,lines(DateTime,Sub_metering_3,col="blue"))
  legend("topright",lty=c(1,1,1),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
         col=c("darkblue","red","blue"),cex=0.6)
  
  #copy into a .png file
  dev.copy(png,file="plot3.png")
  dev.off()
}