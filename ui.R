library(shiny)
source("server.R")

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Jarod"),
                     #jarod's sidepannels/inputs here
                     
                     tabPanel("Abbey",
                     #abbey's sidepannels/inputs here
                     fluidPage(
                       titlePannel("Word Cloud"),
                       sidebarLayout(
                         sidebarPannel(
                           selectInput("politician", "Choose a politician:",
                                       choices = c("Mike Huckabee", "Jeb Bush", "Ben Carson",
                                                   "Chris Christie", "Ted Cruz", "Hillary Clinton",
                                                   "Donald Trump")),
                           sliderInput("freq",
                                       "Minimum Frequency:",
                                       min = 1, max = 10, value = 5),
                           sliderInput("max",
                                       "Maximum Number of Words:",
                                       min = 1, max = 20, value = 10)
                         ),
                         mainPanel(
                           plotOutput("wordPlot")
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
                     ),
                     
                     tabPanel("Ethan")
                     #ethan's sidepannel/inputs here
                     tabPanel("Ethan",
                              sidebarLayout(
                                sidebarPanel(
                                  
                                )
                                mainPanel(
                                  plotOutput("politician.over.time")
                                )
                              
                              )
                    
                     
))

