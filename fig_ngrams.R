library(ngramr)
library(scales)

temp <- ngramr::ngram(c("productivity", "innovation"), 
      year_start=1900)

write.csv(temp, "ngram_data.csv")

temp <- read.csv("ngram_data.csv")

ggplot(temp, aes(x=Year, y=Frequency, group=Phrase, color=Phrase)) + 
  geom_line() +
  theme_classic() +
  theme(legend.position="none") +
  scale_y_continuous(labels = scales::percent_format(accuracy = 0.001)) +
  scale_color_manual(values=my.colors[2:3]) +
  annotate("text", x=1955, y=0.00003, label="Productivity", color=my.colors[3], size=3) +
  annotate("text", x=1990, y=0.00002, label="Innovation", color=my.colors[2], size=3) +
  labs(title="Trends in the Google Books corpus, 1900-2019",
       subtitle="Frequency of 'productivity' and 'innovation'",
       caption="Source: Google Books Ngram Viewer") +
  xlab("")


ggsave("fig_ngrams.png", width=5, height=3.75)
