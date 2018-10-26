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

#Plot 2
with(date_df, plot(datetime, Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)"))

dev.copy(png,'plot2.png')
dev.off()
