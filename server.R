library(shiny)
library(dplyr)
library(ggplot2)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$politician.over.time <- renderPlot({
    candidate.data <- hip.hop.data %>% filter(candidate == input$candidate) 
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_dotplot(aes(fill = sentiment)) +
      xlab("Year") +
      ylab("Count") +
      ggtitle("Lyrical Sentiment Over Time") +
      theme(legend.position = "top", plot.title = element_text(hjust = 0.5))
  })
  
  output$mentions <- renderPlot({
    ggplot(hip.hop.data, aes(album_release_date)) + 
      geom_dotplot(aes(fill = candidate)) +
      theme(legend.position = "top") +
      labs(title = "Candidate Sentiment Over Time", x = "Date", y = "Frequency") 
  })
  
  output$lyric <- renderPrint({
    lyric.info <- nearPoints(hip.hop.data, input$plot.hover, yvar = NULL)
    req(nrow(lyric.info) != 0)
    print(lyric.info, row.names = FALSE)
  })
  
  output$scatterPlot <- renderPlot({
    #proportion of sentiment ncols = 216
    # need to group by year, then divide to find frequency
    new_data <- hip.hop.data %>% filter(sentiment == input$sentiment) %>% select(album_release_date)
    ggplot(new_data, aes(x = new_data$album_release_date, y = factor(album_release_date))) + geom_col(color = "green", fill = "blue") +
      xlab("year") + ylab(input$sentiment) + ggtitle(paste0("Frequency of ", input$sentiment, " Lyrics Over Time"))
  })
}



