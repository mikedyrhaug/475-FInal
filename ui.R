
titlePanel("Welcome to my shiny app! To use features, click below")

ui <- fluidPage(
          titlePanel("Welcome to my shiny app! To use features, click below"),
          selectInput("radio", label = h3("Select which model you would like to see"), 
                      choices = list("General Search Trend" , "Classical Decomposition", "Seasonality", 'Autocorrelation', 'Forecast'), 
                      selected = "General Search Trend"),
          
          
      #   radioButtons("radio", label = h3("Choose a graph to show Mike Trout Search Stastistics"),
      #        choices = c("General Search Trend" , "Classical Decomposition", 
      #                    "Seasonality", 'Autocorrelation', 'Forecast'), 
      #        selected = "General Search Trend"),
  hr(),
  plotOutput('Plot'),
  textOutput("text"),
  fluidRow(column(3, verbatimTextOutput("value")))
  
  #titlePanel("")
)

