library(dplyr)

nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

opar<-par()
par(oma=c(0,1,0,0))
nei %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(total=sum(Emissions)) %>%
  plot(total ~ year, . , type="b", col="blue",  main=expression("Total Emissions from " * PM[2.5]*" in the United States from 1999-2008"), xlab="Year", 
       ylab="Total Emissions", cex.main=0.9, cex.lab=0.8, cex.axis=0.8)

dev.copy(png, "plot1.png")
dev.off()
par(opar)