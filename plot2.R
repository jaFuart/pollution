##install.packages(c("tidyverse", "knitr", "lemon", "kableExtra"))
library(dplyr)
library(ggplot2)
library(tidyr)
library(lemon)
library(kableExtra)
library(knitr)

currdir <- "./data"
if(!dir.exists("./data")) dir.create("./data")
setwd(currdir)
dburl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zip <- "Data for Peer Assessment.zip"
download.file(dburl, zip)
if(file.exists(zip)) unzip(zip)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Plot #2
Baltimore <- subset(NEI, fips =="24510")

#Grouping  by year
baltimore_by_year <- tapply(Baltimore$Emissions, Baltimore$year, sum)

setwd('../')

options(scipen=999)

png("plot2.png")
plot(names(baltimore_by_year),baltimore_by_year/1000, type = "l", xlab = "Year", 
     ylab =expression(PM[2.5] ~ "Emissions (Per 1K Tons)"), 
     main = expression("Total Baltimore" ~ PM[2.5] ~ "Emissions by Year"), 
     lwd=5)
dev.off()
