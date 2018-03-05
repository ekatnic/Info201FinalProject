library(shiny)
library(dplyr)
library(ggplot2)
#install.packages("ggthemes")
library(ggthemes)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$politician.over.time <- renderPlot({
    candidate.data <- hip.hop.data %>% filter(candidate == input$candidate) 
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_histogram(aes(fill = sentiment)) +
      xlab("Year") +
      xlim(1989, 2015) +
      ylab("Count") +
      ylim(0, 35) +
      ggtitle("Lyrical Sentiment Over Time") +
      theme(legend.position = "top", plot.title = element_text(hjust = 0.5))
  })
  
  output$primaries <- renderPlot({
    ggplot(hip.hop.data, aes(x = album_release_date)) +
      geom_dotplot(aes(fill = candidate), binwidth = 1, method = "histodot") +
      ylim(0, 50) +
      labs(title = "Candidates Mentioned Per Year") +
      theme_fivethirtyeight()+
      scale_fill_brewer(palette = "Set3")
  })
  
  output$lyric <- renderPrint({
    lyric.info <- nearPoints(hip.hop.data, input$plot.hover, yvar = NULL) 
    req(nrow(lyric.info) != 0)
    print(lyric.info, row.names = FALSE)
  })
  
  output$scatterPlot <- renderPlot({
    #proportion of sentiment ncols = 216
    # need to group by year, then divide to find frequency
    year_freq <- hip.hop.data %>% group_by(album_release_date) %>% 
        summarize(num_per_year = n(), 
                  num_unique = count(input$sentiment),
                  proportion = (num_unique / num_per_year) * 100,
                  year = album_release_date)
    ggplot(year_freq, aes(x = year, y = proportion)) + geom_bar(color = "green") + xlab("year") + ylab(input$sentiment) +
      ggtitle(paste0("Percent of ", input$sentiment, " Lyrics Over Time"))
  })
}


#num_unique = count(vars = input$sentiment),
