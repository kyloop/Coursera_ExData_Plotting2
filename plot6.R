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

## Subset the data Motor source of Baltimore City for fips == "24510" and type == "ON-ROAD"
Bmore_subsetOnRoad<-NEI[(NEI$type=="ON-ROAD" & NEI$fips=="24510"),]

## Subset the data Motor source of Los Angeles County for fips == "06037" and type == "ON-ROAD"
LA_subsetOnRoad<-NEI[(NEI$type=="ON-ROAD" & NEI$fips=="06037"),]


##Sum up all the emission by type for those years
Bmore_MotorEmissions<-ddply(Bmore_subsetOnRoad, c("year"), function(data) sum(data$Emissions))
LA_MotorEmissions<-ddply(LA_subsetOnRoad, c("year"), function(data) sum(data$Emissions))


##Name the third column (Sum) which is the sum of Emission
colnames(Bmore_MotorEmissions)[2]<-"Emissions"
colnames(LA_MotorEmissions)[2]<-"Emissions"

##Assign one column to label the City names
Bmore_MotorEmissions$city<-"Baltimore"
LA_MotorEmissions$city<-"Los Angeles"


##Combine the Motor source data into one data frame
Combine_MotorEmissions<-rbind(Bmore_MotorEmissions,LA_MotorEmissions)


##Create the png file
png(filename = "plot6.png",width = 480,height=480)


##Create the ggplot on the png file
ggplot(Combine_MotorEmissions, aes(fill=city,x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  facet_grid(city~.,scales = "free")+  ##Split the plot in terms of City with free of limit grids
  xlab("year") +
  ylab(expression("Emissions")) +
  ggtitle("Motor Vehicle Emissions in Baltimore & Los Angeles")

##Shut down the device
dev.off()
