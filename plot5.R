library(dplyr)
library(ggplot2)

nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

vehiclescc<-scc %>%
  filter(grepl("Vehicles", scc$EI.Sector)) %>%
  select(SCC)

nei %>%
  filter(SCC %in% vehiclescc$SCC, fips=='24510')%>%
  group_by(year)%>%
  summarise(total=sum(Emissions)) %>%
  ggplot(aes(year, total)) + geom_line() + ggtitle("Emissions from Motor Vehicle Sources \n in Baltimore from 1999-2008") + theme(plot.title=element_text(size=12, face="bold", colour = "red")) + xlab("Year") + ylab(expression("Total Emissions from" * PM[2.5]))

dev.copy(png, "plot5.png")
dev.off()