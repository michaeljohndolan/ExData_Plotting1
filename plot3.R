#Fetch the names to use after you've grepped
nme<-names(read.table(file = "household_power_consumption.txt", header=TRUE, sep=";")[1,])
#Read in the file using a command line output 
power<-read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header=TRUE,
                  , col.names=nme, sep = ";")

#Fix the dates
power$Time<-strptime(paste(power$Date,power$Time),"%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, "%d/%m/%Y")

#Plot3
png("plot3.png", width=400, height=400)
plot(x = power$Time, y = power$Sub_metering_1, type="l", 
     ylab="Energy sub metering", xlab="")
lines(x = power$Time, y= power$Sub_metering_2, col="red")
lines(x = power$Time, y= power$Sub_metering_3, col="blue")
legend("topright",col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)
dev.off()
