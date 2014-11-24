library(dplyr)
library(ggplot2)

nei<-readRDS("summarySCC_PM25.rds")
scc<-readRDS("Source_Classification_Code.rds")

coalscc<-scc%>%
  filter(grepl("Coal", Short.Name), grepl("Comb", EI.Sector))%>%
  select(SCC)

nei %>%
  filter(SCC %in% coalscc$SCC)%>%
  group_by(year)%>%
  summarise(total=sum(Emissions)) %>%
  ggplot(aes(year, total)) + geom_line() + ggtitle("Emissions from Coal Combustion-related Sources \n in the United States from 1999-2008") + theme(plot.title=element_text(size=12, face="bold", colour = "red")) + xlab("Year") + ylab(expression("Total Emissions from" * PM[2.5]))

dev.copy(png, "plot4.png")
dev.off()