library(shiny)
library(shinythemes)
library(DT)
library(CodeClanData)

ui <- fluidPage(
    
    theme = shinytheme("lumen"),
    
    # Title Bar + Image ----    
    
    titlePanel(title = div(img(src="controller.png", 
                               height = 50, 
                               width = 77), 
                           "Global Game Sales")
    ),
    
    # Sidebar Setup ----
    
    sidebarLayout(
        sidebarPanel(
            selectInput("genre_input", 
                        label = tags$b("Select Genre"),
                        choices = sort(unique(game_sales$genre)),
                        multiple = TRUE,
                        selected = unique(game_sales$genre)),
            hr(),
            selectInput("platform_input",
                        label = tags$b("Select Console"),
                        choices = sort(unique(game_sales$platform)),
                        multiple = TRUE,
                        selected = unique(game_sales$platform)),
            hr(),
            checkboxGroupInput("publisher_input",
                               label = tags$b("Select Software House"),
                               choices = sort(unique(game_sales$publisher)
                               ),
            )),
        
        # Main Panel Setup ----
        
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