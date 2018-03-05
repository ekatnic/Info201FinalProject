library(shiny)
library(dplyr)
library(ggplot2)
#install.packages("ggthemes")
library(ggthemes)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  output$trump.over.time <- renderPlot({
    adjustedRange <- c(input$year.range[1]-1, input$year.range[2]+1)
    candidate.data <- hip.hop.data %>% filter(candidate == "Donald Trump") 
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_histogram(aes(fill = sentiment), na.rm = TRUE) +
      scale_fill_manual(values=c("red", "blue", "green3")) +
      xlab("Year") +
      xlim(adjustedRange) +
      ylab("Count") +
      ylim(0, 35) +
      ggtitle("Donald Trump Mentions Over Time") +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5),
            legend.position = "top")
  })
  
  output$clinton.over.time <- renderPlot({
    adjustedRange <- c(input$year.range[1]-1, input$year.range[2]+1)
    candidate.data <- hip.hop.data %>% filter(candidate == "Hillary Clinton") 
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_histogram(aes(fill = sentiment), na.rm = TRUE) +
      scale_fill_manual(values=c("red", "blue", "green3")) +
      xlab("Year") +
      xlim(adjustedRange) +
      ylab("Count") +
      ylim(0, 35) +
      ggtitle("Hillary Clinton Mentions Over Time") +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5), 
            legend.position = "top")
  })
  
  output$subject.matter <- renderPlot({
    candidate.data <- hip.hop.data %>% filter(candidate == input$candidate, theme != "N/A")
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_histogram(aes(fill = theme), na.rm=TRUE) +
      scale_fill_manual(values=c("hotel" = "yellow2", "money" = "green3", "personal" = "blue",
                                 "political" = "red", "power" =" purple", "sexual" = "orange",
                                 "The Apprentice" = "black", "orange")) +
      ggtitle("Subject Matter Over Time") +
      xlab("Year") +
      ylab("Count") +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5))
    
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
    #filters data to specified range, calculates proportion of sentiment by year, then filters by specified sentiment
    final_table <- hip.hop.data %>% filter((album_release_date >= input$range[1]) &(album_release_date <= input$range[2])) %>% 
                group_by(album_release_date) %>% 
                mutate(n_x = n()) %>% 
                group_by(album_release_date, sentiment) %>% 
                summarize(percent = (n() / first(n_x))) %>% 
                filter(sentiment == input$sentiment) 
    
    #plots table with line of fit
    ggplot(final_table, aes(x = final_table$album_release_date, y = final_table$percent)) + geom_col(fill = "purple") + 
      geom_smooth(method = 'lm', formula = y~x) +
      xlab("Year") + 
      ylab("Percent") + 
      ggtitle(paste0("Proportion of ", toupper(substring(input$sentiment, 1,1)), substring(input$sentiment, 2), " Lyrics Over Time")) +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5))
  })
  
    #Sort candidate -working
  output$rapTable <- renderTable({
      hip.hop.data %>% filter(candidate == input$candidate) %>% filter(sentiment == input$sent)
  })
    #Sort sentiment almost working
}
