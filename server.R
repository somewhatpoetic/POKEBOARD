# This file is the brain behind the logic. All things functional and relating to 
# the ui are created and determined here.

# If something doesn't make sense --> https://mastering-shiny.org/

library(shiny)
library(kableExtra)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # in app theme editor
    #bs_themer()
  
    output$dataTable <- renderDataTable({data}, 
                                        options = list(
                                          scrollX = TRUE,
                                          pageLength = 25),
                                        rownames = FALSE)
    

})
