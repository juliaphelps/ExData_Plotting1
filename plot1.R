

## This script was written on a Windows 8 machine using RStudio v3.2.2.
## Function:  'construct_plot1()'
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
## 'construct_plot1()', which is designed to automate the process of:
##   - downloading and unzipping a specific set of data (if necessary),
##   - reading in the section of the data that corresponds to the dates 2007-02-01 and 2007-02-02,
##   - creating a histogram of the 'Global_active_power' variable,
##   - and saving this histogram into the working directory as 'plot1.png'.
##
## While other plots in this series make use of the png() argument 'type="cairo"' to create antialiasing,
## it was excluded from this plot to make it more "crisp" and readable.
##
## Note:  This script is designed to work in conjunction with plot2.R, plot3.R, and plot4.R by the same
## author.  If you have already downloaded the data set using one of those scripts, it will not be
## downloaded again, so long as your working directory stays the same.  The size of the downloaded data
## will be approximately 130KB, and will be placed in a directory called "UCIData".  To load in the
## necessary section of the data, R/RStudio will require approximately 273KB of memory.


## To use plot1.R, simply download this file into your working directory, source it, and execute the
## command 'construct_plot1()'.  The script will do the rest!




construct_plot1 <- function(){
    
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
    
    ## Set default global graphical parameters and create plot into png file device
    png(file="plot1.png", width=480, height=480, bg="transparent")
    par(mfrow=c(1,1), mar=c(5.1, 4.1, 4.1, 2.1))
    hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", 
         col="red")
    dev.off()
    
    message("Output is located in working directory: 'plot1.png'")
}