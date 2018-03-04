library(shiny)
library(dplyr)
library(ggplot2)
library(wordcloud)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$mentions <- renderPlot({
    
  })
  
  terms <- reactive ({
    data <- hip.hop.data %>% filter(candidate == input$politician) %>% 
      select(line)
  })
  output$wordPlot <- renderPlot({
    lyrics <- terms()
    wordcloud_rep(names(lyrics), lyrics, scale = c(4, 0.5),
                  min.freq = input$freq, max.words = input$max,
                  colors = brewer.pal(8, "Dark2"))
  })
}



