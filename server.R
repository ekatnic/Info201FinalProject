library(shiny)
library(dplyr)
library(ggplot2)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$politician.over.time <- renderPlot({
    candidate.data <- hip.hop.data %>% filter(candidate == input$candidate)
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_dotplot(aes(fill = sentiment)) +
      theme(legend.position = "top")
  })
  
  output$mentions <- renderPlot({
    ggplot(hip.hop.data, aes(album_release_date)) + 
      geom_dotplot(aes(fill = candidate)) +
      theme(legend.position = "top") +
      labs(title = "Mentions of 2016 Primary Candidates", x = "Date", y = "Frequency") 
  })
  
  output$lyric <- renderPrint({
    lyric.info <- nearPoints(hip.hop.data, input$lyric)
    req(nrow(brand.info) != 0)
    print(lyric.info, row.names = FALSE)
  })
  
  output$scatterPlot <- renderPlot({
    if(get(input$party) == "Democrat") {
      party.data <- hip.hop.data %>% filter(candidate == "Hillary Clinton" | "Bernie Sanders") %>% 
        select(sentiment)
    } else {
      party.data <- hip.hop.data %>% filter((candidate != "Hillary Clinton") & (candidate != "Bernie Sanders")) %>% 
        select(sentiment)
    }
    

  })
}



