library(tidyverse)
library(ggplot2)

my.colors <- c("#000000", "#C1666B", "#3366FF", "#037053", "#70267D")


# source: https://www.ons.gov.uk/peoplepopulationandcommunity/wellbeing/datasets/incomegroupsplitestimatesonpersonalandeconomicwellbeingacrosstime

# Income group split estimates on personal and economic well-being across time

# this csv contains the % of respondents saying they had difficulty paying bills
# by household income group
# before COVID and since COVID
# figures take from OPN Lite 15 = 25 June to 28 June 2020
opn <- read.csv("OPN_lite_15.csv")
opn$hh.inc <- factor(opn$hh.inc, levels=c("Up to £10,000",
                                          "£10,000 up to £20,000",
                                          "£20,000 up to £40,000",
                                          "£40,000 or more"),
                     labels=c("<£10k", "£10-20k", "£20-40k", "£40k+"),
                     ordered=TRUE)

opn %>% ggplot(aes(x=difficult, y=hh.inc, group=hh.inc, label=round(difficult, 0))) + geom_line(color="grey") + 
  geom_point(aes(color=time), size=5) + 
  geom_text(data = subset(opn, opn$time=="before COVID"), 
            aes(color = time), size = 3, hjust = 2.5, show.legend = F) +
  geom_text(data = subset(opn, opn$time=="since COVID"), 
            aes(color = time), size = 3, hjust = -1.5, show.legend = F) +
  theme_classic() +
  theme(legend.title=element_blank(),
        legend.position=c(0.7, 0.8),
        axis.title.y=element_text(angle=0, vjust=0.5),
        plot.margin=unit(c(0.5, 0.5, 0.5, 0.5), "cm")) +
  scale_color_manual(values=my.colors[1:2]) +
  xlim(0,23) +
  xlab("% saying 'difficult' to pay bills") +
  ylab("Household\nincome") +
  labs(caption="\nSource: ONS / OPN (June 2020)",
       title="Low-income households hardest hit by COVID",
       subtitle="% reporting difficulty paying bills")

ggsave(filename="fig_bills.png", width=6, height=3.75)
