
titlePanel("Welcome to my shiny app! To use features, click below")

ui <- fluidPage(
          titlePanel("Welcome to my shiny app! To use features, click below"),
          radioButtons("radio", label = h3("Choose a graph to show Mike Trout Search Stastistics"),
               choices = c("General Search Trend" , "Classical Decomposition", 
                           "Seasonality", 'Autocorrelation', 'Forecast'), 
               selected = "General Search Trend"),
  hr(),
  plotOutput('Plot'),
  textOutput("text"),
  titlePanel("")
)

