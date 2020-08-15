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
  mutate(daylong=Date+Time) 

# Creating the plot 1

png(filename = "plot1.png")
with(energy,hist(Global_active_power,col="red",
main="Global Active Power",xlab ="Global Active Power (kilowatts)"))
dev.off()
