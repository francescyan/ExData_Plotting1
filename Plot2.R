#Week 1 Project Plot 2
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
png(filename = "./plot2.png", width = 480, height = 480, units = "px",
    type = c("quartz"))

#plot 2 time series graph (day of week default behavior)
#put date and time together
x <- paste(powerConsFeb2Days$Date, powerConsFeb2Days$Time)
y <- strptime(x, "%d/%m/%Y %H:%M:%S")

#order of y assumed to be with powerConsFeb2Days$Global_active_power
par <- old.par
par(pch=".")
plot(y,
     as.numeric(powerConsFeb2Days$Global_active_power),
     ylab="Global Active Power (kilowatts)",
     xlab="")
lines(y,
      as.numeric(powerConsFeb2Days$Global_active_power))

dev.off()