library(shiny)
source("server.R")
hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Jarod"),
                     #jarod's sidepannels/inputs here
   
                     tabPanel("Abbey",
                     #abbey's sidepannels/inputs here
                     fluidPage(
                       titlePanel("Sentiment Over Time"),
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("sentiment", "Choose a sentiment:",
                                       choices = c("neutral", "negative", "positive"))
                         ),
                         mainPanel(
                           plotOutput("scatterPlot")
                         )
                       )
                     )
                     ),

                     tabPanel("Rasik",
                              fluidPage(
                                titlePanel("Mentions of 2016 Primary Candidates"),
                                mainPanel(
                                  plotOutput("mentions", hover = "plot.hover"),
                                  verbatimTextOutput("lyric")
                                )
                               )
                              ),
   
                     #ethan's sidepannel/inputs here
                     tabPanel("Ethan",
                              sidebarLayout(
                                sidebarPanel(
                                  selectInput("candidate", label = h3("Choose a Candidate"),
                                              choices = list("Ben Carson","Bernie Sanders", "Chris Christie",
                                                             "Hillary Clinton", "Jeb Bush", "Mike Huckabee",
                                                             "Ted Cruz"))
                                ),
                                mainPanel(
                                  plotOutput("politician.over.time")
                                )
                              
                              )
                     
                     ) 
            )
        )

