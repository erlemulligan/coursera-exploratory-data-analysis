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

# plot 1
plot1 <- function() {
  hist(
    Global_active_power, 
    xlab = "Global Active power (kilowatts)", 
    ylab = "Frequency",
    main = "Global Active Power",
    col = "red"
  )
}

plot1()

# plot 2
plot2 <- function() {
  plot(
    Global_active_power ~ DateTime,
    type = "l",
    xlab = "",
    ylab = "Global Active power (kilowatts)"
  )
}

plot2()

# plot 3
plot3 <- function() {
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
}

plot3()

# plot 4
plot4 <- function() {
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
}

plot4()
