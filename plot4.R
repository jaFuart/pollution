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

## Plot #4
# total_by_year <- tapply(NEI$Emissions, NEI$year, sum)
scc_id <- as.character(SCC[grep("Coal",SCC$Short.Name, ignore.case = TRUE),1])
#Combine the data sets
coaldata <- subset(NEI, NEI$SCC %in% scc_id)


# Subset the coal data
coal <- tapply(coaldata$Emissions, coaldata$year, sum)

setwd('../')

options(scipen=999)

png("plot4.png")
plot(names(coal),total_by_year/1000, type = "l", xlab = "Year", 
     ylab =expression(PM[2.5] ~ "Emissions (Per 1K Tons)"), 
     main = expression("Total Coal Combustion" ~ PM[2.5] ~ "Emissions by Year"), lwd=5)
dev.off()
