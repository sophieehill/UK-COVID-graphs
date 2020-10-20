# Source: https://www.ons.gov.uk/economy/nationalaccounts/uksectoraccounts/compendium/economicreview/april2019/longtermtrendsinukemployment1861to2018

# File download: https://www.ons.gov.uk/generator?uri=/economy/nationalaccounts/uksectoraccounts/compendium/economicreview/april2019/longtermtrendsinukemployment1861to2018/0242ad05&format=csv

# load data (skip 1st 6 rows)
sec <- read_csv("data_sector_breakdown.csv", skip=6)
head(sec)
names(sec)
# add column name
colnames(sec)[1] <- "Period"
# add combined "high skill services" column
sec$high.skill.services <- sec$`Professional scientific and technical services (including education and health)` + sec$`Insurance, banking and finance`
# convert to long format
sec.long <- sec %>% pivot_longer(-Period)
# create short names for labels
sec.long$short_names <- sec.long$name
sec.long$short_names[sec.long$name=="high.skill.services"] <- "High-skill services"

# make plot
library(grid)
sec.long %>% 
  filter(short_names=="High-skill services" | 
           short_names=="Manufacturing") %>% 
  ggplot(aes(x=Period, y=value, group=short_names, fill=short_names, color=short_names)) +
 # geom_col(position="dodge") + 
  geom_line(lwd=2) +
  geom_point(size=3) +
  scale_color_manual(values=my.colors[2:3]) +
  scale_fill_manual(values=my.colors[2:3]) +
  theme_classic() +
  theme(legend.position="none",
        legend.title=element_blank(),
        axis.title.y = element_text(angle = 0, vjust=0.5)) +
  ylab("%  ") + xlab("") +
  labs(caption="Source: Bank of England",
       title="A Tale of Two Sectors",
       subtitle="Percentage of employment by sector, 1920-2016") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 40)) +
  annotate("text", x=2, y=32, label="Manufacturing", color=my.colors[3], size=3) +
  annotate("text", x=2, y=15, label="'High-skill'\nservices*", color=my.colors[2], size=3) +
  annotation_custom(textGrob("*Professional, technical, and scientific services; Education; Health; Finance and insurance",
                             gp=gpar(fontsize=7), hjust=0, vjust=1), 
                    xmin=0.5, xmax=0.5, ymin=-4, ymax=-4) +
  coord_cartesian(clip="off") 
ggsave("fig_sector.png", width=5, height=3.75)

