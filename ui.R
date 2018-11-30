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
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    
    # Show a plot of the generated distribution
    mainPanel(
       tabsetPanel(
         tabPanel("Plot", 
                  sidebarLayout(
                    sidebarPanel(
                      h3("Manipulate the Data")
                    ),
                    mainPanel(
                      plotOutput("dateMap"))
                    )
                  ),
         tabPanel("Visualization 1", plotOutput("")),
         tabPanel("Visualization 2", plotOutput("")),
         tabPanel("Summary", verbatimTextOutput("summary")),
         plotOutput("distPlot")
       )
    )
  )
))
