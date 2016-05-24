##Reference on how to download the data source files
##download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "hw4o4.zip",method="curl")
##zipfile4o4="hw4o4.zip"
##unzip(zipfile4o4,exdir=getwd())

## Read the Data Source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data for fips == "24510"
subset24510<-subset(NEI,NEI$fips=="24510")

##Sum up all the PM25 emission for those years
totEmission24510<-tapply(subset24510$Emissions,subset24510$year,sum)

#Create the png file
png(filename = "plot2.png",width = 480,height=480)

#Create the plot on the png file
plot(totEmission24510,type="l",col="blue",xlab = "Year",ylab="Emissions",main="Annually Emissions in Baltimore City")

#Shut down the png device
dev.off()
