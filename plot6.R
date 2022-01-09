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

## Plot #6
scc_id3 <- as.character(SCC[grep("On-Road",SCC$EI.Sector),1])

BaltLA <- subset(NEI, NEI$SCC %in% scc_id3 & NEI$fips %in% c("24510","06037"))

comp_by_year <- aggregate(Emissions ~ fips+year,BaltLA,sum)
comp_by_year$fips <- ifelse(comp_by_year$fips == "06037", "Los Angeles","Baltimore")
names(comp_by_year) <- c("City","Year","Emissions")

setwd('../')

options(scipen=999)

png("plot6.png")
qplot(Year,Emissions/1000, data = comp_by_year, color = City)+ geom_line(lwd=1.5) + ggtitle(expression("Baltimore and LA" ~ PM[2.5] ~ "Emissions by Year")) +
    xlab("Year") + ylab(expression(PM[2.5] ~ "Emissions (Per 1K Tons)")) + theme(plot.title = element_text(hjust = .5))
dev.off()