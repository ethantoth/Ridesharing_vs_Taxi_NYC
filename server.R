library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
library(DT)
library(reshape2)
library(scales)
library(stringr)


## Reads in the data, and allows the data to be used by ggplot
transport_data <- read.csv("data/final_reformat.csv",
  stringsAsFactors = FALSE,
  header = TRUE
)

## Converts data to be friendly
transport_data <- transport_data %>%
  mutate(Date = as.Date(Date)) %>%
  mutate(FHV = as.numeric(FHV)) %>%
  mutate(Yellow = as.numeric(Yellow)) %>%
  filter(FHV > 450000) # deals with the major outlier in the FHV data


## Allows us to view the data in months, which is much easier to
## be visualized in bar graphs
monthly_data <- transport_data %>%
  group_by(
    Date =
      floor_date(Date, "month")
  ) %>%
  summarise(FHV = sum(FHV), Yellow = sum(Yellow))


yearly_data <- read.csv("data/yearlyTripData.csv",
  stringsAsFactors = FALSE,
  header = TRUE
)

## This function is called by day_line_graph and generates a ggplot graph
generate_day_line_plot <- function(monthlyOrDaily) {
  if (input$radioTab2 == "taxi") {
    basic_plot <- ggplot(day_line_graph_data, aes(x = Date, y = Yellow)) +
      geom_line(aes(y = Yellow, color = "Yellow Taxi"))
  } else if (input$radioTab2 == "FHV") {
    basic_plot <- ggplot(day_line_graph_data, aes(x = Date, y = Yellow)) +
      geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
      scale_colour_manual(values = "gold3") +
      theme_bw() +
      labs(
        title = "NYC Taxis Pickup Data", y = "Number of Pickups",
        color = "Service Type"
      ) +
      scale_x_date(date_breaks = "1 month") +
      scale_y_continuous(
        limits = c(150000, 400000),
        breaks = seq(from = 100000, to = 400000, by = 100000),
        labels = scales::comma
      )
  } else {
    basic_plot <- ggplot(day_line_graph_data, aes(x = Date, y = Yellow)) +
      geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
      scale_colour_manual(values = "gold3") +
      theme_bw() +
      labs(
        title = "NYC Taxis Pickup Data", y = "Number of Pickups",
        color = "Service Type"
      ) +
      scale_x_date(date_breaks = "1 month") +
      scale_y_continuous(
        limits = c(150000, 400000),
        breaks = seq(from = 100000, to = 400000, by = 100000),
        labels = scales::comma
      )
  }

  basic_plot
}

