library(ggplot2)
library(dplyr)

transport_data <- read.csv("data/final_reformat.csv", stringsAsFactors = FALSE, header = TRUE)
correct_class <-  transport_data %>% mutate(Date = as.Date(Date)) %>%
  mutate(FHV = as.numeric(FHV)) %>% mutate(Yellow = as.numeric(Yellow))


basic_plot <- ggplot(correct_class, aes(x = Date)) +
  geom_line(aes(y = FHV)) + geom_line(aes(y = Yellow))
print(basic_plot)