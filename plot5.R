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

## Subset the data for fips == "24510" and type == "ON-ROAD"
subsetOnRoad<-NEI[(NEI$type=="ON-ROAD" & NEI$fips=="24510"),]

##Sum up all the emission by type for those years
NEIforMotorEmissions<-ddply(subsetOnRoad, c("year"), function(data) sum(data$Emissions))

##Name the third column (Sum) which is the sum of Emission
colnames(NEIforMotorEmissions)[2]<-"Emissions"

##Create the png file
png(filename = "plot5.png",width = 480,height=480)

##Create the ggplot on the png file
ggplot(NEIforMotorEmissions, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("Emissions")) +
  ggtitle("Motor Vehicle Emissions in Baltimore City")

##Shut down the device
dev.off()
