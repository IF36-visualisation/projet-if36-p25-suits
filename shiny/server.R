library(shiny)
library(plotly)
library(dplyr)
library(tidyverse)
library(sf)

server <- function(input, output, session) {
  
  output$distPlot <- renderPlot({
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })
  
  geography <- read_csv("C:/Users/HP/Documents/IF36/name_geographic_information.csv")
  industry <- read_csv("C:/Users/HP/Documents/IF36/base_etablissement_par_tranche_effectif.csv")
  data_salaire <- read.csv("C:/Users/HP/Documents/IF36/net_salary_per_town_categories.csv")
  
  geography <- geography %>%
    mutate(
      longitude = str_replace_all(as.character(longitude), ",", "."),
      latitude = str_replace_all(as.character(latitude), ",", "."),
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


#--------------------------------------------------------------------------------graphique de la Visualisation de la carte------------------------------
  output$carteSalaire <- renderPlotly({
    data_localisation <- geography %>%
      mutate(code_insee = as.character(code_insee)) %>%
      mutate(code_insee = if_else(nchar(code_insee) == 4, paste0("0", code_insee), code_insee))
    
    data_complet <- left_join(data_salaire, data_localisation, by = c("CODGEO" = "code_insee"))
    
    data_complet <- data_complet %>%
      mutate(nom_région = case_when(
        nom_région %in% c("Rhône-Alpes", "Auvergne") ~ "Auvergne-Rhône-Alpes",
        nom_région %in% c("Bourgogne", "Franche-Comté") ~ "Bourgogne-Franche-Comté",
        nom_région == "Centre" ~ "Centre-Val de Loire",
        nom_région == "Bretagne" ~ "Bretagne",
        nom_région == "Corse" ~ "Corse",
        nom_région %in% c("Alsace", "Lorraine", "Champagne-Ardenne") ~ "Grand Est",
        nom_région %in% c("Picardie", "Nord-Pas-de-CalaisAquitaine") ~ "Hauts-de-France",
        nom_région == "Île-de-France" ~ "Île-de-France",
        nom_région %in% c("Haute-Normandie", "Basse-Normandie", "Basse-NormandiePays de la Loire") ~ "Normandie",
        nom_région %in% c("Aquitaine", "Limousin", "Poitou-Charentes", "Nord-Pas-de-CalaisAquitaine") ~ "Nouvelle-Aquitaine",
        nom_région %in% c("Midi-Pyrénées", "Languedoc-Roussillon") ~ "Occitanie",
        nom_région %in% c("Pays de la Loire", "Basse-NormandiePays de la Loire") ~ "Pays de la Loire",
        nom_région == "Provence-Alpes-Côte d'Azur" ~ "Provence-Alpes-Côte d'Azur",
        TRUE ~ nom_région
      )) %>%
      filter(!nom_région %in% c("Guyane", "Martinique", "Guadeloupe", "La Réunion"))
    
    france_regions <- st_read("https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/regions-version-simplifiee.geojson", quiet = TRUE)
    france_regions <- france_regions %>% rename(nom_région = nom)
    
    data_region <- data_complet %>%
      group_by(nom_région) %>%
      summarise(salaire_moyen = mean(SNHM14, na.rm = TRUE), .groups = "drop")
    
    carte_salaire <- france_regions %>% left_join(data_region, by = "nom_région")
    
    p <- ggplot(carte_salaire) +
      geom_sf(aes(fill = salaire_moyen, text = nom_région), color = "white") +
      scale_fill_viridis_c(option = "plasma", na.value = "grey90") +
      labs(title = "Salaire moyen horaire par région en France", fill = "Salaire horaire (€)") +
      theme_minimal()
    
    ggplotly(p)
  })
#------------------------------------------------------------------------------------------------------------------    
  
}
