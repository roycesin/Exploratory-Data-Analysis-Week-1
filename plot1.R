library(dplyr)

#Load File and conver to dplyr, Clean up
df <- read.delim("household_power_consumption.txt", header=TRUE,sep=";",stringsAsFactors = FALSE)
dpdf <- tbl_df(df)
rm(df)

#Filter by dates, Clean Up
dpdf$Date <- as.Date(dpdf$Date,format = "%d/%m/%Y")
date_df <- filter(dpdf,Date == "2007-02-01" | Date == "2007-02-02")
rm(dpdf)

#Plot 1
hist(as.numeric(date_df$Global_active_power), main="Global Acitve Power",xlab="Global Active Power (kilowatts)", col="red")

dev.copy(png,'plot1.png')
dev.off()
