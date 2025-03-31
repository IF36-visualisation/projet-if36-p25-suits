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

### 📁 FICHIER 1 : `base_etablissement_par_tranche_effectif.csv`

Ce fichier contient les données relatives au **nombre d'établissements (entreprises ou structures économiques)** présents dans chaque commune, classés par **tranche d’effectif salarié**. Chaque ligne représente une **commune unique**, identifiée par son code INSEE.

Nous avons choisi ce fichier car il constitue un **indicateur direct de l’activité économique locale**. Il permet notamment d’analyser la **présence de TPE, PME et grandes entreprises**, ce qui est un levier d’explication crucial pour les écarts de salaires, la répartition de la population active, et l’attractivité territoriale.

---

#### 📐 1. Format et structure

- **Format** : CSV  
- **Encodage** : UTF-8  
- **Nombre de lignes** : environ 35 000 (une par commune)  
- **Nombre de colonnes** : 14  
- **Clé de jointure** : `CODGEO`, commune à tous les autres fichiers

---

#### 🏷️ 2. Description des variables

| **Nom**        | **Type**    | **Description** |
|----------------|-------------|-----------------|
| `CODGEO`       | Nominale    | Code INSEE unique de la commune. Utilisé comme clé de jointure. |
| `LIBGEO`       | Nominale    | Nom de la commune. Sert à la lisibilité dans les visuels. |
| `REG`          | Ordinale    | Code de la région (2 chiffres). Sert à regrouper les communes par région. |
| `DEP`          | Ordinale    | Code du département. Permet une agrégation intermédiaire. |
| `E14TST`       | Numérique   | Nombre total d'établissements dans la commune. |
| `E14TS0ND`     | Numérique   | Établissements sans effectif connu ou non déterminé. |
| `E14TS1`       | Numérique   | Établissements de 1 à 5 salariés (**TPE**). |
| `E14TS6`       | Numérique   | Établissements de 6 à 9 salariés. |
| `E14TS10`      | Numérique   | Établissements de 10 à 19 salariés. |
| `E14TS20`      | Numérique   | Établissements de 20 à 49 salariés (**PME**). |
| `E14TS50`      | Numérique   | Établissements de 50 à 99 salariés. |
| `E14TS100`     | Numérique   | Établissements de 100 à 199 salariés. |
| `E14TS200`     | Numérique   | Établissements de 200 à 499 salariés. |
| `E14TS500`     | Numérique   | Établissements de 500 salariés et plus. |

---

#### 🧠 3. Catégorisation implicite

Les tranches d’effectifs peuvent être regroupées en **sous-catégories analytiques** :

- **TPE (Très Petites Entreprises)** : `E14TS1` + `E14TS6`  
- **PME (Petites et Moyennes Entreprises)** : `E14TS10` + `E14TS20` + `E14TS50`  
- **Grandes entreprises** : `E14TS100` + `E14TS200` + `E14TS500`  

Cela permet de **profiler chaque commune** selon la structure dominante de ses établissements économiques. Ce regroupement est utile pour la segmentation, le clustering, ou les corrélations avec d'autres indicateurs (salaires, population...).

---

#### 🔗 4. Intégration dans notre modèle

Le fichier s’intègre dans un **modèle de données relationnel**, en étant relié :

- Aux **données géographiques** via le fichier `name_geographic_information.csv` (clé : `CODGEO`)  
- Aux **données salariales** via `net_salary_per_town_per_category.csv`  
- À la **démographie locale** via `population.csv`

Ce fichier constitue ainsi un **pilier du modèle**, apportant un indicateur structurel essentiel sur la **vitalité économique des territoires**, et servant de point d’entrée pour explorer les **corrélations entre richesse locale, tissu économique, salaires et démographie**.

### 📁 FICHIER 2: name_geographic_information.csv

ce fichier contient des informations géographiques et administratives sur les circonscriptions françaises, avec les variables suivantes :

| **Nom de la variable**                  | **Description** | **Type** |
|----------------------------|----------------|---------------------|
| Circonscription française  | Nom ou code de la circonscription électorale. | Texte |
| Code région               | Code numérique associé à chaque région. | Entier |
| Nom de la région          | Nom officiel de la région. | Texte |
| Chef-lieu de la région    | Ville principale de la région. | Texte |
| Numéro du département     | Code départemental (ex. 75 pour Paris). | Entier |
| Nom du département        | Nom du département. | Texte |
| Préfecture               | Ville où se trouve la préfecture du département. | Texte |
| Numéro de circonscription | Identifiant numérique de la circonscription électorale. | Entier |
| Nom de la commune        | Nom de la ville ou du village. | Texte |
| Codes postaux            | Liste ou valeur unique du code postal de la commune. | Texte|
| CODGEO                   | Code géographique unique pour identifier une commune. | Texte |
| Latitude & Longitude     | Coordonnées GPS de la commune. | Flottant (2 valeurs) |
| Indice d’éloignement     | Mesure de distance par rapport à un centre administratif ou une grande ville. | Flottant |


Provenance des données : Ces informations proviennent de l’INSEE
Format : csv.

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
