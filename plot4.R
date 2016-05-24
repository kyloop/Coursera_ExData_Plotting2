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
subsetCoal<-SCC[grepl("Fuel.+Coal",SCC$EI.Sector),]

## Align the SCC Coal Sector with NEI data
subsetNEIforCoal <- NEI[(NEI$SCC %in% subsetCoal$SCC),]

##Sum up all the emission by type for those years
NEIforCoalEmissions<-ddply(subsetNEIforCoal, c("year"), function(data) sum(data$Emissions))

##Name the third column (Sum) which is the sum of Emission
colnames(NEIforCoalEmissions)[2]<-"Emissions"

##Create the png file
png(filename = "plot4.png",width = 480,height=480)

##Create the plot on the png file
barplot(NEIforCoalEmissions$Emissions,
        xlab="Year",
        ylab = "Emissions",
        main = expression(Total~PM[2.5]~From~Coal~Emissions~Combustion~Sources))
axis(1, at=c(1:4),labels=c("1999", "2002", "2005", "2008"))

##Shut down the png device
dev.off()
