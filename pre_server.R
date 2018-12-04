library(ggplot2)
library(dplyr)
library(reshape2)

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


## This is a barplot that adds a bar for every data entry input. It does not
## appear to be helpful for daily data, but may be for monthly

bar_plot <- ggplot(correct_class, aes(x = Date, y = FHV, color = "FHV")) +
  geom_bar(stat = "identity", color = "purple", fill = "purple", position = "dodge") +
  geom_bar(stat = "identity", aes(y = Yellow), color = "gold3") +
  theme_bw() +
  labs(title = "NYC Taxis vs For Hire Vehices", y = "Number of Pickups",
       color = "Service Type") +
  scale_x_date(date_breaks = "1 month") +
  scale_y_continuous(breaks = seq(from = 0, to = 900000, by = 100000),
                     expand = c(0,0), labels = scales::comma)
bar_plot

## This is the bar plot for the data containing a value for a single
## month in each year. Note that it uses the data before reshaping
transport_data <- read.csv("data/yearlyTripData.csv", stringsAsFactors = FALSE, header = TRUE)
df.long <- melt(transport_data)
ggplot(df.long,aes(x = Date,value,fill=variable)) +
  geom_bar(stat="identity",position="dodge") +
  scale_fill_manual(values = c("purple", "gold3")) +
  theme_bw() +
  scale_y_continuous(labels = scales::comma, expand = c(0,0),
                     limits = c(0, 20500000)) +
  scale_x_discrete(labels = c("2015", "2016", "2017", "2018")) +
  labs(title = "NYC Taxis vs For Hire Vehices in January from 2015 to 2018", y = "Number of Pickups",
       fill = "Service Type")