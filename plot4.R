#reading the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merging the two datasets
NEISCC <- merge(NEI, SCC, by="SCC")

#subsetting the coal combustion related sources values
coal <- grepl("coal", NEISCC$Short.Name, ignore.case = TRUE)
coal <- subset(NEISCC, coal)

#creating an aggregate dataset from the coal combustion dataset
coal <- aggregate(Emissions~year, coal, sum)

#creating a png device
png(filename = "plot4.png")

#plotting the data using base plotting system via barplot
barplot(
    height = coal$Emissions/10^5,
    names.arg = coal$year,
    xlab = "year",
    ylab = expression('total PM'[2.5]),
    main = expression ('total PM'[2.5]*' across each year from coal combustion sources')
)

#closing the device
dev.off()