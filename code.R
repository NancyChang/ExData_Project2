# code for plot1
# download zip file and unzip the files into working directory
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
list.files(unzip(temp,exdir=".",overwrite=TRUE))
unlink(temp)
# check if the files exist and read the files into R
if (file.exists('./summarySCC_PM25.rds')) { 
    NEI <- readRDS("summarySCC_PM25.rds")
} 
if (file.exists('./Source_Classification_Code.rds')) { 
    SCC <- readRDS("Source_Classification_Code.rds")
} 
# extract scc string about "coal combustion-related sources" from Source Classification Code Table and 
# trace back the PM2.5 Emissions information by these scc strings
library(ggplot2)
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
NEI_baltimore$area <- "Baltimore"
NEI_losAngeles <- subset(NEI, NEI$fips == "06037")
NEI_losAngeles$area <- "Los Angeles"
NEI_two <- merge(NEI_losAngeles, NEI_baltimore, all=TRUE)
SCC_motor<-  SCC[ with(SCC, grepl("[Mm]otor", Short.Name)),]
NEI_two_motor <- subset(NEI_two,NEI_two$SCC %in% SCC_motor$SCC)
# plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot6.png',width=480,height=480,units='px') 
plot <- ggplot(NEI_two_motor,aes(year,log(Emissions)))
plot + geom_point(aes(color=area),size=2) + geom_smooth(aes(color=area),method="lm")+labs(title="Comparing emissions from motor vehicle 
sources in Baltimore & Los Angeles", size=6) +labs(x = "Year", y = expression("log"*PM[2.5]))
dev.off()

# code for plot2
#read file from working directory
NEI <- readRDS("summarySCC_PM25.rds")
#extract data only in Baltimore and make the table for plot2
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
table_2 <- tapply(NEI_baltimore$Emission, NEI_baltimore$year, sum)
#plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot2.png',width=480,height=480,units='px') 
barplot(table_2, main="Total PM2.5 Emission in Baltimore during 1999 ~ 2008", xlab="Year", ylab="Total PM2.5 emission", col="blue")
dev.off()

# code for plot3
library(ggplot2)
# read files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# extract data only in Baltimore and make the table for plot3 using ggplot2
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
# remove NA and infinite elements in the data frame
NEI_baltimore$logEmission<- na.omit(log(NEI_baltimore$Emissions))
NEI_baltimore$logEmission<- log(NEI_baltimore$Emissions)
# remove NA/NaN/Inf in 'y'axis for plotting
NEI_baltimore$logEmission[!is.finite(NEI_baltimore$logEmission)] <- 0
# plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot3.png',width=480,height=480,units='px') 
plot <- ggplot(NEI_baltimore,aes(year,logEmission))
plot + geom_point(aes(color=type),size=2) + geom_smooth(aes(color=type),method="lm")+labs(title="Comparing Emissions from Four Type 
Sources in Baltimore City", size=6) +labs(x = "Year", y = expression("log"*PM[2.5]))
dev.off()

# code for plot4
#read files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# extract scc string about "coal combustion-related sources" from Source Classification Code Table and 
# trace back the PM2.5 Emissions information by these scc strings
SCC_coal<-  SCC[ with(SCC, grepl("[Cc]oal", Short.Name)),]
NEI_coal <- subset(NEI,NEI$SCC %in% SCC_coal$SCC)
table_4 <- tapply(NEI_coal$Emission, NEI_coal$year, sum)
# plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot4.png',width=480,height=480,units='px') 
barplot(table_4, main="Emissions from coal sources during 1999 ~ 2008", xlab="Year", ylab="Emissions from coal sources", col="green")
dev.off()

# code for plot5
#read files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#extract scc string about "motor vehicle sources" from Source Classification Code Table and 
#trace back the PM2.5 Emissions information from summarySCC_PM25 by the scc strings
SCC_motor<-  SCC[ with(SCC, grepl("[Mm]otor", Short.Name)),]
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
NEI_MA_motor <- subset(NEI_baltimore,NEI_baltimore$SCC %in% SCC_motor$SCC)
table_5 <- tapply(NEI_MA_motor$Emission, NEI_MA_motor$year, sum)
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot5.png',width=480,height=480,units='px') 
barplot(table_5, main="Emissions from Motor Vehicle in Baltimore during 1999 ~ 2008", xlab="Year", ylab="Emissions from Motor Vehicle", col="yellow")
dev.off()

# code for plot6
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
NEI_baltimore$area <- "Baltimore"
NEI_losAngeles <- subset(NEI, NEI$fips == "06037")
NEI_losAngeles$area <- "Los Angeles"
NEI_two <- merge(NEI_losAngeles, NEI_baltimore, all=TRUE)
SCC_motor<-  SCC[ with(SCC, grepl("[Mm]otor", Short.Name)),]
NEI_two_motor <- subset(NEI_two,NEI_two$SCC %in% SCC_motor$SCC)
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot6.png',width=480,height=480,units='px') 
plot <- ggplot(NEI_two_motor,aes(year,log(Emissions)))
plot + geom_point(aes(color=area),size=2) + geom_smooth(aes(color=area),method="lm")+labs(title="Comparing emissions from motor vehicle 
sources in Baltimore & Los Angeles", size=6) +labs(x = "Year", y = expression("log"*PM[2.5]))
dev.off()
