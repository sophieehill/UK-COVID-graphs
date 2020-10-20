# Run this code first to ensure necessary packages are loaded
# and color scales for plots are defined

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, scales, ggplot2, rio, dplyr, ggrepel)


my.colors <- c("#000000", "#C1666B", "#3366FF", "#037053", "#70267D")