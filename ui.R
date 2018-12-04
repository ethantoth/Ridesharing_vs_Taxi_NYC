#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#talk about the data whether its skewed// questions on what they should be concluded
##rendering a markdown file into
##limitations of data, correlation does notimply casuation, links, pictures of us

library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "theme.css",

# Show a plot of the generated distribution
navbarPage("NYC Taxi and RideSharing",
           # tags$head(
           #   tags$link(rel = "stylesheet", type = "text/css", href = "theme.css")
           # )
           tabPanel("Home",
                    ## Function that imports a CSS font to use in the header of the main page
                    #' tags$head(
                    #'   tags$style(HTML("
                    #'                   @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                    #'                   "))
                    #'   ),
                    #' headerPanel(
                    #'   h2("NYC Taxi vs. Ridesharing", 
                    #'      style = "font-family: 'Arial Black', Gadget, sans-serif;
                    #'      font-weight: 400; line-height: 1.1; 
                    #'      color: #000000;")
                    #'   ),
                    
                    includeMarkdown("homeText.md")

                   

            ),
           
           #The first tab
           tabPanel("2018 Daily Trends", 
                    fluidRow(

                      #This will be to pick in whether you want to see 
                      #yellow taxi's, for-hire vehicles, or both
                      plotOutput("day_line_graph")
                    ),
                    fluidRow(
                       column(3, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                                 radioButtons("radio", label = h3("Transportation Services"),
                                              choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                             "Both" = "both"), selected = "both")
                      )),
                      
                      #This will be for picking the daily date range 
                      column(4, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%", 
                                 dateRangeInput("dates", label = h3("Date Range"),
                                                start = as.Date("2018-01-01"), end = as.Date("2018-07-01"))
                      
                                 )),
                      
                      #This is for a widget that either displays the trend line(s) or not
                      column(5,
                             div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                                 radioButtons("trend", label = h3("Trend Line"),
                                              choices = list("Show Trend Line" = "show", 
                                                             "Don't Show Line" = "dont_show"), selected = "show"))
                             )
                      ),
                    column(6,
                           div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
                               radioButtons("trend", label = h3("View data in:"),
<<<<<<< HEAD
                                            choices = list("Days" = "", "Months" = ""), selected = "")
                           )
=======
                                            choices = list("Days" = "", "Months" = ""), selected = ""))
>>>>>>> 2595442f42795ab4417d64c895bfcbcd033cdf8d
                    )
                    
           ),


           
           #The second tab
           tabPanel("Yearly Trends",

                    
                    plotOutput("yearly_trends"),

                    
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
           tabPanel("Example Week", 
                    fluidRow(
                        h3("A sample week, showing pickups by day.")
                      ),
                      mainPanel(
                        plotOutput("example_week"))
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



