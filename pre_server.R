library(ggplot2)
library(dplyr)

## Reads in the data, and allows the data to be used by ggplot
transport_data <- read.csv("data/final_reformat.csv", stringsAsFactors = FALSE, header = TRUE)
correct_class <-  transport_data %>% mutate(Date = as.Date(Date)) %>%
  mutate(FHV = as.numeric(FHV)) %>% mutate(Yellow = as.numeric(Yellow))
View(correct_class)
## Plots the data as lines on a single plot, with For Hire Vehicles
## being represented by the purple line, and Yellow Taxis being represented
## by the yellow line
basic_plot <- ggplot(correct_class, aes(x = Date, y = FHV)) +
  geom_line(aes(y = FHV, color = "FHV")) +
  geom_smooth(method = "lm", se = FALSE) +
  geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
  geom_smooth(aes(y = Yellow), method = "lm", se = FALSE) +
  scale_colour_manual(values=c("purple", "gold3")) +
  theme_bw() +
  labs(title = "NYC Taxis vs For Hire Vehices", y = "Number of Pickups", 
       color = "Service Type") +
  scale_x_date(date_breaks = "1 month") +
  scale_y_continuous(limits = c(100000, 900000),
       breaks = seq(from = 100000, to = 900000, by = 100000),
       labels = scales::comma)

basic_plot