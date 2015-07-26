if (!(exists("NEI") && nrow(NEI) == 6497651)) { 
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!(exists("SCC") && nrow(SCC) == 11717)) { 
  SCC <- readRDS("Source_Classification_Code.rds")
}

data <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
data$year <- factor(data$year, levels=c('1999', '2002', '2005', '2008'))

MD <- aggregate(data[, 'Emissions'], by=list(data$year), sum)
colnames(MD) <- c('year', 'Emissions')

png('plot5.png')

require(ggplot2)

ggplot(data=MD, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year), stat="identity") + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))
dev.off()