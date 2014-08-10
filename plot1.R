plot1 <- function() {
  #Using sqldf to pull only related data for this project.
  library(sqldf)
  #Connect to file and pull data for first two days of Feb 2007
  electricdataF <- file("./household_power_consumption.txt")
  attr(electricdataF,"file.format") <- list(sep=";",header=TRUE)
  electricData <- sqldf("select * from electricdataF where Date in ('1/2/2007','2/2/2007')")
  close(electricdataF)
  #generate histogram plot
  hist(electricData$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",main="Global Active Power")
  #copy into a .png file
  dev.copy(png,file="plot1.png")
  dev.off()
}