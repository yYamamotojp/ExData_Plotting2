if (!(exists("NEI") && nrow(NEI) == 6497651)) { 
  NEI <- readRDS("summarySCC_PM25.rds")
}

if (!(exists("SCC") && nrow(SCC) == 11717)) { 
  SCC <- readRDS("Source_Classification_Code.rds")
}

data <- subset(NEI, fips == 24510)
data$year <- factor(data$year, levels=c('1999', '2002', '2005', '2008'))

png('plot3.png', width=800, height=500, units='px')


require(ggplot2)

ggplot(data=data, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City, Maryland') +
  geom_jitter(alpha=0.10)
dev.off()