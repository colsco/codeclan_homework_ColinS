library(shiny)
library(shinythemes)
library(DT)
library(CodeClanData)
library(bslib)
library(showtext) 

# Set up custom theme parameters (to adjust font) ----
my_theme <- bs_theme(bootswatch = "sandstone",
                     base_font = font_google("Manrope"),
                     font_scale = 0.85)

ui <- fluidPage(
    
    # Pass theme object to UI function ----
    theme = my_theme,
    
    # Title Bar + Image ----    
    
    titlePanel(title = div(img(src="controller.png", 
                               height = 50, 
                               width = 77), 
                           tags$b("Global Game Sales"))
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
                         dataTableOutput("table_output",
                                         width = "60%",
                                         height = "60%")
                ),
                tabPanel("Further Info",
                         HTML("<br>", "<br>"),
                         tags$h3("Publisher Websites"),
                         HTML("<br>"),
                         tags$a("Activision", 
                                href = "https://www.activision.com/"),
                         HTML("<br>"),
                         tags$a("Capcom", 
                                href = "https://capcom-europe.com/"),
                         HTML("<br>"),
                         tags$a("Codemasters", 
                                href = "https://www.codemasters.com/"),
                         HTML("<br>"),
                         tags$a("Electronic Arts", 
                                href = "https://www.ea.com/en-gb"),
                         HTML("<br>"),
                         tags$a("Konami Digital Entertainment", 
                                href = "https://www.konami.com/en/"),
                         HTML("<br>"),
                         tags$a("Midway Games", 
                                href = "https://warnerbrosgames.com/"),
                         HTML("<br>"),
                         tags$a("Nintendo", 
                                href = "https://www.nintendo.co.uk/"),
                         HTML("<br>"),
                         tags$a("Sony Computer Entertainment", 
                                href = "https://www.sie.com/en/index.html"),
                         HTML("<br>"),
                         tags$a("Take-Two Interactive", 
                                href = "https://www.take2games.com/"),
                         HTML("<br>"),
                         tags$a("Tecmo Koei", 
                                href = "https://www.koeitecmoeurope.com/"),
                         HTML("<br>"),
                         tags$a("Ubisoft", 
                                href = "https://www.ubisoft.com/en-gb/"),
                         HTML("<br>"),
                         tags$a("Warner Bros. Interactive Entertainment", 
                                href = "https://warnerbrosgames.com/"),
                         
                )					
            )
        )
    )
)


