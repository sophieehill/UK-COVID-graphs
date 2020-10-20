# replicating main figure from 
# Michaels, G., Rauch, F. and Redding, S., 2018. Task Specialization in U.S. Cities from 1880 to 2000. _Journal of the European Economic Association_, 17(3), pp.754-798.
# https://academic.oup.com/jeea/article-abstract/17/3/754/4922084


# replication data available here: http://www.princeton.edu/~reddings/redpublish.htm

# this csv file is the result of running the Stata code to create industry/occupation weighted averages

met <- read_csv("interactiveness.csv")
head(met)

met.long <- met %>% select(-all) %>% pivot_longer(-year)

met.long %>% ggplot(aes(x=year, y=value, group=name, color=name)) +
  geom_line(lwd=2) +
  theme_classic() +
  ylim(0.48,0.58) + 
  scale_y_continuous(breaks=c(0.5, 0.52, 0.54, 0.56, 0.58)) +
  theme(legend.position = "none") +
  scale_color_manual(values=my.colors[2:3]) +
  annotate("text", x=1950, y=0.55, label="Metro areas", color=my.colors[2]) +
  annotate("text", x=1955, y=0.515, label="Non-metro areas", color=my.colors[3]) + xlab("") + ylab("Mean interactiveness") +
  labs(title="Over time, cities specialize in interactive tasks",
       subtitle="Interactiveness in U.S. metro vs non-metro areas, 1880-2000",
       caption="Source: Michaels, Rauch, & Redding (2018)")

ggsave("fig_metro.png", width=5, height=3.75)


