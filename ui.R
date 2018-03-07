library(shiny)
source("server.R")
hip.hop.data <- read.csv("data/genius_hip_hop_lyrics.csv", stringsAsFactors = FALSE)

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Home Page",
                     fluidPage(
                        includeMarkdown("README.md")        
                     )
                     ),
                     # lyric data table
                     tabPanel("Lyric Data Table",
                     fluidPage(
                       headerPanel('Political Rap Data: Sort candidates and Rap Sentiments'),
                       sidebarPanel(
                         # creates widget that chooses candidate
                         selectInput(inputId  = "candidate2",
                                     label = strong("Table by candidate"),
                                     choices = c("Donald Trump", "Hillary Clinton", "Ted Cruz", "Chris Christie", "Ben Carson", "Jeb Bush", "Mike Huckabee"),
                                     selected = "Donald Trump"),
                         # creates widget that chooses sentiment
                         checkboxInput("neg", "Negative Sentiments", TRUE),
                         checkboxInput("neu", "Neutral Sentiments", TRUE),
                         checkboxInput("pos", "Positive Sentiments", TRUE),
                         mainPanel(tableOutput("rapTable")
                         )
                       )
                     )
                     ),
                     
                     # Candidates mentioned over time tab
                     tabPanel("Candidate Mentions",
                              fluidPage(
                                titlePanel("Mentions of 2016 Primary Candidates"),
                                mainPanel(
                                  plotlyOutput("mentions")
                                )
                              )
                     ),
                     # Rappers Commentating on politics
                     tabPanel("Rappers Who Talk Politics",
                              fluidPage(
                                titlePanel("Rappers Most Frequently Mentioning Politicians"),
                                sidebarLayout(
                                  sidebarPanel(
                                    # creates checkbox to choose politician referenced
                                    checkboxGroupInput("politician", "Choose a Candidate:",
                                                       choices = c("Donald Trump", "Hillary Clinton", "Jeb Bush",
                                                                   "Bernie Sanders", "Ben Carson", "Ted Cruz", 
                                                                   "Mike Huckabee", "Chris Christie"))
                                  ),
                                  mainPanel(
                                    plotOutput("rappers")
                                  )
                                )
                              )
                     ),
                     # sentiment over time graph
                     tabPanel("Lyrical Sentiment Trend",
                     fluidPage(
                       titlePanel("Sentiment Over Time"),
                       sidebarLayout(
                         sidebarPanel(
                           # creates a select box widget that allows the user to select a sentiment
                           selectInput("sentiment", "Choose a sentiment:",
                                       choices = c("negative", "positive", "neutral")),
                           # creates a slider widget that allows the user to select a time frame of their choice
                           # the slider is set between 1996 and 2016
                          sliderInput("range", "Pick Time Range:", min = 1989,
                                      max = 2016, value = c(1996, 2016), sep = "")
                        ),
                         mainPanel(
                           plotOutput("barPlot")
                         )
                       )
                     )
                     ),

   
                     # Sentiment of Trump and Clinton Over Time
                     tabPanel("Feelings Toward Trump & Clinton",
                              sidebarLayout(
                                sidebarPanel(
                                  # creates widget that chooses year
                                  sliderInput("year.range", h3("Choose Time Frame"), 
                                              min = 1989, max=2016, value= c(1989, 2016) , sep="")
                                ),
                                mainPanel(
                                  plotOutput("trump.over.time"),
                                  plotOutput("clinton.over.time")
                                )
                              
                              )
                     
                     ),
                     # Subject Matter of Political References
                     tabPanel("Subject of Lyrics",
                              sidebarLayout(
                                sidebarPanel(
                                  # Choose candidate to plot
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

