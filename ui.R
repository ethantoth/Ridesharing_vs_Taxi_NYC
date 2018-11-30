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
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  plotOutput(""),
  
  fluidRow(
    #This will be to pick
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
           selectInput("","Show vertical line in month:", 
                       choices = unique(""), multiple=TRUE)
           )
    ),
    
    #This will be for date range
    column(5, offset = 2, 
           div(style = "font-size: 10px; padding: 0px 0px; margin:15%",
               uiOutput("")
           )
    ),
    
        
    
         tabPanel("Visualization 1", plotOutput("")),
         tabPanel("Visualization 2", plotOutput("")),
         tabPanel("Summary", verbatimTextOutput("summary")),
         plotOutput("distPlot")
       )
    )
  )

