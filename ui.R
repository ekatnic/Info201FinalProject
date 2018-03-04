library(shiny)
source("server.R")

my.ui <- (navbarPage("Hip-Hop Lyrics and Politicians",
                     tabPanel("Jarod"),
                     #jarod's sidepannels/inputs here
                     
                     tabPanel("Abbey"),
                     #abbey's sidepannels/inputs here
                     
                     tabPanel("Rasik"),
                     #rasik's sidepannels/inputs here 
                     
                     tabPanel("Ethan")
                     #ethan's sidepannel/inputs here
                     
  
))

