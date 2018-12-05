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
                    #includeMarkdown("homeText.md")
                    p("HI")

                   

            ),
           
           #The first tab
           tabPanel("2018 Daily Trends", 
                    fluidRow(
                    
                      h3("Pickups for NYC Yellow Taxis vs For Hire Vehices"),
                      
                      #This will be to pick in whether you want to see 
                      #yellow taxi's, for-hire vehicles, or both
                      plotOutput("day_line_graph")
                    ),
                    fluidRow(
                       column(3, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                                 radioButtons("radioTab2", label = h5("Transportation Services"),
                                              choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                             "Both" = "both"), selected = "both")
                      )),
                      
                      #This will be for picking the daily date range 
                      column(4, 
                             div(style = "font-size: 10px; padding: 0px 0px; margin:0%", 
                                 dateRangeInput("datesTab2", label = h5("Date Range"),
                                                start = as.Date("2018-01-01"), end = as.Date("2018-07-01"))
                      
                                 )),
                      
                      #This is for a widget that either displays the trend line(s) or not
                      column(5,
                             div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                                 radioButtons("trendTab2", label = h5("Trend Line"),
                                              choices = list("Show Trend Line" = "show", 
                                                             "Don't Show Line" = "dont_show"), selected = "show"))
                             )
                      ),
                    column(6,
                           div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                               radioButtons("dailyTab2", label = h5("View data in:"),
                                            choices = list("Days" = "daily", "Months" = "monthly"), selected = "daily")
                           )
                    ),
                    p("This is where the text will appear. How much can I fit before the layout gets more messed up? I don't
                      know I'm going to keep going until it stops.")
           ),


           
           #The second tab
           tabPanel("Yearly Trends",
                    h3("Pickups in January for NYC: Yellow Taxis vs. For Hire Vehicles"),

                    plotOutput("yearly_trends"),
                    
                    #This will be to pick in whether you want to see 
                    #yellow taxi's, for-hire vehicles, or both                    
                    column(3, offset = 0, 
                           div(style = "font-size: 10px; padding: 0px 0px; margin:0%",
                               radioButtons("radioTab3", label = h5("Transportation Services"),
                                            choices = list("Taxi Trends" = "Yellow", "For Hire Vehicle Trends" = "FHV", 
                                                           "Both" = "both"), selected = "both")
                           )
                    ),
                    
                    #This will be for monthly range
                    column(4, offset = 1, 
                           div(style = "font-size: 10px; padding: 0px 0px; margin:0%", 
                               dateRangeInput("datesTab3", label = h5("Date Range"),
                                              start = as.Date("2015-01-01"), end =as.Date("2018-01-01"))
                           )
                    )
                    
           ),
           
           #The third tab
           tabPanel("Weekly Trends", 
                      mainPanel(
                        
                        h3("NYC Taxis vs For Hire Vehices - March 4th - 10th, 2018"),
      
                        plotOutput("example_week") # ,
                        
                        # h4("The Average Week"),
                        
                        # p("This is an example week.")
                      )
                    ),    
           
           
           #The fourth tab
           #The fourth tab
           tabPanel("Table",
                    sidebarLayout(
                      sidebarPanel(
                        h3("Quick Analysis"),
                        p("This table displays the total amount of For-Hire Vehicles and NYC taxis that were
                          used from January, 2018 to June, 2018. The columns are broken down by"),
                        tags$ul(
                          tags$li("Month"), 
                          tags$li("For-Hire Vehicles"), 
                          tags$li("Taxis")
                        ),
                        p("The amount of entries are limited to six values to stay within the scope of our questions.")
                        ),
                      mainPanel(
                        DT::dataTableOutput("monthlyTable")
                      )
           ),
           fluidRow(
             h3("Building the Data Frame"),
             p("When first imagining how to visualize the data we wished to portray from the NYC TLC it was 
               quickly understood that whatever we were about to do would have to require an immense amount of 
               data splicing and reconfiguration. Using the popular R packages of dplyr and ggplot in conjunction
               with each other the csv file slowly started to form itself into a usable and comapct data frame.") # ,
             # h3("Reconfiguration"),
             
             ## Here is where you can talk about how exactly you compacted the data Pierce.
             # p(""),
             # 
             # p("Use the button below to view the source code of our data reconstruction."),
             # actionButton("codeButton", "Source Code")
             # hidden(
             #   div(id='text_div',
             #       verbatimTextOutput("hiddenText")
             #   )
             # )
             )
           )
        )
    )
 )



