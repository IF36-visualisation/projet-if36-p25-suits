#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(plotly)
library(dplyr)
library(tidyverse)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })
    
    # Chargement et nettoyage des données
    geography <- read_csv("C:/Users/estel/Downloads/archive/name_geographic_information.csv")
    industry <- read_csv("C:/Users/estel/Downloads/archive/base_etablissement_par_tranche_effectif.csv")
    
    geography <- geography %>%
      mutate(
        longitude = str_replace_all(as.character(longitude), ",", "."),
        latitude  = str_replace_all(as.character(latitude), ",", "."),
        longitude = na_if(longitude, "-"),
        latitude = na_if(latitude, "-"),
        longitude = as.numeric(longitude),
        latitude = as.numeric(latitude)
      ) %>%
      drop_na(longitude, latitude) %>%
      distinct(code_insee, .keep_all = TRUE)
    
    industry <- industry %>%
      filter(str_detect(CODGEO, "^\\d+$")) %>%
      mutate(CODGEO = as.integer(CODGEO))
    
    merged1 <- merge(geography, industry, by.x = "code_insee", by.y = "CODGEO")
    
    # Regroupement des tailles d'entreprise
    data_grouped <- merged1 %>%
      mutate(
        TPE = E14TS1 + E14TS6,
        PME = E14TS10 + E14TS20 + E14TS50 + E14TS100 + E14TS200,
        GE  = E14TS500
      ) %>%
      group_by(nom_région) %>%
      summarise(
        TPE = sum(TPE, na.rm = TRUE),
        PME = sum(PME, na.rm = TRUE),
        GE  = sum(GE, na.rm = TRUE)
      ) 
  
    # Graphique 
    output$barPlot <- renderPlotly({
      req(input$type_entreprise)
      
      selected_column <- switch(input$type_entreprise,
                                "TPE" = "TPE",
                                "PME" = "PME",
                                "Grandes entreprises" = "GE")
      
      graph <- ggplot(data_grouped, aes(x = reorder(nom_région, .data[[selected_column]]), 
                               y = .data[[selected_column]])) +
        geom_bar(stat = "identity", fill = "#0053e6") +
        coord_flip() +
        labs(
          title = paste("Nombre de", input$type_entreprise, "par région"),
          x = "Région",
          y = "Nombre d'entreprises"
        ) +
        theme_minimal()
      ggplotly(graph)
      
      
    })
    
    

}
