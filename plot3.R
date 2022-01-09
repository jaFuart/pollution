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

## Plot #3
Baltype <- subset(NEI, fips =="24510")

balimore_by_type <- aggregate(Baltype$Emissions, list(Baltype$type, Baltype$year),sum)
names(balimore_by_type) <- c("Type","Year","Emissions")

setwd('../')

png("plot3.png")
qplot(Year,Emissions/1000, data = balimore_by_type, color = Type)+ geom_line(lwd=1.5) + ggtitle(expression("Baltimore" ~ PM[2.5] ~ "Emissions by Type and Year")) +
    xlab("Year") + ylab(expression(PM[2.5] ~ "Emissions (Per 1K Tons)")) + theme(plot.title = element_text(hjust = .5))
dev.off()
