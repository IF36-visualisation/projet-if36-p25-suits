# 📊 Analyse des inégalités en France : Emploi, Salaires et Démographie  

# INTRODUCTION

Dans le cadre de notre projet de dataViz, notre équipe **Suits** a choisi d'explorer les données socio-économiques françaises afin de mettre en lumière les inégalités en matière d'emploi, de salaires et de de démographie. Notre objectif est d'offrir une analyse approfondie des disparités entre les différentes villes françaises en nous basant sur des données officielles fournies par **l'INSEE** (Institut National de la Statistique et des Etudes économiques). 
Notre étude reposera sur **quatre fichiers de données**, chacun apportant un éclairage spécifique sur les disparités observées en France : 

| 📁 **Nom du fichier**                           | 📌 **Description** |
|---------------------------------------------|------------------|
| **base_etablissement_par_tranche_effectif.csv** | Contient le nombre d’entreprises par commune française, classées selon leur taille. Permet d’analyser la répartition des entreprises sur le territoire. |
| **name_geographic_information.csv**         | Fournit des informations géographiques détaillées sur chaque ville (latitude, longitude, codes et noms des régions et départements). |
| **net_salary_per_town_per_category.csv**    | Présente les niveaux de salaires selon la ville, la catégorie professionnelle, l’âge et le sexe. Permet d'évaluer les **inégalités salariales** en France. |
| **population.csv**                           | Contient des données démographiques par commune, incluant l’âge, le sexe et le mode de vie des habitants. |

En croisant ce différentes sources de données, nous visons à : 

✅ Identifier les inégalités économiques et démographiques entre les territoires français.  
✅ Analyser la répartition des entreprises et son impact sur l'emploi et les salaires.  
✅ Mettre en évidence les écarts salariaux en fonction de l’âge, du sexe et de la catégorie professionnelle.  
✅ Avoir une vision claire de ce qui se passe dans les différentes régions pour mieux comprendre les problèmes liés aux inégalités entre les territoires.

Dans la suite de cette introduction, nous détaillerons les différentes dimensions contenues dans nos quatre fichiers de données et présenterons notre plan d'analyse.


## 📊 DONNEES

### 📁 FICHIER 1: base_etablissement_par_tranche_effectif.csv
Patrice
### 📁 FICHIER 2: name_geographic_information.csv
Dora

---

### 📁 FICHIER 3: net_salary_per_town_per_category.csv

Nous avons choisir d'inclure ce fichier dans notre analyse car il permettra d'évaluer les écarts de rénumération à plusieurs niveaux (géographique, professionnel et démographique).Il nous permettra donc de comprendre la répartition des revenus et détecter d'éventuelles inégalités salariales.


#### 📊 Caractéristiques des données  

- **Nombre d’observations** : plus de 1000000  
- **Nombre de variables** : 26  
- **Format** : **CSV** 
- **Type des variables** :  
  - **Identifiants et localisation** : Codes et noms des villes (**variables qualitatives**).  
  - **Données numériques** : Salaires en milliers d'euros (**variables quantitatives continues**).  


#### Présentation de chaque variable

| 🏷️ **Nom de la variable** | 📌 **Description** | 🎭 **Type** |
|---------------------------|--------------------|------------|
| **CODGEO**  | Code unique de la ville | Nominal |
| **LIBGEO**  | Nom de la ville | Nominal|
| **SNHM14**  | 🔹 Salaire net moyen | Numérique |
| **SNHMC14** | 🔹 Salaire net moyen par heure pour les cadres | Numérique |
| **SNHMP14** | 🔹 Salaire net moyen par heure pour les professions intermédiaires | Numérique |
| **SNHME14** | 🔹 Salaire net moyen par heure pour les employés | Numérique |
| **SNHMO14** | 🔹 Salaire net moyen par heure pour les ouvriers | Numérique |
| **SNHMF14** | 🔹 Salaire net moyen des femmes | Numérique |
| **SNHMFC14** | 🔹 Salaire net moyen par heure pour les femmes cadres | Numérique |
| **SNHMFP14** | 🔹 Salaire net moyen par heure pour les femmes professions intermédiaires | Numérique |
| **SNHMFE14** | 🔹 Salaire net moyen par heure pour les femmes employées | Numérique |
| **SNHMFO14** | 🔹 Salaire net moyen par heure pour les femmes ouvrières | Numérique |
| **SNHMH14** | 🔹 Salaire net moyen des hommes | Numérique |
| **SNHMHC14** | 🔹 Salaire net moyen par heure pour les hommes cadres | Numérique |
| **SNHMHP14** | 🔹 Salaire net moyen par heure pour les hommes professions intermédiaires | Numérique |
| **SNHMHE14** | 🔹 Salaire net moyen par heure pour les hommes employés | Numérique |
| **SNHMHO14** | 🔹 Salaire net moyen par heure pour les hommes ouvriers | Numérique |
| **SNHM1814** | 🔹 Salaire net moyen par heure pour les 18-25 ans | Numérique |
| **SNHM2614** | 🔹 Salaire net moyen par heure pour les 26-50 ans | Numérique |
| **SNHM5014** | 🔹 Salaire net moyen par heure pour les plus de 50 ans | Numérique |
| **SNHMF1814** | 🔹 Salaire net moyen par heure pour les femmes de 18-25 ans | Numérique |
| **SNHMF2614** | 🔹 Salaire net moyen par heure pour les femmes de 26-50 ans | Numérique |
| **SNHMF5014** | 🔹 Salaire net moyen par heure pour les femmes de plus de 50 ans | Numérique |
| **SNHMH1814** | 🔹 Salaire net moyen par heure pour les hommes de 18-25 ans | Numérique |
| **SNHMH2614** | 🔹 Salaire net moyen par heure pour les hommes de 26-50 ans | Numérique |
| **SNHMH5014** | 🔹 Salaire net moyen par heure pour les hommes de plus de 50 ans | Numérique |

---




### 📁 FICHIER 4: population.csv
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



## PLAN D'ANALYSE
