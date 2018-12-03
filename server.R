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
  mutate(FHV = as.numeric(FHV)) %>% mutate(Yellow = as.numeric(Yellow))

monthly_data <- transport_data %>% group_by(month=floor_date(Date, "month")) %>% 
  summarise(FHV = sum(FHV), Yellow = sum(Yellow))

# Define server logic required to draw our plots
shinyServer(function(input, output) {
  
  ## Manipulatable summary text that changes with user input as the widgets of the main and side plots are altered. 
  output$summary <- renderText({
    paste("Using the provided UFO data, this map of the United States displays all UFO's that were shaped as a", input$select,
          "on the date of", input$dates1, "that were observed flying in the sky at the position on the map.")
  })
  
  output$monthlyTable <- DT::renderDataTable({
    monthly_data
  })
  
  ## This graph will show how different types of paid transport change in popularity 
  ## over time, with each point being the next day
  output$day_line_graph <- renderPlot({
    
    first_date <- input$dates[1]
    final_date <- input$dates[2]
    View(transport_data)
    print(first_date)
    print(class(first_date))
    print(class(transport_data[1,1]))

    #day_line_graph_data <- transport_data %>%
     # filter(Date >= first_date) %>%
      #filter(Date <= final_date)

    View(day_line_graph_data)
    #if(input$typeSelect != "ALL") {
     # day_line_graph_data <- day_line_graph_data %>%
      #  select(Date, FHV)
    #}
    
    basic_plot <- ggplot(transport_data, aes(x = Date, y = FHV)) +
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
  
  
})
