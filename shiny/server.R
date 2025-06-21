library(shiny)
library(plotly)
library(dplyr)
library(tidyverse)
library(sf)

# Chargement de données
geography <- read_csv("C:/Users/estel/Downloads/archive/name_geographic_information.csv")
industry <- read_csv("C:/Users/estel/Downloads/archive/base_etablissement_par_tranche_effectif.csv")
data_salaire <- read.csv("C:/Users/estel/Downloads/archive/net_salary_per_town_categories.csv")
population <- read.csv("C:/Users/estel/Downloads/archive/population.csv")

# Chargement des données
population <- read_csv("C:/Users/estel/Downloads/archive/population.csv")
salary <- read_csv("C:/Users/estel/Downloads/archive/net_salary_per_town_categories.csv")
entreprises <- read_csv("C:/Users/estel/Downloads/archive/base_etablissement_par_tranche_effectif.csv")

# Préparation des données
pop_commune <- population %>%
  group_by(CODGEO) %>%
  summarise(pop_total = sum(NB, na.rm = TRUE))

entreprises_summarise <- entreprises %>%
  mutate(nb_total = rowSums(select(., starts_with("E14TS")), na.rm = TRUE),
         nb_grandes = rowSums(select(., E14TS100, E14TS200, E14TS500), na.rm = TRUE),
         proportion_grandes = nb_grandes / nb_total) %>%
  select(CODGEO, proportion_grandes)

data_combine <- salary %>%
  select(CODGEO, SNHM14) %>%
  left_join(entreprises_summarise, by = "CODGEO") %>%
  left_join(pop_commune, by = "CODGEO") %>%
  drop_na()

# initialisation du serveur 
server <- function(input, output, session) {
  
  output$distPlot <- renderPlot({
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })
  
  
  
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
  
  
 
  #------------------------------------------------------------------------------------------------------------------ 
  
  salaire_sexe <- data_salaire %>%
    select(CODGEO, LIBGEO, 
           SNHMFC14, SNHMFP14, SNHMFE14, SNHMFO14,  # Femmes
           SNHMHC14, SNHMHP14, SNHMHE14, SNHMHO14,  # Hommes
           SNHMC14, SNHMP14, SNHME14, SNHMO14       # Ensemble
    ) %>%
    mutate(across(everything(), as.numeric)) %>%
    pivot_longer(
      cols = -c(CODGEO, LIBGEO),
      names_to = "Categorie_Sexe",
      values_to = "Salaire"
    ) %>%
    mutate(
      Sexe = case_when(
        grepl("^SNHMF", Categorie_Sexe) ~ "Femme",
        grepl("^SNHMH", Categorie_Sexe) ~ "Homme",
        grepl("^SNHMC|^SNHMP|^SNHME|^SNHMO", Categorie_Sexe) ~ "Ensemble",
        TRUE ~ NA_character_
      ),
      Categorie = case_when(
        grepl("C14$", Categorie_Sexe) ~ "Cadres",
        grepl("P14$", Categorie_Sexe) ~ "Prof. intermédiaires",
        grepl("E14$", Categorie_Sexe) ~ "Employés",
        grepl("O14$", Categorie_Sexe) ~ "Ouvriers",
        TRUE ~ NA_character_
      )
    ) %>%
    filter(!is.na(Categorie) & !is.na(Sexe))
  
  salaire_moyen_sexe <- salaire_sexe %>%
    group_by(Categorie, Sexe) %>%
    summarise(Salaire_Moyen = mean(Salaire, na.rm = TRUE), .groups = "drop")
  
  output$salaireSexePlot <- renderPlotly({
    graph <- ggplot(salaire_moyen_sexe, aes(x = Categorie, y = Salaire_Moyen, fill = Sexe)) +
      geom_bar(position = "dodge", stat = "identity") +
      geom_text(aes(label = round(Salaire_Moyen, 1)),
                position = position_dodge(width = 0.9), 
                vjust = -0.5, size = 3.5) +
      labs(
        title = "Salaire net horaire moyen par catégorie professionnelle et par sexe",
        x = "Catégorie professionnelle",
        y = "Salaire net horaire moyen (€)",
        caption = "Source : net_salary_per_town_category.csv"
      ) +
      scale_fill_manual(values = c("#4E79A7", "#F28E2B", "#59A14F")) +
      theme_minimal()
    
    ggplotly(graph)
  })
  #--------------------------------------------------------------------------------
  
  population$CODGEO <- as.character(population$CODGEO)
  geography$code_insee <- as.character(geography$code_insee)
  
  pop_region <- population %>%
    left_join(geography, by = c("CODGEO" = "code_insee")) %>%
    filter(!is.na(nom_région))
  
  cohab_region <- pop_region %>%
    group_by(nom_région, MOCO) %>%
    summarise(total = sum(NB, na.rm = TRUE), .groups = "drop") %>%
    mutate(
      type_cohabitation = case_when(
        MOCO == 11 ~ "Enfant avec 2 parents",
        MOCO == 12 ~ "Enfant avec 1 parent",
        MOCO == 21 ~ "Couple sans enfant",
        MOCO == 22 ~ "Couple avec enfant(s)",
        MOCO == 23 ~ "Adulte seul avec enfant(s)",
        MOCO == 31 ~ "Colocation",
        MOCO == 32 ~ "Personne seule",
        TRUE ~ "Autre"
      )
    )
  
  cohab_prop <- cohab_region %>%
    group_by(nom_région) %>%
    mutate(pct = total / sum(total)) %>%
    ungroup()
  
  output$cohabitationPlot <- renderPlotly({
    graph <- ggplot(cohab_prop, aes(x = reorder(nom_région, -pct), y = pct, fill = type_cohabitation)) +
      geom_bar(stat = "identity", position = "fill") +
      scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
      scale_fill_brewer(palette = "Set2") +
      coord_flip() +
      labs(
        title = "Répartition des modes de cohabitation par région (2013)",
        subtitle = "En pourcentage de la population de chaque région",
        x = "Région",
        y = "Part relative des types de cohabitation",
        fill = "Type de cohabitation",
        caption = "Source : INSEE – données 2013"
      ) +
      theme_minimal()
    
    ggplotly(graph)
  })
  
  
  
  
}