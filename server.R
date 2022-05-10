library(fpp3)
library(shiny)
library(tsibble)

Trout <- read.csv('multiTimeline.csv')
#Trout <- read.csv('Midterm/multiTimeline.csv')
Trout$Month <- yearmonth(Trout$Month)
Trout <- tsibble(Trout)
server <- function(input, output){
  fit <- Trout %>% 
    model(TSLM(Score ~ trend() + season()))
  output$predict <- renderPlot({fit %>% 
      forecast() %>% 
      autoplot(Trout)})
  output$text2 <- renderText('This is the prediction of what the model believes will be his upcoming search results.')
  output$value <- renderPrint({ input$radio })
  output$text <- renderText({
    if(input$radio == 'General Search Trend'){
      'This is the unaltered search result trend for Mike Trout. The score represents how commonly he was being searched for at any given time. The score of 100 was when he hit his search peak. This was right at the time Trout signed his extension with the Angels making him the highest paid baseball player ever.'}
    else if(input$radio == 'Classical Decomposition'){
      'This graph explains in a decomposed way the trends of the search results. We can see over time there is a trend up in search results, it spikes in 2019 after he signed his record breaking contract, and then begins to trend down from the massive height he temporarly hit. We can also see that there is seasonality in the searches, with the peak of each season being around the beginning of each MLB season. And the bottom graph shows the randomness of the searches, and the large spike is the exact time he inked his record contract.'}
    else if(input$radio == 'Seasonality'){
    'This graph represents the seasonality of searches. Each color represents a year, and for the most part, he gets the majority of his searches throughout the year in July, which is when the All Star Game occurs. Notice he is not searched up too often around October, this is because the Los Angeles Angels have failed to put together a playoff caliber roster around him for over a decade.'}
    else if(input$radio == 'Autocorrelation') {
    'This graph represents correlation. Because all the lag graphs have a positive linear in some sense (none of them are completely random, we can tell there is some correlation of when people are searching for Mike Trout, however because he is so good at baseball, people tend to search for him in multiple spikes during the year.'}
    else if(input$radio == 'Forecast'){
      'This is the prediction of what the model believes will be his upcoming search results.'}
    else if(input$radio == 'Naive'){'This is the naive model'}
    })
  output$Plot <- renderPlot({
    if(input$radio == 'General Search Trend'){
      autoplot(Trout, col = 'red')}
    else if(input$radio == 'Classical Decomposition'){
      Trout %>%
        model(classical_decomposition(Score, type = 'additive')) %>% 
        components() %>%
        autoplot()
    }
    else if(input$radio == 'Seasonality'){
      gg_season(Trout)
    }
    else if(input$radio == 'Autocorrelation') {
      gg_lag(Trout, geom = 'point', lags = c(1,5,10,20))
    }
    else if(input$radio == 'Forecast'){
      fit %>% 
        forecast() %>% 
        autoplot(Trout)}
    else if(input$radio == 'Naive Model'){
      Trout %>% 
        model(NAIVE(Score)) %>%
        forecast(h = 12) %>% 
        autoplot(Trout)
    }
    else if(input$radio == 'Mean Model'){
      Trout %>% 
        model(MEAN(Score)) %>%
        forecast(h = 12) %>% 
        autoplot(Trout)
    }
    else if(input$radio == 'Drift Model'){
      Trout %>% 
        model(RW(Score ~ drift())) %>% 
        forecast(h= 12) %>% 
        autoplot(Trout)
    }
    else if(input$radio == 'Seasonal Naive'){
      Trout %>% 
        model(SNAIVE(Score ~ lag("year"))) %>% 
        forecast(h= 12) %>% 
        autoplot(Trout)
    }
    else if(input$radio == 'Holts'){
      Trout %>% 
        model(ETS(Score ~ error("A") + trend("A") + season("N"))) %>% 
        forecast(h= 12) %>% 
        autoplot(Trout)
    }
    else if(input$radio == 'Holts Winter'){
      Trout %>% 
        model(ETS(Score ~ error("A") + trend("A") + season("A"))) %>% 
        forecast(h= 12) %>% 
        autoplot(Trout)q
    }
}
    


)
}
