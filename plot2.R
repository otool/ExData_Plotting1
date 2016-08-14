#This function loads the HPC dataset, reduces the HPC dataset, and creates Plot 2 in a 480px-480px PNG file
plot2 <- function(filePath){
  #Read in all data (This handles the header correctly), as.is=TRUE causes strings to be read as strings
  hpc <- read.table(file=filePath,header=TRUE,sep=";",as.is=TRUE,na.strings="?")
  
  #Reduce dataset immediately to Feb 1, 2007 and Feb 2, 2007 (and convert to Date)
  hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")
  keep <- hpc$Date == "2007-2-1" | hpc$Date == "2007-2-2"
  hpc <- hpc[keep,]
  rm(keep)
  
  #Convert to Time (add Date info here too)
  hpc$Time <- strptime(paste(hpc$Date," ",hpc$Time),"%Y-%m-%d %H:%M:%S")
  
  #Make Plot 2
  png(filename="plot2.png",width=480,height=480,units="px")
  plot(hpc$Time,hpc$Global_active_power,type="l",main="",xlab="",ylab="Global Active Power (kilowatts)")
  dev.off()
}