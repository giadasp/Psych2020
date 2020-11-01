setwd("")
data <- read.table("item_bank_3PL_SCI.csv",sep = ";",header = TRUE)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(reshape2)
library(hrbrthemes)
library(extrafont)
extrafont::loadfonts()
library(viridis)
long <- melt(data[c("Item_ID","a","b","c")])

long %>%
  ggplot(aes(x=variable, y=value)) +
  geom_boxplot(outlier.size = 1) +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  theme_ipsum() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11),
  ) +
  scale_x_discrete(labels=c("discrimination","difficulty","pseudo-guessing"))+
  ggtitle("") +
  xlab("") +
  ylab("")


sum(data$c== 0)
sum(data$b==0)
min(data$b)
max(data$b)
mean(data$b)
median(data$b)
min(data$c)
max(data$c)
mean(data$c)
median(data$c)
