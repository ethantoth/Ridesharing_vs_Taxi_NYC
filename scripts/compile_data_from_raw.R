
library(data.table)
library(stringr)
library(dplyr)


## This function will take the data from NYC database and strip it down to
## just two rows we're interested in, which is the pickup date/time, as 
## well as the location ID


## datesSlice <- slice(datesAndLocations, 1)

## datesLocations <- mutate(datesAndLocations, rideDate = str_sub(Pickup_DateTime, 1, 10))

## datesLocations <- select(datesAndLocations, rideDate, PUlocationID)

editRawData <- function(rawDataDir) {
  raw_data <- fread(rawDataDir, stringsAsFactors = FALSE)
  
  datesAndLocations <- select(raw_data, Pickup_DateTime, PUlocationID)
  
  datesAndLocations
}

editRawData2 <- function(rawDataDir) {
  raw_data <- fread(rawDataDir, stringsAsFactors = FALSE)
  
  datesAndLocations <- select(raw_data, V2, V6)
  
  datesAndLocations
}

## Here I create the table we will store our summary data in

transportType <- c("FHV", "Yellow")

transportData <- data.frame(transportType)

thisYearDates <- seq(as.Date("2018-01-01"), as.Date("2018-06-30"), by = "days")

for(nextDate in thisYearDates) {
  
  transportData <- mutate(transportData, placeHolder = c(0,0))
  
  names(transportData)[names(transportData) == "placeHolder"] <- 
    format(as.Date(nextDate, origin = "1970-01-01"), "%Y-%m-%d")
}

## Now I add data from the 12 files to the data set

rawDataFHV1 <- editRawData("data/fhv_tripdata_2018-01.csv")

datesLocations <- mutate(rawDataFHV1, rideDate = str_sub(Pickup_DateTime, 1, 10))

datesLocations <- select(datesLocations, rideDate, PUlocationID)

groupedDates <- group_by(datesLocations, rideDate)

sum1 <- summarise(groupedDates, total = n())


rawDataFHV2 <- editRawData("data/fhv_tripdata_2018-02.csv")

datesLocations <- mutate(rawDataFHV2, rideDate = str_sub(Pickup_DateTime, 1, 10))

datesLocations <- select(datesLocations, rideDate, PUlocationID)

groupedDates <- group_by(datesLocations, rideDate)

sum2 <- summarise(groupedDates, total = n())

rawDataFHV3 <- editRawData("data/fhv_tripdata_2018-03.csv")

datesLocations <- mutate(rawDataFHV3, rideDate = str_sub(Pickup_DateTime, 1, 10))

datesLocations <- select(datesLocations, rideDate, PUlocationID)

groupedDates <- group_by(datesLocations, rideDate)

sum3 <- summarise(groupedDates, total = n())


rawDataFHV4 <- editRawData("data/fhv_tripdata_2018-04.csv")

datesLocations <- mutate(rawDataFHV4, rideDate = str_sub(Pickup_DateTime, 1, 10))

datesLocations <- select(datesLocations, rideDate, PUlocationID)

groupedDates <- group_by(datesLocations, rideDate)

sum4 <- summarise(groupedDates, total = n())


rawDataFHV5 <- editRawData("data/fhv_tripdata_2018-05.csv")

datesLocations <- mutate(rawDataFHV5, rideDate = str_sub(Pickup_DateTime, 1, 10))

datesLocations <- select(datesLocations, rideDate, PUlocationID)

groupedDates <- group_by(datesLocations, rideDate)

sum5 <- summarise(groupedDates, total = n())


rawDataFHV6 <- editRawData("data/fhv_tripdata_2018-06.csv")

datesLocations <- mutate(rawDataFHV6, rideDate = str_sub(Pickup_DateTime, 1, 10))

datesLocations <- select(datesLocations, rideDate, PUlocationID)

groupedDates <- group_by(datesLocations, rideDate)

sum6 <- summarise(groupedDates, total = n())

sum <- bind_rows(sum1, sum2)
sum <- bind_rows(sum, sum3)
sum <- bind_rows(sum, sum4)
sum <- bind_rows(sum, sum5)
sum <- bind_rows(sum, sum6)


for(index in 1:nrow(sum)) {
  
  transportData[1, index + 1] <- as.numeric(transportData[1, index + 1]) +
    as.numeric(sum[index, 2])
}

transportDataOld <- read.csv("data/tripData.csv", stringsAsFactors = FALSE)

for(index in 1:(ncol(transportData) - 1)) {
  transportData[1, index + 1] <- transportDataOld[1, index + 1]
}




sum1 <- editRawData2("data/yellow_tripdata_2018-01.csv")  %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>%
  select(rideDate) %>%
  group_by(rideDate) %>%
  summarise(total = n()) %>%
  filter(rideDate >= as.Date("2018-01-01")) %>%
  filter(rideDate <= as.Date("2018-01-31"))

sum2 <- editRawData2("data/yellow_tripdata_2018-02.csv") %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>% 
  select(rideDate) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  filter(rideDate >= as.Date("2018-02-01")) %>% 
  filter(rideDate <= as.Date("2018-02-28"))

sum3 <- editRawData2("data/yellow_tripdata_2018-03.csv") %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>% 
  select(rideDate) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  filter(rideDate >= as.Date("2018-03-01")) %>% 
  filter(rideDate <= as.Date("2018-03-31"))

sum4 <- editRawData2("data/yellow_tripdata_2018-04.csv") %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>% 
  select(rideDate) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  filter(rideDate >= as.Date("2018-04-01")) %>% 
  filter(rideDate <= as.Date("2018-04-30"))

sum5 <- editRawData2("data/yellow_tripdata_2018-05.csv") %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>% 
  select(rideDate) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  filter(rideDate >= as.Date("2018-05-01")) %>% 
  filter(rideDate <= as.Date("2018-05-31"))

sum6 <- editRawData2("data/yellow_tripdata_2018-06.csv") %>% 
  mutate(rideDate = str_sub(V2, 1, 10)) %>% 
  select(rideDate) %>% 
  group_by(rideDate) %>% 
  summarise(total = n()) %>% 
  filter(rideDate >= as.Date("2018-06-01")) %>% 
  filter(rideDate <= as.Date("2018-06-30"))

View(yellowData2)


sum <- bind_rows(sum1, sum2)
sum <- bind_rows(sum, sum3)
sum <- bind_rows(sum, sum4)
sum <- bind_rows(sum, sum5)
sum <- bind_rows(sum, sum6)

rm(sum6)
View(sum)

for(index in 1:nrow(sum)) {
  
  transportData[2, index + 1] <- as.numeric(transportData[2, index + 1]) +
    as.numeric(sum[index, 2])
}



write.csv(transportData, file = "data/tripData.csv", row.names = FALSE)

View(read.csv("data/tripData.csv", stringsAsFactors = FALSE))

View(transportData)


















