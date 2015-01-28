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
#extract data only in Baltimore and make the table for plot2
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
table_2 <- tapply(NEI_baltimore$Emission, NEI_baltimore$year, sum)

#plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot2.png',width=480,height=480,units='px') 
barplot(table_2, main="Total PM2.5 Emission in Baltimore during 1999 ~ 2008", xlab="Year", ylab="Total PM2.5 emission", col="blue")
dev.off()

