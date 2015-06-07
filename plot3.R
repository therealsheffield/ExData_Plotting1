#------------------------------------------------------------------------------
# Read power data and create a plot energy sub metering 1, 2, and 3 on the y 
# axis, with time on the x axis. Plot is saved in the file 'plot3.png' in the 
# current directory. Expects data from the file household_power_consumption.txt 
# from the UCI machine learning repository.
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

# Plot energy sub metering
png('plot3.png', width=480, height=480)

# Plot sub metering 1 vs. time 
plot(hpcdata[,'Stamp'], 
     hpcdata[,'Sub_metering_1'],
     ylab='Energy sub metering', 
     xlab="",
     type='l', 
     col='black')

# Add line for sub metering 2
lines(x=hpcdata[,'Stamp'], y=hpcdata[,'Sub_metering_2'], col='red')

# Add line for sub metering 3
lines(x=hpcdata[,'Stamp'], y=hpcdata[,'Sub_metering_3'], col='blue')

# Add legend
legend("topright", 
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
       col=c('black','red','blue'), 
       lwd = 1)

dev.off()