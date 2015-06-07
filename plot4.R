#------------------------------------------------------------------------------
# Read power data and create a 2x2 plot with subplots of global active power, 
# voltage, energy sub metering, and global reactive power. All of these are 
# plotted on the y axis, with time on the x axis. Plot is saved in the file
# 'plot4.png' in the current directory. Expects data from the file 
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

# Convert date and time strings to dates and add to new column 'Stamp'
sformat <- '%d/%m/%Y %T'
hpcdata$'Stamp' <- strptime(paste(hpcdata$'Date',hpcdata$'Time', sep=' '), format=sformat)

# Plot 2x2 grid of plots
png('plot4.png', width=480, height=480)
par(mfrow=c(2,2))

# Plot 1: Global active power vs. time
plot(hpcdata[,'Stamp'], 
     hpcdata[,'Global_active_power'],
     ylab='Global Active Power',  
     xlab="",
     type='l')

# Plot 2: Voltage vs. time
plot(hpcdata[,'Stamp'], 
     hpcdata[,'Voltage'],
     ylab='Voltage',  
     xlab="datetime",
     type='l')

# Plot 3: Energy sub metering vs. time
plot(hpcdata[,'Stamp'], 
     hpcdata[,'Sub_metering_1'],
     ylab='Energy sub metering', 
     xlab="",
     type='l', 
     col='black')
lines(x=hpcdata[,'Stamp'], y=hpcdata[,'Sub_metering_2'], col='red')
lines(x=hpcdata[,'Stamp'], y=hpcdata[,'Sub_metering_3'], col='blue')
legend("topright", 
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), 
       col=c('black','red','blue'), 
       lwd = 1,
       bty='n')

# Plot 4: Global reactive power vs. time
plot(hpcdata[,'Stamp'], 
     hpcdata[,'Global_reactive_power'],
     ylab='Global_reactive_power', 
     xlab="datetime",
     type='l', 
     col='black')
dev.off()