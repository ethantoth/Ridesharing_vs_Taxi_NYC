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
                    ## Function that imports a CSS font to use in the header of the main page
                    tags$head(
                      tags$style(HTML("
                                      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                                      "))
                      ),
                    headerPanel(
                      h2("NYC Taxi vs. Ridesharing", 
                         style = "font-family: 'Arial Black', Gadget, sans-serif;
                         font-weight: 400; line-height: 1.1; 
                         color: #000000;")
                      ),
                    
                    p("The visualizations on this application meant to show how different types of paid transport have 
                    increased or decreased in popularity. Our data is filtered down to 2018 (the months of January to June) 
                    and the first month of every year from 2015. The intent of these visualizations to speak to the current 
                    debate surrounding lose of business for taxi drivers in urban areas, such as New York. The lines across the graph 
                    display the linear relationship of the amount of consumers over time for these types of paid vehicles. 
                    The trends indicate that taxi use is slowly on the decline, while in contrast, for-hire
                    vehicle use is sturdily inclining. From this data it can be inferred that for-hire vehicles (such as Uber or Lyft) 
                    are becoming more popualr among consumers and with consequence taking away yellow taxi's business.")
                   
            ),
           
           #The first tab
           tabPanel("2018 Daily Trends", 
                    fluidRow(

                      #This will be to pick in whether you want to see 
                      #yellow taxi's, for-hire vehicles, or both
                      plotOutput("day_line_graph"),
                      column(3, offset = 0, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                                 radioButtons("radio", label = h3("Transportation Services"),
                                              choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                             "Both" = "both"), selected = "both")
                      )),
                      
                      #This will be for picking the daily date range 
                      column(4, offset = 1, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%", 
                                 dateRangeInput("dates", label = h3("Date Range"),
                                                start = as.Date("2018-01-01"), end =as.Date("2018-07-01"))
                      
                                 ),
                      #This is for a widget that either displays the trend line(s) or not
                      column(5, offset = 2,
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                                 radioButtons("radio", label = h3("Trend Line"),
                                              choices = list("Show Trend Line" = "", "Don't Show Line" = ""), selected = "")
                             )
                      ))
            ),
           
           #The second tab
           tabPanel("2018 Monthly Trends",

                    
                    plotOutput("monthly2018Trends"),

                    #This will be to pick in whether you want to see 
                    #yellow taxi's, for-hire vehicles, or both                    
                    column(3, offset = 0, 
                           div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                               radioButtons("radio", label = h3("Transportation Services"),
                                            choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                           "Both" = "both"), selected = "both")
                           )
                    ),
                    
                    #This will be for monthly range
                    column(4, offset = 1, 
                           div(style = "font-size: 10px; padding: 0px 0px; margin:15%", 
                               dateRangeInput("dates", label = h3("Date Range"),
                                              start = as.Date("2018-01-01"), end =as.Date("2018-07-01"))
                           )
                    )
           ),
           
           #The third tab
           tabPanel("Yearly Trends", 
                    fluidRow(
                        h3("Data for 2015-2018")
                      ),
                      mainPanel(
                        plotOutput(""))
                    ),    
           
           
           #The fourth tab
           tabPanel("Table",
                    sidebarLayout(
                      sidebarPanel(
                        p("This table gives a summary of the total amount of for-hire vehicles and yellow taxis used by riders within
                          2018 from the months of January to June.")
                        ),
                      mainPanel(
                        DT::dataTableOutput("monthlyTable"))
                    )
            )
        )
    )
 )
)


