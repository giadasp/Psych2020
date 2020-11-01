data <- read.table("estPoolwithSEs.csv",sep = ";",header = TRUE)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2)
library(hrbrthemes)
library(extrafont)
extrafont::loadfonts()
library(viridis)
data$b <- -data$a*data$b
long <- melt(data[c("ID","a","b")])

long %>%
  ggplot(aes(x=variable, y=value)) +
  geom_boxplot(outlier.size = 1) +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11),
  ) +
  scale_x_discrete(labels=c("discrimination","difficulty"))+
  ggtitle("") +
  xlab("") +
  ylab("")


sum(data$b==0)
min(data$b)
max(data$b)
mean(data$b)
median(data$b)

