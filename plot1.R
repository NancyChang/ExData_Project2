#download zip file and unzip the files into working directory
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp)
list.files(unzip(temp,exdir=".",overwrite=TRUE))
unlink(temp)

#check if the file exist and read the file into R
if (file.exists('./summarySCC_PM25.rds')) { 
    NEI <- readRDS("summarySCC_PM25.rds")
} 

#extract and reshape data to make a table for plot1
table_1 <- tapply(NEI$Emission, NEI$year, sum)

#plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot1.png',width=480,height=480,units='px') 
barplot(table_1, main="Total PM2.5 Emission during 1999 ~ 2008", xlab="Year", ylab="Total PM2.5 emission", col="red")
dev.off()

