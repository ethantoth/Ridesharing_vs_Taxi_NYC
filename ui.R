#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

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
                             div(style = "font-size: 10px; padding: 14px 0px; margin:0%",
                                 radioButtons("radio", label = h3("Select Taxi or For-Hire Vehicle"),
                                              choices = list("Taxi Trends" = "", "For Hire Vehicle Trends" = "", 
                                                             "Both" = ""), selected = "")
                             )
                      ),
                      
                      #This will be for average line
                      column(4, offset = 1, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%", 
                                 dateRangeInput("dates", label = h3("Date Range"))
                             )
                      ),
                      
                      #This will be for date range
                      column(5, offset = 2, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                                 uiOutput("")
                             )
                      ))),
           tabPanel("Visualization 1",
                    sidebarLayout(
                      sidebarPanel(
                        h3("Manipulate the Data")
                      ),
                      mainPanel(
                        plotOutput(""))
                    )
           ),
           tabPanel("Visualization 2", 
                    sidebarLayout(
                      sidebarPanel(
                        h3("Manipulate the Data")
                      ),
                      mainPanel(
                        plotOutput(""))
                    )
           ),
           tabPanel("Summary", verbatimTextOutput("summary"))
        )
    )
)


