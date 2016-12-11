
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
> ## Plot 1 - Show the total pm2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008
> 
> 
> 
> png('plot1.png')
> TE <- summarise(group_by(NEI, year), Emissions=sum(Emissions))
> x1 <- barplot(height=TE$Emissions/1000, names.arg=TE$year, xlab="Years", ylab="Total  Emissions", ylim=c(0,8000), main="Total PM2.5 Emisions for 1999, 2002, 2005, and 2008")
> dev.off()
null device 
          1 
> 
