install.packages("readr")
install.packages("dplyr")
install.packages("lubridate")

library(readr)
library(dplyr)
library(lubridate)

if (!file.exists('data/household_power_consumption.zip')) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/household_power_consumption.zip")
}

electricPowerData <- read_delim(file = "data/household_power_consumption.zip", delim=";", na="?")

electricPowerData <- 
  electricPowerData %>% 
    mutate(Date = dmy(Date), Time = hms(Time), DateTime = as.POSIXct(Date + Time)) %>%
    filter(Date >= ymd('2007-02-01') & Date <= ymd('2007-02-02'))

attach(electricPowerData)

# plot 3
plot3 <- function() {
  
  png(file = "plot3.png", bg = "transparent", width = 480, height = 480, units = "px")
  
  with(electricPowerData, {
    plot(
      Sub_metering_1 ~ DateTime,
      type = "l",
      xlab = "",
      ylab = "Energy sub metering"
    )
  
    lines(
      Sub_metering_2 ~ DateTime,
      col = "red"
    )
  
    lines(
      Sub_metering_3 ~ DateTime,
      col = "blue"
    )
  
    legend(
      "topright",
      legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
      lty = 1,
      lwd = 3,
      col = c("black", "red", "blue")
    )
  }) # end with

  dev.off()
    
}

plot3()
