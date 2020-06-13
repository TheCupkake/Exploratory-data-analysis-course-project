#reading the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#merging the two datasets
NEISCC <- merge(NEI, SCC, by="SCC")

#subsetting the Baltimore data
Baltimore <- subset(NEISCC, fips=="24510")

#subsetting the LA data
LA <- subset(NEISCC, fips == "06037")

#subsetting the motor vehice sources values in Baltimore
mvb <- grepl("vehicle", Baltimore$SCC.Level.Two, ignore.case = TRUE)
mvb <- subset(Baltimore, mvb)

#subsetting the motor vehice sources values in Baltimore
mvla <- grepl("vehicle", LA$SCC.Level.Two, ignore.case = TRUE)
mvla <- subset(LA, mvla)

#creating an aggregate dataset from the motor vehicle Baltimore dataset 
mvb <- aggregate(Emissions~year, mvb, sum)

#creating an aggregate dataset from the motor vehicle Baltimore dataset 
mvla <- aggregate(Emissions~year,mvla,sum)

#creating a png device
png(filename = "plot6.png")

#specifying number of columns
par(mfrow = c(1,2))

#plotting the Baltimore data in the first column
barplot(
    height = mvb$Emissions,
    names.arg = mvb$year,
    xlab = "year",
    ylab = expression('PM'[2.5]),
    main = expression('PM'[2.5]* ' by motor vehicles in Baltimore')
)

#plotting the LA data in the second column
barplot(
    height = mvla$Emissions,
    names.arg = mvla$year,
    xlab = "year",
    ylab = expression('PM'[2.5]),
    main = expression('PM'[2.5]* ' by motor vehicles in LA')
)

#closing the device
dev.off()
