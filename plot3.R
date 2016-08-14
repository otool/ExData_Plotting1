#This function loads the HPC dataset, reduces the HPC dataset, and creates Plot 3 in a 480px-480px PNG file
plot3 <- function(filePath){
  #Read in all data (This handles the header correctly), as.is=TRUE causes strings to be read as strings
  hpc <- read.table(file=filePath,header=TRUE,sep=";",as.is=TRUE,na.strings="?")
  
  #Reduce dataset immediately to Feb 1, 2007 and Feb 2, 2007 (and convert to Date)
  hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")
  keep <- hpc$Date == "2007-2-1" | hpc$Date == "2007-2-2"
  hpc <- hpc[keep,]
  rm(keep)
  
  #Convert to Time (add Date info here too)
  hpc$Time <- strptime(paste(hpc$Date," ",hpc$Time),"%Y-%m-%d %H:%M:%S")
  
  #Make Plot 3
  png(filename="plot3.png",width=480,height=480,units="px")
  plot(hpc$Time,hpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  lines(hpc$Time,hpc$Sub_metering_1,col="black")
  lines(hpc$Time,hpc$Sub_metering_2,col="red")
  lines(hpc$Time,hpc$Sub_metering_3,col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),inset=c(.1,.02),bty="n")
  dev.off()
}