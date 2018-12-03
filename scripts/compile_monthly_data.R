
library(data.table)
library(stringr)
library(dplyr)
library(lubridate)


## This function will take the data from NYC database and strip it down to
## just two rows we're interested in, which is the pickup date/time, as 
## well as the location ID

editRawData <- function(rawDataDir) {
  raw_data <- fread(rawDataDir, stringsAsFactors = FALSE)
  
  datesAndLocations <- select(raw_data, Pickup_DateTime, PUlocationID)
  
  datesAndLocations
}

editRawDataOld <- function(rawDataDir) {
  raw_data <- fread(rawDataDir, stringsAsFactors = FALSE)

  datesAndLocations <- select(raw_data, Pickup_date)
  
  datesAndLocations
}

editRawData2 <- function(rawDataDir) {
  raw_data <- fread(rawDataDir, stringsAsFactors = FALSE)
  
  datesAndLocations <- select(raw_data, V2, V6)
  
  datesAndLocations
}

## Here I create the table we will store our summary data in

thisYearDates <- seq(as.Date("2015-01-01"), as.Date("2018-01-01"), by = "years")

transportData <- data.frame(Date = thisYearDates, FHV = c(0,0,0,0), Yellow = c(0,0,0,0))

View(transportData)

## Now I add data from the 12 files to the data set

fhvSum <- editRawData("data/fhv_tripdata_2018-01.csv") %>% 
  mutate(rideDate = str_sub(Pickup_DateTime, 1, 10)) %>% 
  select(rideDate, PUlocationID) %>% 
  group_by(rideDate) %>% 
  summarise(total = n())

fhvSum <- editRawData("data/fhv_tripdata_2017-01.csv") %>% 
  mutate(rideDate = str_sub(Pickup_DateTime, 1, 10)) %>% 
  select(rideDate, PUlocationID) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  bind_rows(fhvSum)

fhvSum <- editRawDataOld("data/fhv_tripdata_2016-01.csv") %>% 
  mutate(rideDate = str_sub(Pickup_date, 1, 10)) %>% 
  select(rideDate) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  bind_rows(fhvSum)

fhvSum <- editRawDataOld("data/fhv_tripdata_2015-01.csv") %>% 
  mutate(rideDate = str_sub(Pickup_date, 1, 10)) %>% 
  select(rideDate) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  bind_rows(fhvSum)

fhvSum <- fhvSum %>% group_by(month = str_sub(rideDate, 1, 4)) %>% 
  summarise(count = sum(total))




taxiSum <- editRawData2("data/yellow_tripdata_2018-01.csv")  %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>%
  select(rideDate) %>%
  group_by(rideDate) %>%
  summarise(total = n()) %>%
  filter(rideDate >= as.Date("2018-01-01")) %>%
  filter(rideDate <= as.Date("2018-01-31"))

taxiSum <- editRawData2("data/yellow_tripdata_2017-01.csv")  %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>%
  select(rideDate) %>%
  group_by(rideDate) %>%
  summarise(total = n()) %>%
  filter(rideDate >= as.Date("2017-01-01")) %>%
  filter(rideDate <= as.Date("2017-01-31"))  %>% 
  bind_rows(taxiSum)

taxiSum <- fread("data/yellow_tripdata_2016-01.csv", stringsAsFactors = FALSE)  %>% 
  mutate(rideDate = str_sub(tpep_dropoff_datetime, 1, 10)) %>%
  select(rideDate) %>%
  group_by(rideDate) %>%
  summarise(total = n()) %>%
  filter(rideDate >= as.Date("2016-01-01")) %>%
  filter(rideDate <= as.Date("2016-01-31"))  %>% 
  bind_rows(taxiSum)

taxiSum <- fread("data/yellow_tripdata_2015-01.csv", stringsAsFactors = FALSE)  %>% 
  mutate(rideDate = str_sub(tpep_dropoff_datetime, 1, 10)) %>%
  select(rideDate) %>%
  group_by(rideDate) %>%
  summarise(total = n()) %>%
  filter(rideDate >= as.Date("2015-01-01")) %>%
  filter(rideDate <= as.Date("2015-01-31"))  %>% 
  bind_rows(taxiSum)
View(taxiSum2)
taxiSum <- taxiSum %>% group_by(month = str_sub(rideDate, 1, 4)) %>% 
  summarise(count = sum(total))



for(index in 1:nrow(fhvSum)) {
  transportData[index, 2] <- fhvSum[index, 2]
}

for(index in 1:nrow(taxiSum)) {
  transportData[index, 3] <- taxiSum[index, 2]
}


write.csv(transportData, file = "data/monthlyTripData.csv", row.names = FALSE)

View(read.csv("data/tripData.csv", stringsAsFactors = FALSE))

View(transportData)
