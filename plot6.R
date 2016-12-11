
R version 3.3.1 (2016-06-21) -- "Bug in Your Hair"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> ## Plot 6 - Does Los Angeles County, California or Baltimore City, Maryland seen the greter changes over time in motor vichle emissions?
> 
> ## downloaded and unzipped necessary file
>  if(!file.exists("./data")){dir.create("./data")}
>  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
>  download.file(fileUrl,destfile="./data/Pollution.zip",method="auto")
trying URL 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
Content type 'application/zip' length 30643310 bytes (29.2 MB)
downloaded 29.2 MB

>  unzip(zipfile="./data/Pollution.zip",exdir="./data")
> 
> ## Set working Directory
> setwd("~/data/")
> 
> ## Read Data
> NEI <- readRDS("summarySCC_PM25.rds")
> SCC <- readRDS("Source_Classification_Code.rds")
> 
> ## Extract Year
> Emissions <- summary(NEI$Emissions, year)
> 
> ## Load Library - DPLYR
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> 
> ## Load Library - ggplot2
> library(ggplot2)
Warning message:
package ‘ggplot2’ was built under R version 3.3.2 
> 
> Baltimore <- summarise(group_by(filter(NEI, fips == "24510" & type == "ON-ROAD"), year), Emissions=sum(Emissions))
> 
> LosAngeles <- summarise(group_by(filter(NEI, fips == "06037" & type == "ON-ROAD"), year), Emissions=sum(Emissions))
> 
> Baltimore$County <- "Baltimore City, Maryland"
> 
> LosAngeles$County <- "Los Angeles County, California"
> 
> Combinedemissions <- rbind(Baltimore, LosAngeles)
> 
> png('plot6.png')
> 
> ggplot(Combinedemissions, aes(x=factor(year), y=Emissions, fill=County, label = round(Emissions,2))) + geom_bar(stat="identity") + facet_grid(County~., scales="free") + xlab("Year") + ylab("Total Emissions") + geom_label(aes(fill=County), colour = "white", label.size = 1.25) + geom_text(check_overlap = TRUE) + ggtitle("Motor Vehicle Emission Changes in Baltimore City, Maryland and Los Angeles County, California")
> 
> dev.off()
null device 
          1 
> 
> 
