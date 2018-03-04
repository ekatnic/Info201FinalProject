library(shiny)
library(dplyr)
library(ggplot2)
library(wordcloud)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$politician.over.time <- renderPlot({
    candidate.data <- hip.hop.data %>% filter(candidate == input$candidate)
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_dotplot(aes(fill = sentiment)) +
      theme(legend.position = "top")
  })
  
  output$mentions <- renderPlot({
    primary.candidates <- hip.hop.data %>% 
      filter()
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



