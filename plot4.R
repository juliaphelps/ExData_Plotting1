

## This script was written on a Windows 8 machine using RStudio v3.2.2.
## Function:  'construct_plot4()'
## Author:  Julia Phelps
## Course:  Exploratory Data Analysis, offered through Coursera
##
## Disclaimer:  As this script was written on a Windows 8 machine using RStudio v3.2.2, there is a
## chance that your results may differ in some ways if you use a different operating system or
## version of RStudio.


## About the Data:  
##   - Original dataset is from the Individual household electric power consumption Data Set, available
##     through the UC Irvine Machine Learning Repository (http://archive.ics.uci.edu/ml/)
##   - Dataset contains various measurements of one household's electric power consumption over a
##     period of almost 4 years.  Data is sampled once each minute, 24 hours a day.  More details can be
##     found at the UCI's website.
##   - Data is reproduced at the Coursera:  Exploratory Data Analysis course website, and has been used
##     with permission in this project.


## This script, along with 3 others like it, was constructed to fulfill the requirements of Course
## Project 1 for the Coursera course 'Exploratory Data Analysis'.  The script contains one function,
## 'construct_plot4()', which is designed to automate the process of:
##
##   - downloading and/or loading the 'lubridate' package (if necessary),
##   - downloading and unzipping a specific set of data (if necessary),
##   - reading in the section of the data that corresponds to the dates 2007-02-01 and 2007-02-02,
##   - subsetting the Date, Time, and all three Sub_metering variables and combining as necessary,
##   - using lubridate to reformat Date/Time data,
##   - setting the global graphics parameters to allow for displaying 4 plots on one page by column,
##   - creating plot 1:  a linear plot of the 'Global_active_power' variable by weekday,
##   - creating plot 2:  an overlaying linear plot of the 'Sub_metering_1', 'Sub_metering_2', and
##     'Sub_metering_3' variables by weekday, differentiated by colour,
##   - creating plot 3:  a linear plot of the 'Voltage' variable by weekday,
##   - creating plot 4:  a linear plot of the 'Global_reactive_power' variable by weekday,
##   - annotating each individual plot to include appropriate labels and a legend (if necessary),
##   - and saving this plot into the working directory as 'plot4.png'.
##
## 'construct_plot4()' requires the use of the lubridate package, as detailed above.  If the function
## is unable to load or download/load in the lubridate package, it will error out with a message before
## attempting any additional steps.
##
## Note:  This script is designed to work in conjunction with plot1.R, plot2.R, and plot3.R by the same
## author.  If you have already downloaded the data set using one of those scripts, it will not be
## downloaded again, so long as your working directory stays the same.  The size of the downloaded data
## will be approximately 130KB, and will be placed in a directory called "UCIData".  To load in the
## necessary section of the data, R/RStudio will require approximately 273KB of memory.


## To use plot3.R, simply download this file into your working directory, source it, and execute the
## command 'construct_plot4()'.  The script will do the rest!




construct_plot4 <- function(){
    
    ## Attempt to install and/or load lubridate package
    if(require("lubridate")){
        print("lubridate package is loaded")
    } else {
        print("attempting to install lubridate package")
        install.packages("lubridate")
        if(require("lubridate")){
            print("lubridate package installed and loaded")
        } else {
            stop("Error:  unable to install lubridate package")
        }
    }
    
    ## Look for files and download/unzip if necessary
    if(!file.exists("./UCIData")){dir.create("./UCIData")}
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    if(!file.exists("./UCIData/powerConsumption.zip")){
        download.file(url, destfile = "./UCIData/powerConsumption.zip", mode="wb")}
    if(!file.exists("./UCIData/household_power_consumption.txt")){
        unzip("./UCIData/powerConsumption.zip", exdir = "./UCIData")}
    
    ## Read in data for dates 2007-02-01 and 2007-02-02
    header <- read.table("./UCIData/household_power_consumption.txt", nrows = 1, sep = ";", 
                         colClasses = "character")
    data <- read.table("./UCIData/household_power_consumption.txt", skip=66637, nrows = 2880, sep = ";")
    colnames(data) <- header
    
    ## Subset necessary data
    datesTemp <- paste(data$Date, data$Time, sep=" ")
    dates <- dmy_hms(datesTemp)
    active_power <- data$Global_active_power
    Sub_metering_1 <- data$Sub_metering_1
    Sub_metering_2 <- data$Sub_metering_2
    Sub_metering_3 <- data$Sub_metering_3
    voltage <- data$Voltage
    reactive_power <- data$Global_reactive_power

    ## Set global graphical parameters for 4 plots per page, and create plots into png file device
    png(file="plot4.png", width=480, height=480, bg="transparent", type="cairo")
    par(mfcol=c(2,2), mar=c(5, 4, 4, 2))
    plot(dates, active_power, type="l", lwd=0.75, xlab="", ylab="Global Active Power")
    plot(dates, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(dates, Sub_metering_2, type="l", col="red")
    points(dates, Sub_metering_3, type="l", col="blue")
    legend("topright", lty = 1, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1", 
                                                                        "Sub_metering_2", "Sub_metering_3"))
    plot(dates, voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(dates, reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    dev.off()
    
    message("Output is located in working directory: 'plot4.png'")
}