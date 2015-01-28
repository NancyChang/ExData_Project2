NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#extract scc string about "motor vehicle sources" from Source Classification Code Table and 
#trace back the PM2.5 Emissions information from summarySCC_PM25 by the scc strings
SCC_motor<-  SCC[ with(SCC, grepl("[Mm]otor", Short.Name)),]
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
NEI_MA_motor <- subset(NEI_baltimore,NEI_baltimore$SCC %in% SCC_motor$SCC)
table_5 <- tapply(NEI_MA_motor$Emission, NEI_MA_motor$year, sum)

#plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot5.png',width=480,height=480,units='px') 
barplot(table_5, main="Emissions from Motor Vehicle in Baltimore during 1999 ~ 2008", xlab="Year", ylab="Emissions from Motor Vehicle", col="yellow")
dev.off()

