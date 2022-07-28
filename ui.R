# This file specifies the ui elements of the shiny app. Basically everything 
# you see in the app and interact with.

# If something doesn't make sense --> https://mastering-shiny.org/

library(DT)
library(shiny)
library(bslib)
library(flexdashboard)

shinyUI(fluidPage(

    # theme  
    # theme = bslib::bs_theme(),
  
    # application title
    navbarPage("POKEBOARD",
        tabPanel(":: data",
                 fluidRow(column(12, dataTableOutput("dataTable")))
        ),
        tabPanel(":: pokemon viewer"),
        tabPanel(":: compare pokemon")
    )
))
