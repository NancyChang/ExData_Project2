#download zip file and unzip the files into working directory
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
list.files(unzip(temp,exdir=".",overwrite=TRUE))
unlink(temp)
#check if the files exist and read the files into R
if (file.exists('./summarySCC_PM25.rds')) { 
    NEI <- readRDS("summarySCC_PM25.rds")
} 
if (file.exists('./Source_Classification_Code.rds')) { 
    SCC <- readRDS("Source_Classification_Code.rds")
} 
#extract scc string about "coal combustion-related sources" from Source Classification Code Table and 
#trace back the PM2.5 Emissions information by these scc strings
SCC_coal<-  SCC[ with(SCC, grepl("[Cc]oal", Short.Name)),]
NEI_coal <- subset(NEI,NEI$SCC %in% SCC_coal$SCC)
table_4 <- tapply(NEI_coal$Emission, NEI_coal$year, sum)

#plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot4.png',width=480,height=480,units='px') 
barplot(table_4, main="Emissions from coal sources during 1999 ~ 2008", xlab="Year", ylab="Emissions from coal sources", col="green")
dev.off()

