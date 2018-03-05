library(shiny)
source("server.R")
hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Jarod"),
                     #jarod's sidepannels/inputs here
                     fluidPage(
                       headerPanel('Political Rap Table'),
                       sidebarPanel(
                         selectInput(inputId  = "candidate",
                                     label = strong("Table by candidate"),
                                     choices = c("Donald Trump", "Hillary Clinton", "Ted Cruz", "Chris Christie", "Ben Carson", "Jeb Bush", "Mike Huckabee"),
                                     selected = "Donald Trump"),
                         checkboxGroupInput(inputId = "sent",
                                            label = "Sentiments to show:",
                                            choices = c("Negative Sentiments" = "negative",
                                                        "Neutral Sentiments" = "neutral",
                                                        "Positive Sentiments" = "positive"),
                                            selected = list("negative", "neutral", "positive")),
                         mainPanel(tableOutput("rapTable")
                         )
                       )
                     ),
                     
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
                                sidebarPanel(
                                  verbatimTextOutput("lyric")
                                ),
                                mainPanel(
                                  plotOutput("primaries", hover = "plot.hover")
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
                                                             "Ted Cruz", "Donald Trump"))
                                ),
                                mainPanel(
                                  plotOutput("politician.over.time")
                                )
                              
                              )
                     
                     ) 
            )
        )

