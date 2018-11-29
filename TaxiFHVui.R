library(shiny)

ui <- fluidPage(
  titlePanel("Trend Data: Taxi and For-Hire Vehicles in New York City"),
  
  plotOutput("lineChart"),
  
  hr(),
  
  fluidRow(
    
    #This is for the radio buttons that select either Taxi, FHV, or Both
    #Graph should be initialy is set to both
    column(3,
      h4("Adjust for Taxi or For-Hire Vehicle Trends"),
        uiOutput("rideTrends"),
          radioButtons("radio", label = h3("Select Taxi or For-Hire Vehicle"),
                   choices = list("Taxi Trends" = "Taxi", "For Hire Vehicle Trends" = "FHV", 
                                  "Both" = "TaxiFHV"), selected = "TaxiFHV")
      ),
    #This is for the user to be able to pick a range of dates. I have the code for how to do this
    #in my assignment 8 that I can send
    column(4, offset = 1,
      uiOutput("rangeOfDates")
    ),
    
    #This is to draw a straight vertical line within the date range that represents the average. Look at link
    #https://janzilinsky.com/r-shiny-app-chart-tutorial-subsamples/ to see what I mean.
    #
    column(5, offset = 1, 
         selectInput("vertical","Show vertical line in month:", 
                       choices = unique(data$month), multiple=TRUE)
   )
  )
)
