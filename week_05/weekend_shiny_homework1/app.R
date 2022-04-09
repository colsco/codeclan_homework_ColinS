library(shiny)
library(tidyverse)
library(shinythemes)
library(DT)
library(CodeClanData)

ui <- fluidPage(
    
    theme = shinytheme("lumen"),
    
    titlePanel("World Wide Game Sales"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("genre_input", 
                        label = "Select Genre",
                        choices = sort(unique(game_sales$genre)),
                        multiple = TRUE,
                        selected = unique(game_sales$genre)),
            hr(),
            selectInput("platform_input",
                        label = "Select Console",
                        choices = sort(unique(game_sales$platform)),
                        multiple = TRUE,
                        selected = unique(game_sales$platform)),
            hr(),
            radioButtons("publisher_input",
                         label = "Select Software House",
                         choices = sort(unique(game_sales$publisher)),
                         selected = "Nintendo")),
        mainPanel(
            tabsetPanel(
                tabPanel("Sales",
                         fluidRow(
                             column(6, plotOutput("year_plot")),
                             column(6, plotOutput("genre_plot"))
                         )
                ),
                tabPanel("Consoles",
                         fluidRow(
                             plotOutput("console_plot")
                         )
                ),
                tabPanel("Data",
                         dataTableOutput("table_output")
                )
            )
        )
    )
)


server <- function(input, output, session) {
    
    filtered_games <- reactive({
        game_sales %>% 
            filter(genre %in% input$genre_input) %>% 
            filter(platform %in% input$platform_input) %>% 
            filter(publisher %in% input$publisher_input)
        
    })
    
    output$year_plot <- renderPlot({
        filtered_games() %>% 
            ggplot()+
            aes(x = year_of_release, y = sales, fill = input$publisher_input) +
            geom_col() +
            labs(title = "Sales per Year per Publisher",
                 x = "\nGame Release Year",
                 y = "Annual Sales ($M)\n",
                 fill = NULL) +
            theme_minimal() + 
            scale_fill_brewer(palette = "Greens")
    })
    
    output$genre_plot <- renderPlot({
        filtered_games() %>% 
            ggplot()+
            aes(x = genre, y = sales, fill = input$publisher_input) +
            geom_col() +
            labs(title = "Sales per Genre per Publisher",
                 x = "\nGame Genre",
                 y = "Annual Sales ($M)\n",
                 fill = NULL) +
            theme_minimal() + 
            scale_fill_brewer(palette = "Greens") +
            theme(axis.text.x = element_text (angle = 90, hjust = 1, vjust = 0.1))
        
    })
    
    output$console_plot <- renderPlot({
        filtered_games() %>%
            ggplot()+
            aes(x = platform, y = user_score) +
            geom_boxplot(fill = "Darkolivegreen4") +
            labs(title = "User Scores per Console Type",
                 x = "\nConsole Type",
                 y = "User Score\n",
                 fill = NULL) +
            theme_minimal()
    })
    
    output$table_output <- renderDataTable({
        filtered_games()
    })
    
    
    
}

shinyApp(ui, server)
