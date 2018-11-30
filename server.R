#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  ## Manipulatable summary text that changes with user input as the widgets of the main and side plots are altered. 
  output$summary <- renderText({
    paste("Using the provided UFO data, this map of the United States displays all UFO's that were shaped as a", input$select,
          "on the date of", input$dates1, "that were observed flying in the sky at the position on the map.")
  })
  
})
