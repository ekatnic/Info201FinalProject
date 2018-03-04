library(shiny)
source("server.R")

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Jarod"),
                     #jarod's sidepannels/inputs here
                     
                     tabPanel("Abbey",
                     #abbey's sidepannels/inputs here
                     fluidPage(
                       titlePanel("Political Party Over Time"),
                       sidebarLayout(
                         sidebarPanel(
                           selectInput("party", "Choose a political party:",
                                       choices = c("Democrat", "Republican"))
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
                                ),
                                mainPanel(
                                  plotOutput("politician.over.time")
                                )
                              
                              )
                     
                     ) 
          )
)

