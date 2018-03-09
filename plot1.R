install.packages("readr")
install.packages("dplyr")
install.packages("lubridate")

library(readr)
library(dplyr)
library(lubridate)

if (!file.exists('household_power_consumption.zip')) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
}

electricPowerData <- read_delim(file = "data/household_power_consumption.zip", delim=";", na="?")

electricPowerData <- 
  electricPowerData %>% 
    mutate(Date = dmy(Date), Time = hms(Time), DateTime = as.POSIXct(Date + Time)) %>%
    filter(Date >= ymd('2007-02-01') & Date <= ymd('2007-02-02'))

attach(electricPowerData)

# plot 1
plot1 <- function() {
  
  png(file = "plot1.png", bg = "transparent", width = 480, height = 480, units = "px")
  
  hist(
    Global_active_power, 
    xlab = "Global Active power (kilowatts)", 
    ylab = "Frequency",
    main = "Global Active Power",
    col = "red"
  )
  
  dev.off()
  
}

plot1()
