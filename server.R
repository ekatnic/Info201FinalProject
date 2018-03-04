library(shiny)
library(dplyr)
library(ggplot2)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$mentions <- renderPlot({
    primary.candidates <- hip.hop.data %>% 
      filter()
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



