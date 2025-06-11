#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)
library(plotly)
library(tidyverse)

dashboardPage(
  dashboardHeader(title = "Suits-P25"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Visualisation", tabName = "visualisation", icon = icon("chart-bar")),
      selectInput("type_entreprise", "Choisissez le type d'entreprise :", 
                  choices = c("TPE", "PME", "Grandes entreprises"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "visualisation",
              fluidRow(
                box(
                  title = "Nombre d'entreprises par région",
                  width = 12,
                  plotlyOutput("barPlot")
                ),
                box(
                  titlePanel("Carte des salaires moyens horaires par région"),
                  width = 12,
                  plotlyOutput("carteSalaire")
                  
                ),
                box(
                  title = "Salaire moyen par catégorie professionnelle et par sexe",
                  width = 12,
                  plotlyOutput("salaireSexePlot")
                ),
                box(
                  title = "Répartition des modes de cohabitation par région",
                  width = 12,
                  plotlyOutput("cohabitationPlot")
                ),
                box(
                  title = "Proportion de grandes entreprises et salaire net moyen ",
                  width= 12,
                  plotOutput("samella", height = 300)
                )
            
              )
      )
    )
  )
)
