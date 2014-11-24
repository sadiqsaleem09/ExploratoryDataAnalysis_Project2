library(dplyr)
library(ggplot2)

nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

nei %>%
  filter(fips=='24510') %>%
  group_by(year, type) %>%
  summarise(total=sum(Emissions)) %>%
  ggplot(aes(year, total, colour=type))+geom_line() + ggtitle("Total Emissions in Baltimore from 1999-2008 based on Source Type") + theme(plot.title=element_text(size=12, face="bold")) + xlab("Year") + ylab(expression("Total Emissions from" * PM[2.5]))+scale_color_discrete(name="Source Type")

dev.copy(png, "plot3.png")
dev.off()