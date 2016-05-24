##Reference on how to download the data source files
##download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "hw4o4.zip",method="curl")
##zipfile4o4="hw4o4.zip"
##unzip(zipfile4o4,exdir=getwd())

## Read the Data Source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data from the year of 1999 / 2002 / 2005 / 2008 
subsetdata1<-subset(NEI,NEI$year==1999 | NEI$year==2002 | NEI$year==2005 | NEI$year==2008)

##Sum up all the PM25 emission for those years
totEmission<-tapply(subsetdata1$Emissions,subsetdata1$year,sum)

#Create the png file
png(filename = "plot1.png",width = 480,height=480)

#Create the plot on the png file
plot(totEmission,type="l",col="red",xlab = "Year",ylab="Emissions",main="Total Annual Emissions")

#Shut down the png device
dev.off()
