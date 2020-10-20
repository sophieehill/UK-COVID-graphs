# Data from ONS available here: https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/whichjobscanbedonefromhome/2020-07-21

# Original figure caption: "Jobs that pay higher hourly wages are more likely to be adaptable to working from home"

# Source: ONET - US Department of Labor, Annual Population Survey and Annual Survey of Hours and Earnings - Office for National Statistics


my.colors <- c("#000000", "#C1666B", "#3366FF", "#037053", "#70267D")

library(tidyverse)
library(dplyr)
library(rio)
library(ggplot2)
library(ggrepel)

# save direct URL to xlsx file
url1 <- "https://www.ons.gov.uk/visualisations/dvc890/chart1/data.xlsx"
rio::import(file = url1 ,which = 1) %>% 
  glimpse()
# load excel data
ex <- rio::import(file = url1 ,which = 1)
# tidy up
ex <- ex[-1,]
ex <- ex[,-1]
names(ex) <- ex[1,]
ex <- ex[-1,]
ex <- ex %>% dplyr::mutate(across(3:13, ~ na_if(., "x")))
ex <- ex %>% dplyr::mutate(across(3:13, ~ as.numeric(.)))
str(ex)
names(ex)

# create a new variable called "label"
# this will be blank except for a few occupations that we can highlight on the graph
ex$label <- ""
ex$label[ex$`Occupation title`=="Programmers and software development professionals"] <- "Programmers"
ex$label[ex$`Occupation title`=="Nurses"] <- "Nurses"
# ex$label[ex$`Occupation title`=="Paramedics"] <- "Paramedics"
ex$label[ex$`Occupation title`=="Receptionists"] <- "Receptionists"
ex$label[ex$`Occupation title`=="Chief executives and senior officials"] <- "CEOs"
# ex$label[ex$`Occupation title`=="Train and tram drivers"] <- "Train and tram drivers"
# ex$label[ex$`Occupation title`=="Sales and retail assistants"] <- "Sales and retail assistants"
ex$label[ex$`Occupation title`=="Carpenters and joiners"] <- "Carpenters"



ex %>%
  arrange(desc(`Total in employment`)) %>%
  ggplot(aes(x=-I(`Ability to homework score`),
             y=`Median hourly pay (£)`, 
             size = `Total in employment`)) +
  geom_point(alpha=0.2) + 
  geom_point(data=subset(ex, ex$label!=""), color=my.colors[2]) +
  geom_smooth(method = "loess", 
              mapping = aes(weight = `Total in employment`),
              se=F,
              data=subset(ex, ex$`Ability to homework score`<4)) +
  geom_label_repel(aes(label = label), 
                   size = 3, 
                   point.padding=0.5, 
                   box.padding=0.5,
                   xlim=c(-5,1.5)) +
  ylim(5,50) +
  xlab("Ability to work from home") +
  ylab("Median\nhourly pay\n(£)") +
  scale_x_continuous(breaks=c(-4.5, 0.25),
                   labels=c(expression(""%<-%"Least able"), 
                            expression("Most able"%->%"")),
                   limits=c(-4.75,0.5)) +
  theme_classic() +
  theme(legend.position="none",
        axis.ticks.x=element_blank(),
        plot.margin=unit(c(0.5,1,0.5,0.5), "cm"),
        axis.title.y=element_text(angle=0, vjust=0.5)) +
  coord_cartesian(clip = 'off') +
  labs(title="The price of remote work",
    #subtitle="Median pay vs ability to work from home, by occupation",
    caption="\n Source: O*NET, ONS")

ggsave(filename="fig_onet.png", width=5, height=3.75)


