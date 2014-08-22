# Choose the file that contains the data
FileName <- "household_power_consumption.txt"
# If the file doesn't exist yet, download the archiver and extract that file.
if (!file.exists(FileName)){
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", temp)
    unzip(temp, files=FileName)
    unlink(temp)
}
# Read only the days 01/02/2007 and 02/02/2007 to make the process faster
con <- file(FileName)
open(con)
col_names <- as.character(read.table(con, sep=";", nrow=1, stringsAsFactors=FALSE)[1,])
data_table <- read.table(con, sep=";", stringsAsFactors=FALSE, skip=66638, nrow=2880)
colnames(data_table) <- col_names
close(con)
# Set the output to the png device
png("plot4.png")
# Make a vector datetime that has the date and hour in it
datetime = paste(data_table$Date, data_table$Time)
# Make the background transparent and the plots to align in a 2 by 2 grid
par(mfrow=c(2,2), bg="transparent")
# Plot the data
with(data_table, {
plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
lines(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_1)
lines(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_2, col="red")
lines(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_3,  col="blue")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=.9)
plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Global_reactive_power, ylab="Global_reactive_power", type="l", xlab="datetime")
})
# Close the png device
dev.off()
