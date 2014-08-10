plot2 <- function() {
  #Using sqldf to pull only related data for this project.
  library(sqldf)
  #Connect to file and pull data for first two days of Feb 2007
  electricdataF <- file("./household_power_consumption.txt")
  attr(electricdataF,"file.format") <- list(sep=";",header=TRUE)
  electricData <- sqldf("select * from electricdataF where Date in ('1/2/2007','2/2/2007')")
  close(electricdataF)
  electricData$DateTime <- paste(electricData$Date,electricData$Time) 
  electricData$DateTime <- strptime(electricData$DateTime,"%d/%m/%Y %H:%M:%S")
  #generate line plot
  with(electricData,plot(DateTime,Global_active_power,type="n",ylab = "Global Active Power (kilowatts)",xlab = ""))
  with(electricData,lines(DateTime,Global_active_power))
  #copy into a .png file
  dev.copy(png,file="plot2.png")
  dev.off()
}