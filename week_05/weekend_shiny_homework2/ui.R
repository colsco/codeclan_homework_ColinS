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
                ),
                tabPanel("Further Info",
                         HTML("<br>", "<br>"),
                         tags$h3("Publisher Websites"),
                         HTML("<br>"),
                         tags$a("Activision", 
                                href = "https://www.activision.com/"),
                         HTML("<br>", "<br>"),
                         tags$a("Capcom", 
                                href = "https://capcom-europe.com/"),
                         HTML("<br>", "<br>"),
                         tags$a("Codemasters", 
                                href = "https://www.codemasters.com/"),
                         HTML("<br>", "<br>"),
                         tags$a("Electronic Arts", 
                                href = "https://www.ea.com/en-gb"),
                         HTML("<br>", "<br>"),
                         tags$a("Konami Digital Entertainment", 
                                href = "https://www.konami.com/en/"),
                         HTML("<br>", "<br>"),
                         tags$a("Midway Games", 
                                href = "https://warnerbrosgames.com/"),
                         HTML("<br>", "<br>"),
                         tags$a("Nintendo", 
                                href = "https://www.nintendo.co.uk/"),
                         HTML("<br>", "<br>"),
                         tags$a("Sony Computer Entertainment", 
                                href = "https://www.sie.com/en/index.html"),
                         HTML("<br>", "<br>"),
                         tags$a("Take-Two Interactive", 
                                href = "https://www.take2games.com/"),
                         HTML("<br>", "<br>"),
                         tags$a("Tecmo Koei", 
                                href = "https://www.koeitecmoeurope.com/"),
                         HTML("<br>", "<br>"),
                         tags$a("Ubisoft", 
                                href = "https://www.ubisoft.com/en-gb/"),
                         HTML("<br>", "<br>"),
                         tags$a("Warner Bros. Interactive Entertainment", 
                                href = "https://warnerbrosgames.com/"),
                         
                )					
            )
        )
    )
)  
