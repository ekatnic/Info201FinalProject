library(shiny)
source("server.R")
hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Home Page",
                     fluidPage(
                        includeMarkdown("README.md")        
                     )
                     ),
                     tabPanel("Jarod",
                     #jarod's sidepannels/inputs here
                     fluidPage(
                       headerPanel('Political Rap Table'),
                       sidebarPanel(
                         selectInput(inputId  = "candidate2",
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
                     )
                     ),
                     
                     tabPanel("Abbey",
                     #abbey's sidepannels/inputs here
                     fluidPage(
                       titlePanel("Sentiment Over Time"),
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("sentiment", "Choose a sentiment:",
                                       choices = c("negative", "positive", "neutral")),
                          sliderInput("range", "Pick Time Range:", min = 1989,
                                      max = 2016, value = c(1996, 2016), sep = "")
                        ),
                         mainPanel(
                           plotOutput("barPlot")
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
                     tabPanel("EthanSentiment",
                              sidebarLayout(
                                sidebarPanel(
                                  sliderInput("year.range", h3("Choose Time Frame"), 
                                              min = 1989, max=2016, value= c(1989, 2016) , sep="")
                                ),
                                mainPanel(
                                  plotOutput("trump.over.time"),
                                  plotOutput("clinton.over.time")
                                )
                              
                              )
                     
                     ),
                     tabPanel("EthanSubject",
                              sidebarLayout(
                                sidebarPanel(
                                  selectInput("candidate", "Choose Candidate",
                                              choices = list("Donald Trump", "Hillary Clinton", "Jeb Bush",
                                                             "Bernie Sanders", "Ben Carson", "Ted Cruz",
                                                             "Mike Huckuckabee", "Chris Christie"))
                                    
                                  ),
                                mainPanel(
                                  plotOutput("subject.matter")
                                )
                              )
                     )
            )
        )

