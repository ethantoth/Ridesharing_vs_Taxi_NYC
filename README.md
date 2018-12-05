## Project Description

**The Final Product**

The link to our shiny.app: 

In our project we will be working with two data sets LINKS.
- The first data set holds information about the New York City **yellow taxi trips** from the years 2015 - 2018.
- The second data set is about NYC **for-hire-vehicles** trips from the years 2015 - 2018.
- Both sets are in a CSV format and were uploaded by the NYC Taxi and Limousine Commission.

The **general audience** that we want to reach are not only the residents of New Yorker City, but also the United States as a whole, particularly those who use ridesharing services frequently. In addition, our project will resonate with the followers of the current national debates between for-hire-vehicle companies and taxi drivers.

( _These businesses are constantly competing in attempt to convince users that their mode of transportation is the dominant and a more beneficial service_)

**Our Findings**

We provide visualizations of the following:

- 2018 Daily trends (January-June)
- Yearly Trends (2015-2018)
- Weekly Trends (2018 Averages)
- Data Table (Overall)

The questions we hope to answer:
- Which of the two transportation services provides the highest frequency of services in their respective years?
- Which form of transportation out of the two have grown the most in recent years?
- In which months are FHV and taxi's most popular?
- How to weekly/monthly trends differ in 2018?

**What We Did**

We read our data sets in RStudio. The NYC yellow taxis and ride sharing vehicles of
an immense size, so we had to filter down our data into multiple different data sets.
We:
- combined both sets
- filtered out to show only pick-up dates
- filtered them down by year, then then to 2018 specifically
- the 2018 data was then separated by month and day
- we created a second data table with the total rides of each set from every year
in the data

Our project was achieved through the use of many libraries within R:
- shiny
- ggplot2
- dplyr
- lubridate
- DT
- reshape2
- scales
- stringr

Some bumps we encountered:
- Datasets were both of immense size.
  - Both of them were multiple gigabytes in size
  - Took large amounts of time to run
