library(shiny)




server <- function(input, output, session) {
  
# Pop-up Notification to Start ----  
  
  observe({
    showNotification("Select a Software House to start...",
                     closeButton = FALSE,
                     type = "message",
                     duration = 8
    )
  })  
  
# React to User Inputs ----
  
  filtered_games <- reactive({
    game_sales %>% 
      filter(genre %in% input$genre_input) %>% 
      filter(platform %in% input$platform_input) %>% 
      filter(publisher %in% input$publisher_input)
    
  })
  
# Plots ----
  
  output$year_plot <- renderPlot({
    make_year_plot(filtered_games())  
    
  })
  
  output$genre_plot <- renderPlot({
    make_genre_plot(filtered_games()) 
    
    
  })
  
  output$console_plot <- renderPlot({
    make_console_plot(filtered_games())
    
  })
  
  output$table_output <- renderDataTable({
    filtered_games()
  })
}