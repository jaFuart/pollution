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

## Plot #5
scc_id2 <- as.character(SCC[grep("On-Road",SCC$EI.Sector),1])

Baltimore2 <- subset(NEI, NEI$SCC %in% scc_id2 & NEI$fips == "24510")

auto_by_year <- tapply(Baltimore2$Emissions, Baltimore2$year, sum)

setwd('../')

options(scipen=999)

png("plot5.png")
plot(names(auto_by_year),auto_by_year, type = "l", xlab = "Year", 
     ylab =expression(PM[2.5] ~ "Emissions (Tons)"), 
     main = expression("Total Baltimore" ~ PM[2.5] ~ " Auto Emissions by Year"), lwd=5)
dev.off()
