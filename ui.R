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
  
  ## Function that imports a CSS font to use in the header of the main page
  tags$head(
    tags$style(HTML("
       @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
    "))
    ),
  
  # Header Panel that displays the CSS header with new font
  headerPanel(
    h1("NYC Taxi vs. Ridesharing", 
       style = "font-family: 'Lobster', cursive;
       font-weight: 500; line-height: 1.1; 
    color: #000000;")
  ),
  
  # Sidebar with a slider input for number of bins 
  fluidRow(
    
    # Show a plot of the generated distribution
    mainPanel(
       tabsetPanel(
         tabPanel("Plot", plotOutput("dateMap")),
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
))
