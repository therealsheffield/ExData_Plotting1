#------------------------------------------------------------------------------
# Read power data and plot global active power on the y axis, with time on the 
# x axis. Plot is saved in the file 'plot2.png' in the current directory. 
# Expects data from the file household_power_consumption.txt from the UCI 
# machine learning repository.
#
# Author: therealsheffield
#------------------------------------------------------------------------------

# Set column types and names for reading data
coltypes <- c('character', 
              'character', 
              'numeric', 
              'numeric', 
              'numeric', 
              'numeric', 
              'numeric', 
              'numeric', 
              'numeric')
colnames <- c('Date', 
              'Time', 
              'Global_active_power', 
              'Global_reactive_power', 
              'Voltage', 
              'Global_intensity', 
              'Sub_metering_1', 
              'Sub_metering_2', 
              'Sub_metering_3')

# Read data (only lines with data for 2007/2/1 and 2007/2/2 are read)
hpcdata <- read.csv('household_power_consumption.txt', 
                    header=TRUE, 
                    sep=';',
                    col.names=colnames,
                    na.strings='?',
                    colClasses=coltypes, 
                    skip=66636, 
                    nrows=2880)

# Convert date and time strings to dates and add to new column 'Stamp'
sformat <- '%d/%m/%Y %T'
hpcdata$'Stamp' <- strptime(paste(hpcdata$'Date',hpcdata$'Time', sep=' '), format=sformat)

# Plot global active power
png('plot2.png', width=480, height=480)
plot(hpcdata[,'Stamp'], 
     hpcdata[,'Global_active_power'],
     ylab='Global Active Power (kilowatts)',  
     xlab="",
     type='l')
dev.off()