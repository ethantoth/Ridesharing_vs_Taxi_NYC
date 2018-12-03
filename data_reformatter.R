library(ggplot2)
library(dplyr)
## This file takes the data formatted as 3 rows, and flips it,
## making a dataframe of 3 columns. The output file is reformatted_data.csv

trip_data2 <- read.csv("data/tripData.csv", stringsAsFactors = FALSE, header = FALSE)
df_transpose <- t(trip_data2)
colnames(df_transpose) = df_transpose[1, ]
df_transpose = df_transpose[-1, ]
final_frame <- data.frame(df_transpose, stringsAsFactors = FALSE)
correct_classes <- final_frame %>% mutate(Yellow = as.numeric(Yellow)) %>% mutate(FHV = as.numeric(FHV)) %>%
  mutate(transportType = as.Date(transportType))
reformat <- correct_classes %>% rename(Date = transportType)
write.csv(reformat, "reformatted_data.csv", row.names = FALSE)
