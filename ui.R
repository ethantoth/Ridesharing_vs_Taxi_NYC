
library(shiny)
library(DT)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "theme.css",

# Show a plot of the generated distribution
navbarPage("NYC Taxi and RideSharing",
           tabPanel("Home",
                    includeMarkdown("homeText.md")
            ),
           
           ## This is the first tab, with a line graph of number of pickups each day.
           ## A user can change the range of dates presented on the graph, add a
           ## trendline to the graph, and choose whether to see Taxi data,
           ## For Hire Vehicle data, or both.
           tabPanel("2018 Daily Trends", 
                    fluidRow(
                    
                      h3("Pickups for NYC Yellow Taxis vs For Hire Vehices"),
                      
                      #This will be to pick in whether you want to see 
                      #yellow taxi's, for-hire vehicles, or both
                      plotOutput("day_line_graph")
                    ),
                    fluidRow(
                       column(2, offset = 2, 
                              
                            ##add padding to seperate the widgets more
                             div(style = "font-size: 10px",
                                 radioButtons("radioTab2", label = h5("Transportation Services"),
                                              choices = list("Taxi Trends" = "taxi", "For Hire Vehicle Trends" = "FHV", 
                                                             "Both" = "both"), selected = "both")
                      )),
                      
                      #This will be for picking the daily date range 
                      column(3, 
                             div(style = "font-size: 10px", 
                                 dateRangeInput("datesTab2", label = h5("Date Range"),
                                                start = as.Date("2018-01-01"), end = as.Date("2018-07-01"))
                      
                                 )),
                      
                      #This is for a widget that either displays the trend line(s) or not
                      column(2,
                             div(style = "font-size: 10px",
                                 radioButtons("trendTab2", label = h5("Trend Line"),
                                              choices = list("Show Trend Line" = "show", 
                                                             "Don't Show Line" = "dont_show"), selected = "show"))
                             ),
                      column(1,
                             div(style = "font-size: 10px",
                               radioButtons("dailyTab2", label = h5("View data in:"),
                                            choices = list("Days" = "daily", "Months" = "monthly"), 
                                            selected = "daily"))

                          )
                      
                      
                    ),
                    fluidRow(h4("Every Pickup Between January and July, 2018"),
                             p("These are the sums of pickups in each year from 2015 to 2018.
                               The plot indicates a steady decline of taxi pickups, and
                               a steady rise in FHV pickups."))
           ),

           ## This is the second tab, that presents a bar graph containing pickup counts for
           ## the entire year, from 2015 to 2018. A user can change the months shown, and pick
           ## between Taxi data, For Hire Vehicle data, or both.
           
           tabPanel("Yearly Trends",
                    h3("Pickups in January for NYC: Yellow Taxis vs. For Hire Vehicles"),

                    plotOutput("yearly_trends"),
                    fluidRow(
                    #This will be to pick in whether you want to see 
                    #yellow taxi's, for-hire vehicles, or both                    
                    column(3, offset = 3,
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
                    )),
                    
                    fluidRow(
                    
                    h4("Every Pickup in 2015, 2016, 2017, and 2018"),
                    
                    p("These are the sums of pickups in each year from 2015 to 2018.
                      The plot indicates a steady decline of taxi pickups, and
                      a steady rise in FHV pickups.")
                    )
                    
           ),
           
           ## This is the third tab, that presents a static graph that represents
           ## the average number of pickups on each day of the week, Monday through
           ## Sunday, fom 2015 to 2018.
           
           tabPanel("Weekly Trends", 
                      mainPanel(
                        
                        h3("NYC Taxis vs For Hire Vehices - Sums of Weekdays in 2018"),
      
                        plotOutput("example_week") ,
                        fluidRow(
                        h4("The Average Week"),
                        
                        p("These are the average number of pickups in each day of the week. 
                          For Hire Vehicles appear to peak in popularity during the weekends,
                          Yellow Taxis, on the other hand, seem to be the opposite,
                          being more popular on weekdays than on weekends.")
                        )
                      )
                    ),    
           
           ## This is the fourth tab, that presents a summary of the data
           ## used in this app, as well as an analysis of that data.
           tabPanel("Data Table",
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
                        p("The amount of entries are limited to six values to 
                          stay within the scope of our questions.")
                        ),
                      mainPanel(
                        DT::dataTableOutput("monthlyTable")
                      )
           ),
           fluidRow(
             h3("Building the Data Frame"),
             p("When first imagining how to visualize the data we wished
                to portray from the NYC TLC it was quickly understood that
                whatever we were about to do would have to require an immense 
                amount of  data splicing and reconfiguration. Using the 
                popular R packages of dplyr and ggplot in conjunction with 
                each other the csv file slowly 
                started to form itself into a usable and comapct data frame.")
             )
           ),
           
           #This is the final conclusion tab. It renders a markdown file
           #which was created in atom.
           tabPanel("Conclusion",
                    includeMarkdown("conclusion.md")      
           )
        )
    )
 )





