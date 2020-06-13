#reading the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merging the two datasets
NEISCC <- merge(NEI, SCC, by="SCC")

#subsetting the Baltimore data
Baltimore <- subset(NEISCC, fips=="24510")

#subsetting the motor vehice sources values
mv <- grepl("vehicle", Baltimore$SCC.Level.Two, ignore.case = TRUE)
mv <- subset(Baltimore, mv)

#creating an aggregate dataset from the motor vehicle dataset
mv <- aggregate(Emissions~year, mv, sum)

#creating a png device
png(filename = "plot5.png")

#plotting the data using base plotting system via barplot
barplot(
    height = mv$Emissions,
    names.arg = mv$year,
    xlab = "year",
    ylab = expression('total PM'[2.5]),
    main = expression ('total PM'[2.5]*' across each year from motor vehicle sources in Baltimore')
)

#closing the device
dev.off()