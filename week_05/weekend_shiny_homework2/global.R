library(tidyverse)
library(CodeClanData)
library(RColorBrewer)


# Custom Palette ----
# The in-built colour palettes are not large enough to cope with a user who 
# decides that they want to see *every* publisher on one graph.  A custom larger
# palette is needed to accommodate that specific request...

number_colours <-  length(unique(game_sales$publisher))
my_palette <-  colorRampPalette(brewer.pal(8, "Dark2"))(number_colours)

make_year_plot <- function(chosen_data){
  ggplot(chosen_data)+
    aes(x = year_of_release, y = sales, fill = publisher) +
    geom_col() +
    labs(title = "Sales per Year per Publisher",
         x = "\n\n\n\nGame Release Year",
         y = "Annual Sales ($M)\n") +
    theme_minimal() + 
    theme(plot.title = element_text(face = "bold")) +
    scale_fill_manual(values = my_palette)
}

# Sales by Year by Publisher ----
# The year_plot will allow the user to select one or more software publishers, 
# genres and consoles to view a plot of their annual sales within the boundaries 
# set by the data and their chosen parameters.  

# By using the dashboard selections they should be able to see how each software 
# publisher performed every year by both game genres and console type.


make_genre_plot <- function(chosen_data){
  ggplot(chosen_data)+
    aes(x = genre, y = sales, fill = publisher) +
    geom_col() +
    labs(title = "Sales per Genre per Publisher",
         x = "\nGame Genre",
         y = "Annual Sales ($M)\n",
         fill = NULL) +
    theme_minimal() + 
    scale_fill_brewer(palette = "Greens") +
    theme(axis.text.x = element_text (angle = 90, hjust = 1, vjust = 0.1),
          plot.title = element_text(face = "bold")) +
    scale_fill_manual(values = my_palette)
}

# User Scores by Console ----
# The console plot provides the user with an overview of users' scores per genres,
# software publishers and consoles selected.  This allows a high level "real world" 
# picture of how well different game genres translate onto various consoles by
# different creators.  It also shows the console types where individual software 
# houses may have strengths or weaknesses within the confines of our data set.

make_console_plot <- function(chosen_data){
  ggplot(chosen_data)+
    aes(x = platform, y = user_score) +
    geom_boxplot(fill = "Darkolivegreen4") +
    labs(title = "User Scores per Console Type",
         x = "\nConsole Type",
         y = "User Score\n",
         fill = NULL) +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold"))
}

