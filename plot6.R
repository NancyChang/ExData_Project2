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
library(ggplot2)
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
NEI_baltimore$area <- "Baltimore"
NEI_losAngeles <- subset(NEI, NEI$fips == "06037")
NEI_losAngeles$area <- "Los Angeles"
NEI_two <- merge(NEI_losAngeles, NEI_baltimore, all=TRUE)
SCC_motor<-  SCC[ with(SCC, grepl("[Mm]otor", Short.Name)),]
NEI_two_motor <- subset(NEI_two,NEI_two$SCC %in% SCC_motor$SCC)

#plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot6.png',width=480,height=480,units='px') 
plot <- ggplot(NEI_two_motor,aes(year,log(Emissions)))
plot + geom_point(aes(color=area),size=2) + geom_smooth(aes(color=area),method="lm")+labs(title="Comparing emissions from motor vehicle 
sources in Baltimore & Los Angeles", size=6) +labs(x = "Year", y = expression("log"*PM[2.5]))
dev.off()

