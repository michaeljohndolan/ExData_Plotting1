#Fetch the names to use after you've grepped
nme<-names(read.table(file = "household_power_consumption.txt", header=TRUE, sep=";")[1,])
#Read in the file using a command line output 
power<-read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header=TRUE,
                  , col.names=nme, sep = ";")

#Fix the dates
power$Time<-strptime(paste(power$Date,power$Time),"%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, "%d/%m/%Y")

#Plot4
png("plot4.png", width=400, height=400)
par(mfrow=c(2,2))
plot(power$Time, power$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")
plot(power$Time, power$Voltage, xlab="datetime", ylab="Voltage", type="l")

#Code for the 3rd panel of plot 4
plot(x = power$Time, y = power$Sub_metering_1, type="l", 
     ylab="Energy sub metering", xlab="")
lines(x = power$Time, y= power$Sub_metering_2, col="red")
lines(x = power$Time, y= power$Sub_metering_3, col="blue")
legend("topright",col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,box.lwd=0)
#Final panel of plot 4
plot(power$Time,power$Global_reactive_power, 
     xlab="datetime", ylab="Global_reactive_power", type="l")
dev.off()