# Define server logic required to draw our plots
shinyServer(function(input, output) {


  ## This is the server code for the second tab of our application
  ## "2018 Daily Trends" This graph will show how different types
  ## of paid transport change in popularity over time, with each
  ## point being the next day
  output$day_line_graph <- renderPlot({

    ## Allows users to pick start and end dates
    first_date <- input$datesTab2[1]
    final_date <- input$datesTab2[2]

    ## Basic code so that we only display data the user is interested in
    day_line_graph_data <- transport_data %>%
      filter(Date >= first_date) %>%
      filter(Date <= final_date)

    ## Adjust based on if the user wants daily or monthly totals
    month_line_graph_data <- monthly_data %>%
      filter(Date >= first_date) %>%
      filter(Date <= final_date)

    ## Selects daily or monthly view for plot
    line_graph_data <- day_line_graph_data

    if (input$dailyTab2 == "monthly") {
      line_graph_data <- month_line_graph_data
    }

    ## This is where we generate the plot based on what type of data the user
    ## is interested in based on the radio widget

    options(scipen = 10000000)

    if (input$radioTab2 == "taxi") {
      basic_plot <- ggplot(line_graph_data, aes(x = Date, y = Yellow)) +
        geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
        scale_colour_manual(values = "gold3") +
        theme_bw() +
        labs(
          y = "Number of Pickups",
          color = "Service Type"
        ) +
        scale_x_date(date_breaks = "1 month")
    } else if (input$radioTab2 == "FHV") {
      basic_plot <- ggplot(line_graph_data, aes(x = Date, y = FHV)) +
        geom_line(aes(y = FHV, color = "FHV")) +
        scale_colour_manual(values = "purple") +
        theme_bw() +
        labs(
          y = "Number of Pickups",
          color = "Service Type"
        ) +
        scale_x_date(date_breaks = "1 month") #+
    } else if (input$radioTab2 == "both") {
      basic_plot <- ggplot(line_graph_data, aes(x = Date, y = FHV)) +
        geom_line(aes(y = FHV, color = "FHV")) +
        geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
        scale_colour_manual(values = c("purple", "gold3")) +
        theme_bw() +
        labs(
          y = "Number of Pickups",
          color = "Service Type"
        ) +
        scale_x_date(date_breaks = "1 month") #+
    }

    if (input$trendTab2 == "show") {
      basic_plot <- basic_plot +
        geom_smooth(method = "lm", se = FALSE)
      if (input$radioTab2 != "FHV") {
        basic_plot <- basic_plot +
          geom_smooth(aes(y = Yellow), method = "lm", se = FALSE)
      }
    }
    basic_plot
  })

  ## This displays a bar plot of the number of pickups
  ## for both transportation types from the years 2015, 2016, 2017, and 2018

  output$yearly_trends <- renderPlot({

    ## Alows user to set the starting and ending years
    first_date <- input$datesTab3[1]
    final_date <- input$datesTab3[2]

    ## Basic code so that we only display data the user is interested in
    filtered_yearly_data <- yearly_data %>%
      filter(Date >= first_date) %>%
      filter(Date <= final_date)

    colorValues <- c("purple", "gold3")

    if (input$radioTab3 != "both") {
      filtered_yearly_data <- select(
        filtered_yearly_data, Date,
        input$radioTab3
      )
    }

    if (input$radioTab3 == "Yellow") {
      colorValues <- "gold3"
    }

    if (input$radioTab3 == "FHV") {
      colorValues <- "purple"
    }

    x_labels <- format(seq(first_date, final_date, by = "years"),
      format = "%Y"
    )

    melted_yearly_data <- melt(filtered_yearly_data)

    ggplot(melted_yearly_data, aes(x = Date, value, fill = variable)) +
      geom_bar(stat = "identity", position = "dodge") +
      scale_fill_manual(values = colorValues) +
      theme_bw() +
      scale_y_continuous(
        labels = scales::comma, expand = c(0, 0),
        limits = c(0, 20500000)
      ) +
      scale_x_discrete(labels = x_labels) +
      labs(
        y = "Number of Pickups", x = "Year", fill = "Service Type"
      )
  })

  ## This creates a plot comparing a single week of FHV and Yellow Taxi pickups
  ## This allows for analysis of whether weekdays or weeknds are more popular

  output$example_week <- renderPlot({
    one_week <- mutate(transport_data, day = format(Date, "%A"))

    one_week <- one_week %>%
      group_by(day) %>%
      summarise(FHV = sum(FHV), Yellow = sum(Yellow)) %>%
      select(day, FHV, Yellow)

    x_labels <- c(
      "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
      "Friday", "Saturday"
    )

    one_week$day <- factor(one_week$day, levels = x_labels)

    one_week <- one_week[order(one_week$day), ]

    single_week <- ggplot(one_week, aes(x = day, y = FHV, group = 1)) +
      geom_line(aes(y = FHV, color = "FHV")) +
      geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
      scale_colour_manual(values = c("purple", "gold3")) +
      theme_bw() +
      labs(y = "Number of Pickups", x = "Day", color = "Service Type") +
      scale_x_discrete(labels = x_labels)

    single_week
  })

  ## For the last tab "Table", we want to render a data table displaying
  ## the 2018 transport data from 2015 to 2018
  output$monthlyTable <- DT::renderDataTable({
    monthly_data
  })
})
