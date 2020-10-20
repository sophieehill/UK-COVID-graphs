# source: IFS report 
# https://www.ifs.org.uk/publications/14860
# data points taken using web extraction tool

ifs <- read_csv("ifs.csv")

head(ifs)
ifs$label <- ifelse(ifs$top_earner=="Father", "Father earns more", "Mother earns more")

ifs %>% ggplot(aes(x=Type, y=Hours, fill=Parent, group=Parent)) +
  geom_col(position="dodge") +
  facet_wrap(~label) +
  coord_flip() + 
  theme_classic() +
  xlab("") +
  scale_fill_manual(values=my.colors) +
  scale_y_continuous(expand=c(0,0),
                     limits=c(0,11),
                     breaks=c(0,2,4,6,8,10)) +
  theme(legend.title=element_blank(),
        legend.position="none") +
  annotate("text", x=3.8, y=8, label="Father", size=4) +
  annotate("text", x=4.2, y=8, label="Mother", size=4, color=my.colors[2]) +

  labs(title="Time use during lockdown, by pre-crisis earnings",
       caption="Source: IFS")

ggsave("fig_ifs.png", width=8, height=4)
