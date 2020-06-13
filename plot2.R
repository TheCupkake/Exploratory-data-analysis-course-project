#reading the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#converting year variable into factor
NEI$year <- as.factor(NEI$year)

#subsetting the Baltimore data
Baltimore <- subset(NEI, fips=="24510")

#aggregating the Baltimore data by sum of Emissions each year
Pm25 <- aggregate(Emissions ~ year, Baltimore, sum)

#creating a png device
png(filename="plot2.png")

#plotting the data using barplot
barplot(
    height = Pm25$Emissions, 
    names.arg = Pm25$year,
    xlab = "years",
    ylab = expression('total PM'[2.5]),
    main = expression('total PM'[2.5]*' across 10 year period in Baltimore')
    )

#closing the device
dev.off()
