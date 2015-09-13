#Fetch the names to use after you've grepped
nme<-names(read.table(file = "household_power_consumption.txt", header=TRUE, sep=";")[1,])
#Read in the file using a command line output 
power<-read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header=TRUE,
                  , col.names=nme, sep = ";")

#Fix the dates
power$Time<-strptime(paste(power$Date,power$Time),"%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, "%d/%m/%Y")

#Plot2
png("plot2.png", width=400, height=400)
plot(x = power$Time, y = power$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
