library(shiny)
library(dplyr)
library(ggplot2)
#install.packages("ggthemes")
library(ggthemes)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$politician.over.time <- renderPlot({
    adjustedRange <- c(input$yearRange[1]-1, input$yearRange[2]+1)
    candidate.data <- hip.hop.data %>% filter(candidate == input$candidate) 
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_histogram(aes(fill = sentiment), na.rm = TRUE) +
      xlab("Year") +
      xlim(adjustedRange) +
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
    #making final table to be plotted
    #1989 - 2016
    final_table <- hip.hop.data %>% filter((album_release_date >= input$range[1]) &(album_release_date <= input$range[2])) %>% 
                group_by(album_release_date) %>% 
                mutate(n_x = n()) %>% 
                group_by(album_release_date, sentiment) %>% 
                summarize(percent = (n() / first(n_x)) * 100) %>% 
                filter(sentiment == input$sentiment) 
    
    #plotting table
    ggplot(final_table, aes(x = final_table$album_release_date, y = final_table$percent)) + geom_col(fill = "green") + xlab("year") + 
      geom_smooth(method = 'lm', formula = y~x) + ylab(input$sentiment) + ggtitle(paste0("Percent of ", input$sentiment, " Lyrics Over Time"))
  })
  
    #Sort candidate -working
  output$rapTable <- renderTable({
      hip.hop.data %>% filter(candidate == input$candidate) %>% filter(sentiment == input$sent)
  })
    #Sort sentiment almost working
}


#num_unique = count(vars = input$sentiment),
