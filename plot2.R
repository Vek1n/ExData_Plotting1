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

# Creating the plot 2


png(filename = "plot2.png")
with(energy,plot(datetime,Global_active_power,type="l",xlab = ""))
dev.off()

# The x-axis marks are written in portuguese because I was uncapable of changing it to english
# I tried a lot of things and none of them have worked so, i left it in that way
# I really would appreciate a tip or anything
