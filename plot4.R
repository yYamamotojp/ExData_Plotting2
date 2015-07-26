if (!(exists("NEI") && nrow(NEI) == 6497651)) { 
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!(exists("SCC") && nrow(SCC) == 11717)) { 
  SCC <- readRDS("Source_Classification_Code.rds")
}

SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

data <- merge(x=NEI, y=SCC.coal, by='SCC')
data.sum <- aggregate(data[, 'Emissions'], by=list(data$year), sum)
colnames(data.sum) <- c('Year', 'Emissions')

png(filename='plot4.png')

require(ggplot2)

ggplot(data=data.sum, aes(x=Year, y=Emissions/1000)) + 
  geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
  ggtitle(expression(paste('Total Emissions of ', 'PM'[2.5],' from coal combustion-related sources'))) + 
  ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
  geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
  theme(legend.position='none') + scale_colour_gradient(low='black', high='red')
dev.off()