##Reference on how to download the data source files
##download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "hw4o4.zip",method="curl")
##zipfile4o4="hw4o4.zip"
##unzip(zipfile4o4,exdir=getwd())

##Call out functions
library(ggplot2)
library(plyr)

## Read the Data Source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data for fips == "24510"
subset24510<-subset(NEI,fips=="24510")

##Sum up all the emission by type for those years
totEmissionbyType2<-ddply(subset24510, c("year","type"), function(data) sum(data$Emissions))

##Name the third column (Sum) which is the sum of Emission
colnames(totEmissionbyType2)[3]<-"Emissions"

##Create the png file
png(filename = "plot3.png",width = 480,height=480)

#Create the plot on the png file
qplot(year,Emissions,data=totEmissionbyType2,geom = c("point","line"),color=type,xlab="Year",ylab = "Emissions",main = "Annual Emissions by Type and Year")

#Shut down the png device
dev.off()
