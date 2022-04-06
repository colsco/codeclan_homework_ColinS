library(shiny)
library(tidyverse)
library(shinythemes)
library(bslib)


 whisky <- CodeClanData::whisky %>% janitor::clean_names()

 all_owners <- unique(whisky$owner)
 all_regions <- unique(whisky$region)




# Define UI for application that draws a histogram
ui <- fluidPage(
    
    theme = shinytheme("sandstone"),

    # Application title
    titlePanel(tags$h2("Whisky Companies in Scotland")),
    
    tabsetPanel(
        
        tabPanel("Capacity Plot",
    
            plotOutput("cap_plot"),

    fluidRow(    
            # Sidebar with a drop-down input for distillery owners 
        column(6,    
                selectInput("owner", label = h4("Choose Owner"), 
                                     choices = all_owners, 
                                     selected = "Diageo"),
            
                hr(),
                fluidRow(column(2, verbatimTextOutput("value"))),
                )
            ),
        ),
    
    #     tabPanel("Distilleries",
    #              
    #         textOutput("distil_list"), 
    # fluidRow(        
    #      column(6,
    #             radioButtons("region", label = h4("Choose a Region"),
    #                                   choices = all_regions, 
    #                         ),
    #             
    #             hr(),
    #             fluidRow(column(3, verbatimTextOutput("list")))
    #             )   
    #         ),
    #     ),
),
)



# Define server logic required to draw a plot
server <- function(input, output) {

    output$cap_plot <- renderPlot({
    
        whisky_capacity %>% 
            filter(owner == input$owner) %>% 
            ggplot() +
            aes(x = reorder(owner, total_capacity), y = total_capacity) +
            geom_col(colour = "goldenrod3", fill = "lightgoldenrod1", width = 0.3) +
            coord_flip() +
            theme_classic(base_size = 18) +
            scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
            labs(title = "Total Whisky Capacity",
                 x = "Distillery Owner",
                 y = "Capacity (litres)"
                ) +
            theme(axis.title.x = element_text(hjust = 1),
                  axis.title.y = element_text(hjust = 1),
                  panel.background = element_rect(rel(0.8))) 
            
        
    })
    
    # output$distil_list <- rendertext({
    #     whisky %>% 
    #         filter(owner == input$region) %>% 
    #         summarise(distillery)
    #     
    # }) 
}

# Run the application 
shinyApp(ui = ui, server = server)
