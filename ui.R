library(shiny)
source("server.R")

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Jarod"),
                     #jarod's sidepannels/inputs here
                     
                     tabPanel("Abbey"),
                     #abbey's sidepannels/inputs here
                     
                     tabPanel("Rasik"),
                     fluidPage(
                       titlePanel("Mentions of 2016 Primary Candidates"),
                       
                       mainPanel(
                         plotOutput("mentions", hover = "plot.hover")
                       )
                     ), 
                     
                     tabPanel("Ethan")
                     #ethan's sidepannel/inputs here
                     
  
))

