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
                    # fillPage(
                    #   fillRow(
                    #     div(style = "background-color: red; width: 100%; height: 100%;"),
                    #     div(style = "background-color: blue; width: 100%; height: 100%;")
                    #   )
                    # ),
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
                             div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                                 radioButtons("radio", label = h5("Transportation Services"),
                                              choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                             "Both" = "both"), selected = "both")
                      )),
                      
                      #This will be for picking the daily date range 
                      column(4, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:0%", 
                                 dateRangeInput("dates", label = h5("Date Range"),
                                                start = as.Date("2018-01-01"), end = as.Date("2018-07-01"))
                      
                                 )),
                      
                      #This is for a widget that either displays the trend line(s) or not
                      column(5,
                             div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                                 radioButtons("trend", label = h5("Trend Line"),
                                              choices = list("Show Trend Line" = "show", 
                                                             "Don't Show Line" = "dont_show"), selected = "show"))
                             )
                      ),
                    column(6,
                           div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                               radioButtons("trend", label = h5("View data in:"),
                                            choices = list("Days" = "", "Months" = ""), selected = "")
                           )
                    ),
                    p("This is where the text will appear. How much can I fit before the layout gets more messed up? I don't
                      know I'm going to keep going until it stops.")
           ),


           
           #The second tab
           tabPanel("Yearly Trends",

                    
                    plotOutput("yearly_trends"),

                    
                    #This will be to pick in whether you want to see 
                    #yellow taxi's, for-hire vehicles, or both                    
                    column(3, offset = 0, 
                           div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                               radioButtons("radio", label = h5("Transportation Services"),
                                            choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                           "Both" = "both"), selected = "both")
                           )
                    ),
                    
                    #This will be for monthly range
                    column(4, offset = 1, 
                           div(style = "font-size: 10px; padding: 0px 0px; margin:0%", 
                               dateRangeInput("dates", label = h5("Date Range"),
                                              start = as.Date("2018-01-01"), end =as.Date("2018-07-01"))
                           )
                    )
           ),
           
           #The third tab
           tabPanel("Example Week", 
                      mainPanel(
      
                        plotOutput("example_week"),
                        
                        h4("The Average Week"),
                        
                        p("This is an example week.")
                      )
                    ),    
           
           
           #The fourth tab
           tabPanel("Table",
                    sidebarLayout(
                      sidebarPanel(
                        h3("Quick Analysis"),
                        p("The table to right displays the total amount of for-hire vehicles and NYC taxis that were
                          used from January, 2018 to June, 2018."),
                        tags$ul(
                          tags$li("First list item"), 
                          tags$li("Second list item"), 
                          tags$li("Third list item")
                        ),
                        p("This table gives a summary of the total amount of for-hire vehicles and yellow taxis used by riders within
                          2018 from the months of January to June.")
                        ),
                      mainPanel(
                        DT::dataTableOutput("monthlyTable")
                      )
                    )
            )
        )
    )
 )



