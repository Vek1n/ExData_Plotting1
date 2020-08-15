# Packages used 
#######################
                      #
library(data.table)   #
library(dplyr)        #
library(lubridate)    #
                      #
#######################

# fread function from data.table con read much faster than read.csv/read.table

energy <- fread(file = "exploratory/assignment1/household_power_consumption.txt",
                na.strings = "?") # telling fread that missings symbols are "?"

sapply(energy,class) # checking the classes of each column


# All columns are in the right class except for the Date and Time columns


energy <- energy %>% 
  filter(Date=="1/2/2007"|Date=="2/2/2007") %>% # filtering to the wanted data
  mutate(Date=dmy(Date),Time=hms(Time)) %>%     # transforming to the correct class
  mutate(datetime=Date+Time)

# Creating the plot 4
png(filename = "plot4.png")

par(mfrow=c(2,2)) # fixing that I want 4 graphics in the View window

# 1
with(energy,plot(datetime,Global_active_power,type="l",xlab = ""))
# 2
with(energy,plot(datetime,Voltage,type="l"))
#3
with(energy,plot(datetime,Sub_metering_1,type="n",xlab = "",ylab = "Energy sub metering"))
with(energy,lines(datetime,Sub_metering_1))
with(energy,lines(datetime,Sub_metering_2,col="red"))
with(energy,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# 4
with(energy,plot(datetime,Global_reactive_power,type="l"))

dev.off()
