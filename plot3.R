library(ggplot2)

#reading the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting the Baltimore data
Baltimore <- subset(NEI, fips=="24510")

#aggregating the Baltimore data by sum of Emissions each year for each type
Pm25 <- aggregate(Emissions ~ year + type, Baltimore, sum)

#creating a png device
png(filename="plot3.png")

#plotting using ggplot
g <- ggplot(Pm25,aes(year,Emissions,group=1))

#creating a linear model to determine whether the values are increasing or decreasing
g <- g + facet_grid(.~type) + geom_point() + geom_smooth(method="lm")
print(g)

#closing the device
dev.off()


