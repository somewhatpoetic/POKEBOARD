# This file is the brain behind the logic. All things functional and relating to 
# the ui are created and determined here.

# If something doesn't make sense --> https://mastering-shiny.org/

library(shiny)
library(kableExtra)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # data table output  
  output$dataTable <- renderDataTable({data},
                        options = list(
                          scrollX = TRUE,
                          pageLength = 25),
                        rownames = FALSE)
  
  # image of Pokemon
  output$image <- renderUI({
    
    if (length(filter(data, data$Name == input$pokemon)[[2]]) == 1) {
      pokemon <- filter(data, data$Name == input$pokemon)[[1,2]]
    } else {
      pokemon <- filter(data, data$Name == input$pokemon & data$Forme == input$forme)[[1,2]]
    }
    
    img(
      src=paste0("https://assets.pokemon.com/assets/cms2/img/pokedex/full/",pokemon,".png"),
      height="100%",
      width="100%"
    )
  })
  
  # name of selected Pokemon
  output$viewer <-
    renderText({
      ifelse(length(filter(data, data$Name == input$pokemon)[[2]]) == 1,
             input$pokemon,
             ifelse(input$forme == "Base",
                    input$pokemon, 
                    paste("<h5>",
                          input$pokemon,
                          "</h5>",
                          input$forme
                    )
             )
      )
    })
  
  # selection of pokemon
  output$pokemonSelect <- renderUI({
    wellPanel(
      selectInput(
        inputId = "pokemon",
        label = "Select Pokemon",
        choices = data$Name
      )
    )
  })
  
  selectedForme <- reactive({
    
    choices <- filter(data, data$Name == input$pokemon)[[4]]
    
    if(length(filter(data, data$Name == input$pokemon)[[2]]) > 1) {
      wellPanel(
        selectInput(
          inputId = "forme",
          label = "Select Forme",
          choices = choices
        )
      )
    }
  })
  
  output$formeSelect <- renderUI(selectedForme())

})
