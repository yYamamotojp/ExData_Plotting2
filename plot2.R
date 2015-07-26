if (!(exists("NEI") && nrow(NEI) == 6497651)) { 
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!(exists("SCC") && nrow(SCC) == 11717)) { 
  SCC <- readRDS("Source_Classification_Code.rds")
}


data <- subset(NEI, fips=='24510')

png(filename='plot2.png')
barplot(tapply(X=MD$Emissions, INDEX=data$year, FUN=sum), 
        main='Total Emission in Baltimore City, Maryland', xlab='Year', ylab=expression('PM'[2.5]))
dev.off()
