library(dplyr)
library(ggplot2)

nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

vehiclescc<-scc %>%
  filter(grepl("Vehicles", scc$EI.Sector)) %>%
  select(SCC)

plot1<-nei %>%
  filter(fips=='24510' | fips == '06037',SCC %in% vehiclescc$SCC) %>%
  group_by(year, fips) %>%
  summarise(total=sum(Emissions)) %>%
  ggplot(aes(year,total, colour=fips))+geom_line() + ggtitle("Emissions from Motor Vehicle Sources from 1999-2008") + theme(plot.title=element_text(size=12, face="bold", colour = "orange")) + xlab("Year") + ylab(expression("Total Emissions from" * PM[2.5])) + scale_color_discrete(name="Cities", labels=c("Los Angeles", "Baltimore"))

percent_change<-nei %>%
  filter(fips=='24510' | fips == '06037',SCC %in% vehiclescc$SCC) %>%
  group_by(fips,year) %>%
  summarise(total=sum(Emissions))%>%
  mutate(x=-1*(total/lag(total)-1)*100)


plot2<-ggplot(percent_change, aes(x=factor(year),y=x, fill=fips))+
  geom_bar(stat='identity',position='dodge') + 
  scale_fill_discrete(name="Cities", labels=c("Los Angeles", "Baltimore")) + 
  ggtitle("Percent Decrease in Emissions from Motor Vehicle \n Sources from 1999-2008") + 
  theme(plot.title=element_text(size=12, face="bold", colour = "orange")) + 
  xlab("Year") + 
  ylab(expression("Percent Decrease in Total Emissions from" * PM[2.5]))

source("multiplot.R")
png("plot6.png")
multiplot(plot1, plot2, cols=1)
dev.off()