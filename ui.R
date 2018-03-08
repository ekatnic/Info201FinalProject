library(shiny)
source("server.R")
library("markdown")

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Home Page",
                     fluidPage(
                        includeMarkdown("README.md")        
                     )
                     ),
                     # lyric data table
                     tabPanel("Lyric Data Table",
                     fluidPage(
                       titlePanel("What Rappers are Saying About Politicians"),
                       fluidRow(
                         # creates widget that chooses candidate
                         selectInput(inputId  = "candidate2",
                                     label = strong("Pick a candidate:"),
                                     choices = c("Donald Trump", "Hillary Clinton", "Ted Cruz", "Chris Christie", "Ben Carson", "Jeb Bush", "Mike Huckabee"),
                                     selected = "Donald Trump"),
                         # creates widget that chooses sentiment
                         checkboxInput("neg", "Negative Sentiments", TRUE),
                         checkboxInput("neu", "Neutral Sentiments", FALSE),
                         checkboxInput("pos", "Positive Sentiments", FALSE),
                         mainPanel(tableOutput("rapTable"), width = 12
                         )
                       )
                     )
                     ),
                     
                     # Candidates mentioned over time tab
                     tabPanel("Candidate Mentions",
                              fluidPage(
                                titlePanel("Mentions of 2016 Primary Candidates"),
                                  sidebarLayout(
                                    sidebarPanel(
                                      p("This plot gives a visual representation of how often primary candidates are
                                        mentioned over the past 25 years. Noticeably, Hillary Clinton (pink) and Donald Trump
                                        (green) are the most frequently mentioned. Hover over a data point to see the artist
                                        and lyric involving the candidate!")
                                    ),
                                    mainPanel(
                                      plotlyOutput("mentions")
                                    )
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
                                                                   "Mike Huckabee", "Chris Christie"), 
                                                       selected = hip.hop.data$candidate),
                                    p("This plot allows the user to choose politicians of interest and see which artists
                                      are mentioning them most frequently. When considering all of the politicians, Rick Ross and 
                                      Nas are top artists.")
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
                                      max = 2016, value = c(1996, 2016), sep = ""),
                          p("This plot shows the proportion of sentiment in rap lyrics over time. Notice that over the past
                            20 years, the proportion of negative lyrics has increased, while positive lyrics has
                            decreased.")
                        ),
                         mainPanel(
                           plotOutput("barPlot")
                         )
                       )
                     )
                     ),

   
                     # Sentiment of Trump and Clinton Over Time
                     tabPanel("Feelings Toward Trump & Clinton", 
                              titlePanel("Sentiment Toward Trump & Clinton"),
                              sidebarLayout(
                                sidebarPanel(
                                  # creates widget that chooses year
                                  sliderInput("year.range", h3("Choose Time Frame"), 
                                              min = 1989, max=2016, value= c(1989, 2016) , sep=""),
                                  p("These plots show how the sentiment of mentions involving Donald Trump and Hillary Clinton
                                    have shifted over the past 25 years. Trump's sentiment has become more negative following 
                                    his entrance into politics, while Clinton's had a spike of negativity during her 2008 campaign
                                    but has largely has remained neutral. Scroll down to see Clinton's plot.")
                                ),
                                mainPanel(
                                  plotOutput("trump.over.time"),
                                  plotOutput("clinton.over.time")
                                )
                              
                              )
                     
                     ),
                     # Subject Matter of Political References
                     tabPanel("Subject of Lyrics",
                              titlePanel("Subject Matter of References"),
                              sidebarLayout(
                                sidebarPanel(
                                  # Choose candidate to plot
                                  selectInput("candidate", "Choose Candidate",
                                              choices = list("Donald Trump", "Hillary Clinton", "Jeb Bush",
                                                             "Bernie Sanders", "Ben Carson", "Ted Cruz",
                                                             "Mike Huckuckabee", "Chris Christie")),
                                  p("This plot shows the subject matter of rap lyrics involving politicians over the past
                                    25 years. For Donald Trump, rap lyrics involving his name were largely about money and
                                    his hotel brand, Trump Towers, but the subject abruptly shifted to politics following his 
                                    presidential run.")
                                    
                                  ),
                                mainPanel(
                                  plotOutput("subject.matter")
                                )
                              )
                     )
            )
        )
shinyUI(my.ui)
