# This file specifies the ui elements of the shiny app. Basically everything 
# you see in the app and interact with.

# If something doesn't make sense --> https://mastering-shiny.org/

library(DT)
library(shiny)
library(bslib)
library(tidyverse)
library(flexdashboard)

shinyUI(fluidPage(

    # theme  
    theme = bs_theme(),
  
    # application title (navbar layout)
    navbarPage("POKEBOARD",
        tabPanel(":: introduction",
          fluidRow(column(12, h2("Welcome to the POKEBOARD!")))
        ),
        tabPanel(":: data",
          fluidRow(column(12, dataTableOutput("dataTable")))
        ),
        tabPanel(":: pokemon viewer",
          fluidRow(
             column(3,
               wellPanel(
                 uiOutput("image"),
                 div(
                   h3(htmlOutput("viewer")), 
                   align = "center",
                 ),
               )
             ),
             # Search feature
             column(3,
               uiOutput("pokemonSelect")
             ),
             column(3,
                #conditionalPanel("length(filter(data, data$Name == )[[2]]) < 1",
                    uiOutput("formeSelect")
                #)
             )
          )
                 # Pokemon picture
                 # Types (text or images?)
                 # Generation number
                 # Total (sum of all stats)
                 # All other stats
        ),
        tabPanel(":: compare pokemon")
    )
))
