library(tidyverse)

data <- read_csv("./results/fine-scale/UK-USA/coherence-scores/calculated_coherence.csv") %>% select(-1)
head(data)