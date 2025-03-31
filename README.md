# INTRODUCTION

## DONNEES

### FICHIER 1: base_etablissement_par_tranche_effectif.csv
Patrice
### FICHIER 2: name_geographic_information.csv
Dora
### FICHIER 3: net_salary_per_town_per_category.csv
Patricia
### FICHIER 4: population.csv
Samella

Analyse des données de la population

1. Description des données
Le jeu de données représente des informations démographiques organisées par commune. Chaque ligne du tableau correspond à une tranche d'âge spécifique, un mode de cohabitation et un genre, avec une colonne indiquant le nombre de personnes concernées. Les principales dimensions des données sont :

Géographique : identifiée par le code INSEE de la commune (CODGEO) et son nom (Nom de la commune).

Démographique : répartition des habitants selon la tranche d'âge (code), le sexe (1 = homme, 2 = femme) et le mode de cohabitation (indiquant le type de ménage).

Effectif : nombre de personnes appartenant à chaque groupe de classification (Nombre de personnes).

Les variables peuvent être classées en trois catégories :

Ordinales : tranche d'âge, mode de cohabitation.

Numériques : nombre de personnes.

Nominales : nom de la commune, sexe.

Le format du fichier est tabulaire, organisé sous forme de table avec des valeurs numériques et catégoriques.

2. Plan d’analyse
L’objectif principal de cette analyse est de comprendre la distribution de la population selon l’âge, le sexe et le mode de cohabitation, tout en identifiant d’éventuelles tendances significatives.

Questions principales et visualisations envisagées :
Comment est répartie la population par tranche d’âge et par sexe ?

Visualisation : histogrammes ou graphiques en barres empilées.

Dimensions : tranche d’âge (x), nombre de personnes (y), sexe (couleur).

Quels sont les modes de cohabitation les plus fréquents et varient-ils en fonction du sexe ou de l’âge ?

Visualisation : diagramme en barres groupées ou heatmap (mode de cohabitation vs âge).

Dimensions : mode de cohabitation (x), nombre de personnes (y), tranche d’âge ou sexe (couleur).

Y a-t-il une différence notable entre les sexes dans certaines tranches d’âge ?

Visualisation : courbes comparatives ou boîte à moustaches pour voir la dispersion.

Dimensions : sexe (x), nombre de personnes (y), tranche d’âge (catégorie).

Existe-t-il une corrélation entre certaines variables (âge et mode de cohabitation, sexe et nombre de personnes, etc.) ?

Visualisation : matrice de corrélation ou scatter plot si pertinent.

Dimensions : différentes combinaisons de variables numériques.


Valeurs extrêmes ou anomalies : Si des tranches d’âge sont surreprésentées ou absentes, cela peut biaiser l’analyse.


Conclusion
Cette analyse nous permettra d’avoir une vue d’ensemble sur la répartition de la population dans les communes étudiées. En croisant les variables, nous chercherons à dégager des tendances et des relations intéressantes, tout en veillant à la qualité des données utilisées.

## PLAN D'ANALYSE
