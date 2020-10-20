# source: https://www.ons.gov.uk/peoplepopulationandcommunity/housing/bulletins/housingaffordabilityinenglandandwales/2018

af <- read_csv("housing2.csv")
head(af)

af.long <- af %>% pivot_longer(-Year)
table(af.long$name)

af.long %>% ggplot(aes(x=Year, y=value, group=name, color=name)) +
  geom_line(lwd=1.5) +
  scale_color_manual(values=my.colors) +
  theme_classic() +
  theme(legend.position="none") +
  annotate("text", x=2015, y=200, label="Barrow-in-Furness", color=my.colors[1], size=3) +
  annotate("text", x=2015, y=120, label="Copeland", color=my.colors[2], size=3) +
  annotate("text", x=2010, y=310, label="Kensington and Chelsea", color=my.colors[3], size=3) +  
  annotate("text", x=2013, y=350, label="Westminster", color=my.colors[4], size=3) +
  xlab("") + ylab("") +
  labs(title="Widening gap between least and most affordable areas",
       subtitle="Housing affordability index (1997=100)",
       caption="Source: ONS")

ggsave("fig_housing2.png", width=5.2, height=3.75)


