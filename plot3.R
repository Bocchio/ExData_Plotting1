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
library(datasets)
# Set the output to the png device
png(filename="plot3.png")
# Make a vector datetime that has the date and hour in it
datetime = paste(data_table$Date, data_table$Time)
# Make the background transparent
par(bg="transparent")
# Plot the data
plot(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
lines(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_1)
lines(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_2, col="red")
lines(strptime(datetime, "%d/%m/%Y %H:%M:%S"), data_table$Sub_metering_3,  col="blue")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
# Close the png device
dev.off()