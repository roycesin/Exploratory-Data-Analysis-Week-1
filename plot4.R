library(dplyr)

#Load File and conver to dplyr, Clean up
df <- read.delim("household_power_consumption.txt", header=TRUE,sep=";",stringsAsFactors = FALSE)
dpdf <- tbl_df(df)
rm(df)

#Filter by dates, Clean Up
dpdf$Date <- as.Date(dpdf$Date,format = "%d/%m/%Y")
date_df <- filter(dpdf,Date == "2007-02-01" | Date == "2007-02-02")
rm(dpdf)

#Create timestamp from date and time
date_df <- date_df %>% mutate(datetime = as.POSIXct(strptime(paste(Date,Time),format="%Y-%m-%d %H:%M:%S") ))

par(mfrow=c(2,2))

#plot 1
with(date_df, plot(datetime, Global_active_power, type = "l", xlab="", ylab="Global Active Power"))

#plot 2
with(date_df, plot(datetime, Voltage, type = "l", ylab="Voltage"))

#plot 3
with(date_df, plot(datetime, Sub_metering_1, type="l",col=1, xlab="", ylab="Engery sub metering"))
with(date_df, lines(datetime, Sub_metering_2, col=2))
with(date_df, lines(datetime, Sub_metering_3, col=4))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty ="n")

#plot 4
with(date_df, plot(datetime, Global_reactive_power, type = "l"))

dev.copy(png,'plot4.png')
dev.off()
