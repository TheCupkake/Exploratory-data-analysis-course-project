#reading the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#converting year variable into factor
NEI$year <- as.factor(NEI$year)

#aggregating the data set by sum of emissions each year
Pm25 <- aggregate(Emissions ~ year, NEI, sum)

#creating a png device
png(filename="plot1.png")

#plotting the data using a barplot
barplot(
    height = Pm25$Emissions/10^6, 
    names.arg = Pm25$year,
    xlab = "years",
    ylab = expression('total PM'[2.5]),
    main = expression('total PM'[2.5]*' across 10 year period')
)
#closing the device
dev.off()