library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

our.server <- function(input,output) {
  
  hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)
  
  #creates lyrical data table
  output$rapTable <- renderTable({
    #filters candidate table according to selected candidate
    candidate.table <- hip.hop.data %>% filter(candidate == input$candidate2)
    neg.table <- if (input$neg == TRUE) {
      candidate.table %>% filter(sentiment == "negative")
    }
    neu.table <- if (input$neu == TRUE) {
      candidate.table %>% filter(sentiment == "neutral")
    }
    pos.table <- if (input$pos == TRUE) {
      candidate.table %>% filter(sentiment == "positive")
    }
    #combines smaller tables to a final table with all selected sentiments
    FinalTable <- rbind(neg.table, neu.table, pos.table)
    FinalTable <- select(FinalTable, candidate, song, artist, sentiment, theme, line)
  }, striped = TRUE, bordered = TRUE, spacing = 'm', width = '90%')
  
   #creates summary dotplot of candidate mentions
   output$mentions <- renderPlotly({
     summary.dotplot <- ggplot(hip.hop.data, aes(album_release_date)) +
      geom_dotplot(aes(fill = candidate), method = "dotdensity", binwidth = 1.5) +
      scale_x_continuous(breaks = seq(min(hip.hop.data$album_release_date), max(hip.hop.data$album_release_date), by = 1)) +
      theme(axis.text.x = element_text(angle = 65), axis.text.y = element_blank(), axis.ticks.y = element_blank(),
            axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5)) +
      ylim(0, 17) +
      labs(title = "Candidate Mentions Over Time", x = "Year", y = "Count") +
      scale_fill_brewer(palette = "Paired")
     ggplotly(summary.dotplot)
     plotly_build(summary.dotplot)
     text.to.show <- paste("Candidate: ", hip.hop.data$candidate, ",   ", 
                           "Artist: ", hip.hop.data$artist,
                           "\nLyric: '", hip.hop.data$line, "'", sep = "")
     style(summary.dotplot, text = text.to.show, hoverinfo = "text")
  })
  
   #creates rapper bar plot
  output$rappers <- renderPlot({
    #filters for each artist checkbox option 
    rapper.data <- hip.hop.data %>%
      filter(candidate %in% input$politician) %>% 
      group_by(artist) %>%
      summarise(rapper_count = n()) %>%
      arrange(desc(rapper_count)) %>%
      head(10)
    
    #creates barplot of which artists mention selected politicians the most
    ggplot(rapper.data, aes(artist, rapper_count)) +
      geom_bar(aes(fill = artist), stat = "identity") +
      labs(title = "Artist Mentions of Politicians", x = "Artist", y = "Count") +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5),
            axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
      scale_fill_brewer(palette = "Paired")
  })
  
  #creates sentiment trend scatterplot
  output$barPlot <- renderPlot({
    #filters data to specified range, calculates proportion of sentiment by year, then filters by specified sentiment
    final_table <- hip.hop.data %>% filter((album_release_date >= input$range[1]) &(album_release_date <= input$range[2])) %>% 
                group_by(album_release_date) %>% 
                mutate(n_x = n()) %>% 
                group_by(album_release_date, sentiment) %>% 
                summarize(percent = (n() / first(n_x))) %>% 
                filter(sentiment == input$sentiment) 
    
    #sets color for bar-graph based on sentiment
    set_color <- "red"
    if (input$sentiment == "neutral") {
      set_color <- "blue"
    } else if (input$sentiment == "positive") {
      set_color <- "green3"
    }
  
    #plots table with line of fit
    ggplot(final_table, aes(x = final_table$album_release_date, y = final_table$percent)) + geom_point(color = set_color, size = 3) + 
      geom_smooth(method = 'lm', formula = y~x) +
      xlab("Year") + 
      ylab("Percent") + 
      ggtitle(paste0("Proportion of ", toupper(substring(input$sentiment, 1,1)), substring(input$sentiment, 2), " Lyrics Over Time")) +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5))
  })
  
  #Helper function for sentiment graphs to plot sentiment based on candidate name
  sentiment.print <- function(candidate.name){
    #Filter by candidate name and make range inclusive
    adjustedRange <- c(input$year.range[1]-1, input$year.range[2]+1)
    candidate.data <- hip.hop.data %>% filter(candidate == candidate.name) 
    #Plot graph
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_histogram(aes(fill = sentiment), na.rm = TRUE) +
      scale_fill_manual(values=c("red", "blue", "green3")) +
      xlab("Year") +
      xlim(adjustedRange) +
      ylab("Count") +
      ylim(0, 35) +
      ggtitle(paste(candidate.name, "Mentions Over Time")) +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5),
            legend.position = "top")
  }
  
  #Trump sentiment over time graph
  output$trump.over.time <- renderPlot({
    trump.graph <- sentiment.print("Donald Trump")
    print(trump.graph)
  })
  
  #Clinton sentiment over time graph
  output$clinton.over.time <- renderPlot({
    clinton.graph <- sentiment.print("Hillary Clinton")
    print(clinton.graph)
  })
  
  #Subject matter over time graph
  output$subject.matter <- renderPlot({
    #filter by candidate and remove N/A themes
    candidate.data <- hip.hop.data %>% filter(candidate == input$candidate, theme != "N/A")
    #plot histogram
    ggplot(candidate.data, aes(x=album_release_date)) +
      geom_histogram(aes(fill = theme), na.rm=TRUE) +
      scale_fill_manual(values=c("hotel" = "orange", "money" = "green3", "personal" = "blue",
                                 "political" = "red", "power" =" purple", "sexual" = "yellow",
                                 "The Apprentice" = "black", "orange")) +
      ggtitle("Subject Matter Over Time") +
      xlab("Year") +
      ylab("Count") +
      theme(axis.title = element_text(size = 18), plot.title = element_text(size = 22, face = "bold", hjust = .5))
  })
}

