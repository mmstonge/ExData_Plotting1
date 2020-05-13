> #read data
> 
> cls <- c(Voltage="numeric", Global_active_power="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric",Global_active_power="numeric",Global_reactive_power="numeric")
> 
> data <- read.table("household_power_consumption.txt", header=TRUE, sep=";",dec=".", stringsAsFactors=FALSE, na.strings = "?",colClasses=cls)
> powerDT <- data.table::fread(input = "household_power_consumption.txt"
+                              , na.strings="?"
+ )
> 
> # Prevents Scientific Notation
> powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
> 
> # Making a POSIXct date capable of being filtered and graphed by time of day
> powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
> 
> # Filter Dates for 2007-02-01 and 2007-02-02
> powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
> 
> png("plot2.png", width=480, height=480)
> 
> ## Plot 2
> plot(x = powerDT[, dateTime]
+      , y = powerDT[, Global_active_power]
+      , type="l", xlab="", ylab="Global Active Power (kilowatts)")
> 
> dev.off()
RStudioGD 
        2 
> 
> 
> 
> power <- read.table("household_power_consumption.txt",skip=1,sep=";")
> names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
> subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")
> 
> # Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
> subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
> subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")
> subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
> subpower[1441:2880,"Time"] <- format(subpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
> 
> 
> # calling the basic plot function
> plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 
> 
> # annotating graph
> title(main="Global Active Power Vs Time")
