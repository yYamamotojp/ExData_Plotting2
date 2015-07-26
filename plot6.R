if (!(exists("NEI") && nrow(NEI) == 6497651)) { 
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!(exists("SCC") && nrow(SCC) == 11717)) { 
  SCC <- readRDS("Source_Classification_Code.rds")
}

data <- subset(NEI, type == 'ON-ROAD')
data$year <- factor(data$year, levels=c('1999', '2002', '2005', '2008'))

MD <- subset(data, fips == '24510')
CA <- subset(data, fips == '06037')

MD <- aggregate(MD[, 'Emissions'], by=list(MD$year), sum)
colnames(MD) <- c('year', 'Emissions')
MD$City <- paste(rep('MD', 4))

CA <- aggregate(CA[, 'Emissions'], by=list(CA$year), sum)
colnames(CA) <- c('year', 'Emissions')
CA$City <- paste(rep('CA', 4))

data <- as.data.frame(rbind(MD, CA))

png('plot6.png')

require(ggplot2)

ggplot(data=data, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year), stat="identity") + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
dev.off()