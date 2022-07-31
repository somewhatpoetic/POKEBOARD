# This file is the brain behind the logic. All things functional and relating to 
# the ui are created and determined here.

# If something doesn't make sense --> https://mastering-shiny.org/

library(shiny)
library(kableExtra)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # data table output  
  output$dataTable <- 
    renderDataTable({data},
                    options = list(
                      scrollX = TRUE,
                      pageLength = 25),
                    rownames = FALSE)
  
  # image of Pokemon
  output$image <- renderUI({
    img(
      src=paste0("https://assets.pokemon.com/assets/cms2/img/pokedex/full/",filter(data, data$Name == input$search1)[[1,2]],".png"),
      height="100%",
      width="100%"
    )
  })
  
  # name of selected Pokemon
  output$selectedPokemon0 <-
    renderText({
      ifelse(input$search2 != "Base",
             paste0(input$search2),
             paste0(input$search1)) 
    })
  
  output$search2 <- renderUI({
    wellPanel(
      selectInput(
        inputId = "search2",
        label = "Select Forme",
        choices = filter(data, data$Name == input$search1 & !is.na(data$Forme))[[4]]
      )
    )
  })
})
