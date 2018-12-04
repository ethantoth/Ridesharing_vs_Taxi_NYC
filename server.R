#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
library(DT)

## Reads in the data, and allows the data to be used by ggplot
transport_data <- read.csv("data/final_reformat.csv", stringsAsFactors = FALSE, header = TRUE)

transport_data <-  transport_data %>% mutate(Date = as.Date(Date)) %>%
  mutate(FHV = as.numeric(FHV)) %>% mutate(Yellow = as.numeric(Yellow)) %>% 
  filter(FHV > 450000) #deals with the major outlier in the FHV data


## Allows us to view the data in months, which is much easier to visualized in bar graphs
monthly_data <- transport_data %>% group_by(month=floor_date(Date, "month")) %>% 
  summarise(FHV = sum(FHV), Yellow = sum(Yellow))

# Define server logic required to draw our plots
shinyServer(function(input, output) {
  
  
  ## This is the server code for the second tab of our application "2018 Daily Trends"
  
  ## This graph will show how different types of paid transport change in popularity 
  ## over time, with each point being the next day
  output$day_line_graph <- renderPlot({
    
    ## Allows us to change the data the user sees based on what dates their interested in
    first_date <- input$dates[1]
    final_date <- input$dates[2]
    
    ## Basic code so that we only display data the user is interested in
    day_line_graph_data <- transport_data %>%
     filter(Date >= first_date) %>%
     filter(Date <= final_date)
    
    ## This is where we generate the plot based on what type of data the user
    ## is interested in based on the radio widget
    
    if (input$radio == "taxi") {
      
      basic_plot <- ggplot(day_line_graph_data, aes(x = Date, y = Yellow)) +
        geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
        geom_smooth(method = "lm", se = FALSE) +
        scale_colour_manual(values= "gold3") +
        theme_bw() +
        labs(title = "NYC Taxis Pickup Data", y = "Number of Pickups", 
             color = "Service Type") +
        scale_x_date(date_breaks = "1 month") +
        scale_y_continuous(limits = c(150000, 400000),
                           breaks = seq(from = 100000, to = 400000, by = 100000),
                           labels = scales::comma)
      
    } else if (input$radio == "FHV"){
      
      basic_plot <- ggplot(day_line_graph_data, aes(x = Date, y = FHV)) +
        geom_line(aes(y = FHV, color = "FHV")) +
        geom_smooth(method = "lm", se = FALSE) +
        scale_colour_manual(values = "purple") +
        theme_bw() +
        labs(title = "NYC Taxis Pickup Data", y = "Number of Pickups", 
             color = "Service Type") +
        scale_x_date(date_breaks = "1 month") +
        scale_y_continuous(limits = c(450000, 900000),
                           breaks = seq(from = 300000, to = 900000, by = 100000),
                           labels = scales::comma)
      
    } else if (input$radio == "both"){
      
      basic_plot <- ggplot(day_line_graph_data, aes(x = Date, y = FHV)) +
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
    }
    
    basic_plot
  })
  
  ## This is the server code for the third tab of our application "2018 Monthly Trends"
  
  output$monthly2018Trends <- renderPlot({
    
  })
  
  
  ## For the last tab "Table", we want to render a data table displaying the 2018 transport
  ## data from 2015 to 2018
  output$monthlyTable <- DT::renderDataTable({
    monthly_data
  })
})







## This graph will show how different types of paid transport change in popularity 
## over the months, not days
# output$month_line_graph <- renderPlot({
#   
#   first_month <- input$month_slider(1)
#   final_month <- input$month_slider(2)
#   
#   month_line_graph_data <- transport_data %>% 
#     group_by(month = floor_date(date, "month")) %>% 
#     summarize(FHV = sum(FHV = sum(FHV)), Yellow = sum(Yellow))
#   
#   month_plot <- ggplot(transport_data, aes(x = Date)) +
#     geom_line(aes(y = FHV, color = "FHV")) +
#     geom_line(aes(y = Yellow, color = "Yellow Taxi")) +
#     scale_colour_manual(values=c("purple", "gold3")) +
#     theme_bw() +
#     labs(title = "NYC Taxis vs For Hire Vehices", y = "Number of Pickups", 
#          color = "Service Type") +
#     scale_x_date(date_breaks = "1 month") +
#     scale_y_continuous(limits = c(100000, 900000),
#                        breaks = seq(from = 100000, to = 900000, by = 100000),
#                        labels = scales::comma)
#   
#   month_plot
# })
#Text summary of our overall project

