# code for plot1
Apower <- read.table("household_power_consumption.txt", header=TRUE, sep=";",stringsAsFactors=FALSE, na.strings = c("?", ""))
Bpower <- subset(Apower, Apower$Date %in% c("1/2/2007", "2/2/2007"))
Bpower$Date <- as.Date(Bpower$Date, format="%d/%m/%Y")
Bpower$date <- paste(Bpower$Date, Bpower$Time)
Bpower$date_time <- strptime(Bpower$date, "%Y-%m-%d %H:%M:%S") 

png(file = "plot1.png")
plot1 <- hist(Bpower$Global_active_power, main= "Global Active Power", col= "red", xlab="Global Active Power (kilowatts)")
dev.off()

# code for plot2
Apower <- read.table("household_power_consumption.txt", header=TRUE, sep=";",stringsAsFactors=FALSE, na.strings = c("?", ""))
Bpower <- subset(Apower, Apower$Date %in% c("1/2/2007", "2/2/2007"))
Bpower$Date <- as.Date(Bpower$Date, format="%d/%m/%Y")
Bpower$date <- paste(Bpower$Date, Bpower$Time)
Bpower$date_time <- strptime(Bpower$date, "%Y-%m-%d %H:%M:%S") 

png(file = "plot2.png")
plot2 <- plot(Bpower$date_time, Bpower$Global_active_power, type="l", ylab="Global Active Power (killowatts)", xlab= "")
dev.off()

# code for plot3
Apower <- read.table("household_power_consumption.txt", header=TRUE, sep=";",stringsAsFactors=FALSE, na.strings = c("?", ""))
Bpower <- subset(Apower, Apower$Date %in% c("1/2/2007", "2/2/2007"))
Bpower$Date <- as.Date(Bpower$Date, format="%d/%m/%Y")
Bpower$date <- paste(Bpower$Date, Bpower$Time)
Bpower$date_time <- strptime(Bpower$date, "%Y-%m-%d %H:%M:%S") 

png(file = "plot3.png")
plot3 <- with(Bpower, plot(date_time, Sub_metering_1, type="l",ylab="Energy sub metering", xlab= ""))
with(subset(Bpower),points(date_time, Sub_metering_2, type="l", col="red"))
with(subset(Bpower),points(date_time, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()

# code for plot4
Apower <- read.csv("household_power_consumption.txt", sep=";",stringsAsFactors=FALSE,na.strings = c("?", ""))
Bpower <- Apower[Apower$Date %in% c("1/2/2007","2/2/2007"),]
Bpower$Date <- as.Date(Bpower$Date, format="%d/%m/%Y")
Bpower$date <- paste(Bpower$Date, Bpower$Time)
Bpower$date_time <- strptime(Bpower$date, "%Y-%m-%d %H:%M:%S") 

png(file = "plot4.png")
par(mfrow=c(2,2), mar=c(4,4,2,1))
plotAll <- with(Bpower, {
    plot1 <- plot(Bpower$date_time, Bpower$Global_active_power, type="l", ylab="Global Active Power", xlab= "")
    plot2 <- plot(Bpower$date_time, Bpower$Voltage, type="l", ylab="Voltage", xlab= "datetime")
    plot3 <- with(Bpower, plot(date_time, Sub_metering_1, type="l",ylab="Energy sub metering", xlab= ""))
    
    with(subset(Bpower),points(date_time, Sub_metering_2, type="l", col="red"))
    with(subset(Bpower),points(date_time, Sub_metering_3, type="l", col="blue"))
    legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
    plot4 <- plot(Bpower$date_time, Bpower$Global_reactive_power, type="l", ylab="Global_reactive_power",xlab= "datetime")
})
dev.off()
