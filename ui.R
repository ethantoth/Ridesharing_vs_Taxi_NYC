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
           tabPanel("2018 Daily Trends", 
                    fluidRow(

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
                             )))
                    ),
           
           tabPanel("2018 Monthly Trends",
                    sidebarLayout(
                      sidebarPanel(
                        h3("Manipulate the Data")
                      ),
                      mainPanel(
                        plotOutput(""))
                    )
           ),
           
           tabPanel("Yearly Trends", 
                    sidebarLayout(
                      sidebarPanel(
                        h3("Manipulate the Data")
                      ),
                      mainPanel(
                        plotOutput(""))
                    )    
           ),
           tabPanel("Table",
                    sidebarLayout(
                      sidebarPanel(
                        p("This table gives a summary of the total amount of for-hire vehicles and yellow taxis used by riders within
                          2018 from the months of January to June."),
                        h3("Manipulate the Data")
                        ),
                      mainPanel(
                        DT::dataTableOutput("monthlyTable"))
                    )
            )
          # In our summary we need to make sure to address why we picked only several months in 2018(we can just say how the data
          # only displays those months currently).
           # tabPanel("Summary", verbatimTextOutput("summary"))
        )
    )
)


