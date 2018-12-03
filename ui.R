#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

# Show a plot of the generated distribution
navbarPage("NYC Taxi and RideSharing",
           
           tabPanel("Home", 
                    fluidRow(
                      
                      ## Function that imports a CSS font to use in the header of the main page
                      tags$head(
                        tags$style(HTML("
                                        @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                                        "))
                        ),
                      
                      # Header Panel that displays the CSS header with new font
                      headerPanel(
                        h2("NYC Taxi vs. Ridesharing", 
                           style = "font-family: 'Arial Black', Gadget, sans-serif;
                           font-weight: 400; line-height: 1.1; 
                           color: #000000;")
                        ),
                      
                      #This will be to pick
                      plotOutput("day_line_graph"),
                      column(3, offset = 0, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                                 radioButtons("radio", label = h3("Transportation Services"),
                                              choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                             "Both" = "both"), selected = "both")
                             )
                      ),
                      
                      #This will be for average line
                      column(4, offset = 1, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%", 
                                 dateRangeInput("dates", label = h3("Date Range"),
                                                start = as.Date("2018-01-01"), end =as.Date("2018-07-01"))
                                 )
                      ),
                      
                      #This will be for date range
                      column(5, offset = 2, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                                 uiOutput("")
                             ))),
                      p("The visualizations on this application meant to show how different types of paid transport have 
                      increased or decreased in popularity. Our data is filtered down to 2018 (the months of January to June) 
                      and the first month of every year from 2015. The intent of these visualizations to speak to the current 
                      debate surrounding lose of business for taxi drivers in urban areas, such as New York. The lines across the graph 
                      display the linear relationship of the amount of consumers over time for these types of paid vehicles. 
                      The trends indicate that taxi use is slowly on the decline, while in contrast, for-hire
                      vehicle use is sturdily inclining. From this data it can be inferred that for-hire vehicles (such as Uber or Lyft) 
                      are becoming more popualr among consumers and with consequence taking away yellow taxi's business.")
                    ),
           
           tabPanel("Visualization 1",
                    sidebarLayout(
                      sidebarPanel(
                        h3("Manipulate the Data")
                      ),
                      mainPanel(
                        plotOutput(""))
                    )
           ),
           tabPanel("Data", 
                    sidebarLayout(
                      sidebarPanel(
                        h3("Manipulate the Data")
                      ),
                      mainPanel(
                        DT::dataTableOutput("monthlyTable"))
                    )
           ),
           tabPanel("Summary", verbatimTextOutput("summary"))
        )
    )
)


