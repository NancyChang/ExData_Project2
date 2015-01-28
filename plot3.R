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
#extract data only in Baltimore and make the table for plot3 using ggplot2
library(ggplot2)
NEI_baltimore <- subset(NEI, NEI$fips == "24510")
#remove NA and infinite elements in the data frame
NEI_baltimore$logEmission<- na.omit(log(NEI_baltimore$Emissions))
NEI_baltimore$logEmission<- log(NEI_baltimore$Emissions)
#remove NA/NaN/Inf in 'y'axis for plotting
NEI_baltimore$logEmission[!is.finite(NEI_baltimore$logEmission)] <- 0

#plot the bar chart and save as png file
par(mar=c(4,4,4,4))
png(filename='project2_plots/plot3.png',width=480,height=480,units='px') 
plot <- ggplot(NEI_baltimore,aes(year,logEmission))
plot + geom_point(aes(color=type),size=2) + geom_smooth(aes(color=type),method="lm")+labs(title="Comparing Emissions from Four Type 
Sources in Baltimore City", size=6) +labs(x = "Year", y = expression("log"*PM[2.5]))
dev.off()

