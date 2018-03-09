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

# plot 4
plot4 <- function() {
  
  png(file = "plot4.png", bg = "transparent", width = 480, height = 480, units = "px")
  
  par(mfrow = c(2, 2))
  
  plot(
    Global_active_power ~ DateTime,
    type = "l"
  )
  
  plot(
    Voltage ~ DateTime,
    type = "l"
  )
  
  with(electricPowerData, {
    plot(
      Sub_metering_1 ~ DateTime,
      type = "l"
    )
    
    lines(
      Sub_metering_2 ~ DateTime,
      col = "red"
    )
    
    lines(
      Sub_metering_3 ~ DateTime,
      col = "blue"
    )
  }) # end with
  
  plot(
    Global_reactive_power ~ DateTime,
    type = "l"
  )
  
  dev.off()
  
}

plot4()
