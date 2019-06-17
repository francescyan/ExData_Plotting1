#Week 1 Project plot 4
#plot given graphs
#file has already been downloaded manually

#read data
powerCons <- read.table("./data/JH Exploratory Data Analysis Data/household_power_consumption.txt",
                        header = TRUE, sep = ";", na.strings = "?", colClasses = c(NA, NA, rep ("numeric", 7)))

#subset for feb 01 2007 and feb 02 2007 only
startDate = as.POSIXct("2007-02-01")
endDate = as.POSIXct("2007-02-02")
all_dates = seq(startDate, endDate, 86400) #86400 is num of seconds in a day

#the following code I'm trying to run inside a loop...
#as.POSIXct is already reading it into a Date class, just need to tell it 
#       what the incoming fomrat is, just like as.Date.  Date format did not change
#       However comparing on dates based on as.Date did not work
powerConsFeb2Days <- data.frame()
for (j in 1:length(all_dates)) {
        filterdate = all_dates[j]
        print(filterdate)
        #        print(as.POSIXct(powerCons$Date))
        my_subset = powerCons[as.POSIXct(powerCons$Date, format="%d/%m/%Y") 
                              == filterdate,]
        powerConsFeb2Days <- rbind(powerConsFeb2Days, my_subset)
}

#get old.par
old.par <- par(mar=c(4,4,4,4))

#create png
png(filename = "./plot4.png", width = 480, height = 480, units = "px",
    type = c("quartz"))

#plot 4 arrange 4 plots on same screen
#tell it the layout and point shape to use
par(mfrow=c(2,2))
par(mar=c(4,4,2,2))
par(pch=".")

#put date and time together
x <- paste(powerConsFeb2Days$Date, powerConsFeb2Days$Time)
y <- strptime(x, "%d/%m/%Y %H:%M:%S")

#plot 1
plot(y,
     as.numeric(powerConsFeb2Days$Global_active_power),
     ylab="Global Active Power (kilowatts)",
     xlab="")
lines(y,
      as.numeric(powerConsFeb2Days$Global_active_power))

#plot 2
plot(y,
     powerConsFeb2Days$Voltage,
     ylab="Voltage",
     xlab="datetime")
lines(y,
      powerConsFeb2Days$Voltage)

#plot 3
plot(y,
     powerConsFeb2Days$Sub_metering_1,
     ylab="Energy sub metering",
     xlab="")
lines(y,
      powerConsFeb2Days$Sub_metering_1)
lines(y,
      powerConsFeb2Days$Sub_metering_2,
      col="red")
lines(y,
      powerConsFeb2Days$Sub_metering_3,
      col="blue")
legend("topright",pch="_",col=c("black","red","blue"), plot=TRUE,
       xjust=0.5, yjust=0.5,
       c("sub metering 1","sub metering 2","sub metering 3"))

#plot 4
plot(y,
     powerConsFeb2Days$Global_reactive_power,
     ylab="Global Reactive Power",
     xlab="datetime")
lines(y,
      powerConsFeb2Days$Global_reactive_power)

dev.off()
