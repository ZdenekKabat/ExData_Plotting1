### This R code downloads, extracts and reads source data into R, transforms and
### filters the table and creates a single plot with an output to PNG file

# download and extract the source data

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "./exdata-data-household_power_consumption.zip")
unzip("./exdata-data-household_power_consumption.zip")

# reads data into R, creates a transformed dataset for plotting

data_full0 <- 
     read.table("./household_power_consumption.txt", header = TRUE, sep = ";")

data_full <- data_full0
data_full$Date <- as.Date(data_full$Date, "%d/%m/%Y")

data <- data_full[data_full$Date >= as.Date("01/02/2007", "%d/%m/%Y") & 
                       data_full$Date <= as.Date("02/02/2007", "%d/%m/%Y"),]

# rm(data_full, data_full0)

data$timestamp <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %T")

for (i in 3:9) {
     data[,i] <- as.numeric(as.character(data[,i]))
}

# creates a plot with PNG output

png(file = "plot3.png")
with(data, plot(timestamp, Sub_metering_1, type = "l", xlab = "",
                ylab = "Energy sub metering"))
with(data, lines(timestamp, Sub_metering_2, col = "red"))
with(data, lines(timestamp, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

dev.off()