#------------------------------------------------------------------------------
# Read power data and plot histogram of global active power. Plot is saved in 
# the file 'plot1.png' in the current directory. Expects data from the file 
# household_power_consumption.txt from the UCI machine learning repository.
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

# Plot histogram of global active power with default bins
png('plot1.png', width=480, height=480)
hist(hpcdata[,'Global_active_power'], 
     col='red',  
     main='Global Active Power', 
     xlab='Global Active Power (kilowatts)')
dev.off()