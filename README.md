# Analyse des inégalités en France : Emploi, Salaires et Démographie  

# INTRODUCTION

Dans le cadre de notre projet de dataViz, notre équipe **Suits** a choisi d'explorer les données socio-économiques françaises afin de mettre en lumière les inégalités en matière d'emploi, de salaires et de de démographie. Notre objectif est d'offrir une analyse approfondie des disparités entre les différentes villes françaises en nous basant sur des données officielles fournies par **l'INSEE** (Institut National de la Statistique et des Etudes économiques). 
Notre étude reposera sur **quatre fichiers de données**, chacun apportant un éclairage spécifique sur les disparités observées en France : 

| **Nom du fichier**                           | **Description** |
|---------------------------------------------|------------------|
| **base_etablissement_par_tranche_effectif.csv** | Contient le nombre d’entreprises par commune française, classées selon leur taille. Permet d’analyser la répartition des entreprises sur le territoire. |
| **name_geographic_information.csv**         | Fournit des informations géographiques détaillées sur chaque ville (latitude, longitude, codes et noms des régions et départements). |
| **net_salary_per_town_per_category.csv**    | Présente les niveaux de salaires selon la ville, la catégorie professionnelle, l’âge et le sexe. Permet d'évaluer les **inégalités salariales** en France. |
| **population.csv**                           | Contient des données démographiques par commune, incluant l’âge, le sexe et le mode de vie des habitants. |

En croisant ce différentes sources de données, nous visons à : 

 - Identifier les inégalités économiques et démographiques entre les territoires français.  
 - Analyser la répartition des entreprises et son impact sur l'emploi et les salaires.  
 - Mettre en évidence les écarts salariaux en fonction de l’âge, du sexe et de la catégorie professionnelle.  
 - Avoir une vision claire de ce qui se passe dans les différentes régions pour mieux comprendre les problèmes liés aux inégalités entre les territoires.

Dans la suite de cette introduction, nous détaillerons les différentes dimensions contenues dans nos quatre fichiers de données et présenterons notre plan d'analyse.


## DONNEES

### FICHIER 1 : `base_etablissement_par_tranche_effectif.csv`

Ce fichier contient les données relatives au **nombre d'établissements (entreprises ou structures économiques)** présents dans chaque commune, classés par **tranche d’effectif salarié**. Chaque ligne représente une **commune unique**, identifiée par son code INSEE.

Nous avons choisi ce fichier car il donne une bonne idée de l’activité économique dans chaque commune. En connaissant le nombre d’entreprises et leur taille (TPE, PME, grandes entreprises), on peut mieux comprendre pourquoi certaines zones sont plus dynamiques que d’autres, ou pourquoi les salaires et la population active ne sont pas répartis de la même façon partout.

---

#### Format et structure

- **Format** : CSV   
- **Nombre de lignes** : environ 35 000 (une par commune)  
- **Nombre de colonnes** : 14  

---

#### Description des variables

| **Nom**        | **Type**    | **Description** |
|----------------|-------------|-----------------|
| `CODGEO`       | Nominale    | Code INSEE unique de la commune. Utilisé comme clé de jointure. |
| `LIBGEO`       | Nominale    | Nom de la commune. Sert à la lisibilité dans les visuels. |
| `REG`          | Ordinale    | Code de la région (2 chiffres). Sert à regrouper les communes par région. |
| `DEP`          | Ordinale    | Code du département. Permet une agrégation intermédiaire. |
| `E14TST`       | Numérique   | Nombre total d'établissements dans la commune. |
| `E14TS0ND`     | Numérique   | Établissements sans effectif connu ou non déterminé. |
| `E14TS1`       | Numérique   | Établissements de 1 à 5 salariés. |
| `E14TS6`       | Numérique   | Établissements de 6 à 9 salariés. |
| `E14TS10`      | Numérique   | Établissements de 10 à 19 salariés. |
| `E14TS20`      | Numérique   | Établissements de 20 à 49 salariés. |
| `E14TS50`      | Numérique   | Établissements de 50 à 99 salariés. |
| `E14TS100`     | Numérique   | Établissements de 100 à 199 salariés. |
| `E14TS200`     | Numérique   | Établissements de 200 à 499 salariés. |
| `E14TS500`     | Numérique   | Établissements de 500 salariés et plus. |

---

### Catégories d’entreprises selon l’INSEE

Pour notre analyse, on s’appuie sur la manière dont l’INSEE classe les entreprises selon leur nombre de salariés. C’est important car ça nous permet de mieux comprendre la taille des entreprises présentes dans chaque commune, et donc leur impact sur l’économie locale.

Voici les grands groupes que nous avons utilisés :

- **TPE (Très Petites Entreprises)** : entre **1 et 9 salariés**  
  → Cela correspond aux colonnes `E14TS1` (1 à 5 salariés) et `E14TS6` (6 à 9 salariés)

- **PME (Petites et Moyennes Entreprises)** : entre **10 et 249 salariés**  
  → Cela inclut `E14TS10` (10 à 19 salariés), `E14TS20` (20 à 49), `E14TS50` (50 à 99), `E14TS100` (100 à 199) et `E14TS200` (200 à 499)

- **Grandes entreprises** : **à partir de 500 salariés**  
  → Dans notre projet, nous avons décidé de considérer toutes les entreprises de la colonne `E14TS500` comme de grandes entreprises, même si cette catégorie peut inclure aussi bien des ETI que des très grandes entreprises.

Ce regroupement nous aidera à classer les communes selon le type d’entreprises qu’elles accueillent, et à voir comment cela peut influencer les salaires ou l’attractivité du territoire.

  **Source** : [INSEE - Définition des catégories d'entreprises](https://www.insee.fr/fr/statistiques/7678530?sommaire=7681078#documentation)

---

### FICHIER 2: name_geographic_information.csv

ce fichier contient des informations géographiques et administratives sur les circonscriptions françaises, avec les variables suivantes :

| **Nom de la variable**                  | **Description** | **Type** |
|----------------------------|----------------|---------------------|
| Circonscription française  | Nom ou code de la circonscription électorale. | Nominal |
| Code région               | Code numérique associé à chaque région. | Numérique |
| Nom de la région          | Nom officiel de la région. | Nominal |
| Chef-lieu de la région    | Ville principale de la région. | Nominal |
| Numéro du département     | Code départemental (ex. 75 pour Paris). | Numérique |
| Nom du département        | Nom du département. | Nominal |
| Préfecture               | Ville où se trouve la préfecture du département. | Nominal |
| Numéro de circonscription | Identifiant numérique de la circonscription électorale. | Numérique |
| Nom de la commune        | Nom de la ville ou du village. | Nominal|
| Codes postaux            | Liste ou valeur unique du code postal de la commune. | Nominal|
| CODGEO                   | Code géographique unique pour identifier une commune. | Nominal |
| Latitude & Longitude     | Coordonnées GPS de la commune. | Numérique |
| Indice d’éloignement     | Mesure de distance par rapport à un centre administratif ou une grande ville. | Numérique|


#### Format et structure

- **Format** : CSV   
- **Nombre de lignes** : environ 33704   
- **Nombre de colonnes** : 13

### FICHIER 3: net_salary_per_town_per_category.csv

Nous avons choisir d'inclure ce fichier dans notre analyse car il permettra d'évaluer les écarts de rénumération à plusieurs niveaux (géographique, professionnel et démographique).Il nous permettra donc de comprendre la répartition des revenus et détecter d'éventuelles inégalités salariales.


#### Format et structure

- **Nombre d’observations** : 5136 
- **Nombre de variables** : 26  
- **Format** : **CSV** 
- **Type des variables** :  
  - **Identifiants et localisation** : Codes et noms des villes (**variables qualitatives**).  
  - **Données numériques** : Salaires en milliers d'euros (**variables quantitatives continues**).  


| **Nom de la variable** | **Description** | **Type** |
|---------------------------|--------------------|------------|
| **CODGEO**  | Code unique de la ville | Nominal |
| **LIBGEO**  | Nom de la ville | Nominal|
| **SNHM14**  | Salaire net moyen | Numérique |
| **SNHMC14** | Salaire net moyen par heure pour les cadres | Numérique |
| **SNHMP14** | Salaire net moyen par heure pour les professions intermédiaires | Numérique |
| **SNHME14** | Salaire net moyen par heure pour les employés | Numérique |
| **SNHMO14** | Salaire net moyen par heure pour les ouvriers | Numérique |
| **SNHMF14** | Salaire net moyen des femmes | Numérique |
| **SNHMFC14** | Salaire net moyen par heure pour les femmes cadres | Numérique |
| **SNHMFP14** | Salaire net moyen par heure pour les femmes professions intermédiaires | Numérique |
| **SNHMFE14** | Salaire net moyen par heure pour les femmes employées | Numérique |
| **SNHMFO14** | Salaire net moyen par heure pour les femmes ouvrières | Numérique |
| **SNHMH14** |Salaire net moyen des hommes | Numérique |
| **SNHMHC14** | Salaire net moyen par heure pour les hommes cadres | Numérique |
| **SNHMHP14** | Salaire net moyen par heure pour les hommes professions intermédiaires | Numérique |
| **SNHMHE14** | Salaire net moyen par heure pour les hommes employés | Numérique |
| **SNHMHO14** | Salaire net moyen par heure pour les hommes ouvriers | Numérique |
| **SNHM1814** | Salaire net moyen par heure pour les 18-25 ans | Numérique |
| **SNHM2614** | Salaire net moyen par heure pour les 26-50 ans | Numérique |
| **SNHM5014** | Salaire net moyen par heure pour les plus de 50 ans | Numérique |
| **SNHMF1814** | Salaire net moyen par heure pour les femmes de 18-25 ans | Numérique |
| **SNHMF2614** | Salaire net moyen par heure pour les femmes de 26-50 ans | Numérique |
| **SNHMF5014** | Salaire net moyen par heure pour les femmes de plus de 50 ans | Numérique |
| **SNHMH1814** | Salaire net moyen par heure pour les hommes de 18-25 ans | Numérique |
| **SNHMH2614** | Salaire net moyen par heure pour les hommes de 26-50 ans | Numérique |
| **SNHMH5014** | Salaire net moyen par heure pour les hommes de plus de 50 ans | Numérique |

---


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

#### Format et structure

- **Nombre d’observations** : 1048575
- **Nombre de variables** : 6 
- **Format** : **CSV** 

# Description des variables du jeu de données

| **Nom de la variable**              | **Description**                                                      | **Type**       |
|----------------------------------|----------------------------------------------------------------|-------------|
| `CODGEO`                         | Code géographique de la commune                               | Nominal|
| `Nom de la commune`              | Nom de la commune correspondante                             | Nominal |
| `Mode de cohabitation`           | Type de cohabitation des individus                           | Nominal |
| `Tranche d’âge (code)`           | Tranche d’âge des individus (exprimée en code numérique)     | Numérique|
| `Sexe (1 = homme, 2 = femme)`    | Sexe des individus (1 pour homme, 2 pour femme)             | Nominal |
| `Nombre de personnes`            | Nombre total de personnes pour chaque combinaison de valeurs | Numérique |


## PLAN D'ANALYSE

Dans cette partie nous formulerons un ensemble de questions d'analyse qui nous permettront de parvenir à notre objectif principal, qui à titre de rappel consiste à faire ressortir les inégalités en matière d'emploi, de démographie et de salaire en France.

---

### Existe-t-il des différences significatives entre les salaires des différentes villes françaises ?
Cette question pourra nous permettre de mettre en lumière de potentielles disparités salariales géographiques. Les variables qui seront utilisées sont : **SNHM14** (le salaire moyen) et **LIBGEO** (nom de la ville) du fichier `net_salary_per_town_per_category.csv`.  
Notre objectif ici étant de faire une **comparaison** des différents salaires moyens par ville. Les visualisations envisagées sont : **une carte géographique** (choroplèthe), **un Bar Chart**.  
Comme information que nous pensons pouvoir obtenir : le fait que les grandes villes comme Paris aient des salaires plus élevés que les zones rurales ou petites villes.

---

### Comment les salaires varient-ils en fonction des catégories professionnelles (cadres, employés, ouvriers, etc.) ?
Cette question permettra d’observer les disparités salariales selon le statut professionnel. Les variables mobilisées sont : **SNHMC14**, **SNHMP14**, **SNHME14**, **SNHMO14** du fichier `net_salary_per_town_per_category.csv`.  
L’objectif est de réaliser une **comparaison entre groupes**. Les visualisations adaptées seront : **bar chart groupé** ou **boxplot**.  
Nous nous attendons à observer une hiérarchie des salaires, avec les cadres mieux rémunérés que les professions intermédiaires, elles-mêmes mieux rémunérées que les employés et ouvriers.

---

### Existe-t-il un écart salarial entre les hommes et les femmes dans chaque catégorie professionnelle ?
Cette question explore les disparités de genre au sein de chaque catégorie. Les variables sont : **SNHMFC14**, **SNHMFP14**, **SNHMFE14**, **SNHMFO14** pour les femmes et **SNHMHC14**, **SNHMHP14**, **SNHMHE14**, **SNHMHO14** pour les hommes.  
L’objectif est de faire une **comparaison par sexe** pour un même poste. Les visualisations proposées sont : **bar chart comparatif** ou **heatmap catégorielle**.  
Nous pensons mettre en évidence que les femmes sont souvent moins rémunérées que les hommes, y compris à poste équivalent.

---

### Existe-t-il des différences salariales spécifiques entre hommes et femmes dans certaines tranches d'âge ?
Nous utilisons ici les variables : **SNHMF1814**, **SNHMF2614**, **SNHMF5014**, **SNHMH1814**, **SNHMH2614**, **SNHMH5014**.  
L’objectif est de faire une **comparaison croisée** entre âge et genre. On s’attend à voir si l’écart salarial évolue avec l’âge. Les visualisations possibles sont : **bar chart groupé** ou **line plot**.  
Une difficulté potentielle sera la représentation inégale des tranches d’âge dans certaines communes.

---

### Comment le salaire moyen évolue-t-il en fonction de l'âge ?
Nous étudierons les variables **SNHM1814**, **SNHM2614**, **SNHM5014**.  
L’objectif est de représenter l’**évolution des salaires** au fil des tranches d’âge. Le type d’analyse est longitudinal et la visualisation envisagée est : **line plot**.  
Nous nous attendons à voir une augmentation des salaires avec l’âge jusqu’à un certain seuil. La limite est la granularité (tranches larges).

---

### Les communes où la proportion de grandes entreprises est élevée présentent-elles un salaire moyen plus élevé ?
Nous utiliserons la somme des entreprises de grande taille (**E14TS100**, **E14TS200**, **E14TS500**) et **SNHM14**.  
L’objectif est d’identifier une **relation entre variables numériques**. Le type de visualisation recommandé est : **scatter plot avec régression**.  
Nous pensons que les grandes entreprises influencent positivement les salaires, mais un biais pourrait venir de la taille des villes.

---

### Y a-t-il des écarts salariaux significatifs entre les hommes et les femmes selon les régions ou départements ?
Les variables exploitées seront : **SNHMF14**, **SNHMH14**, **REG**, **DEP**.  
L’objectif est de faire une **comparaison spatiale** des écarts hommes/femmes. Visualisation : **heatmap régionale**, **carte choroplèthe des écarts**.  
Nous pensons observer des inégalités plus fortes dans certaines régions, mais cela peut être influencé par des facteurs économiques locaux.

---

### La structure d’âge d’une commune influence-t-elle la taille moyenne des entreprises qui s’y installent ?
Les variables concernées seront extraites de `population.csv` (tranches d’âge) et des tranches d'effectif d'entreprises `E14TS*`.  
L’objectif est de tester une **relation entre population active et type d'entreprises**. Visualisation : **scatter plot**, **matrice de corrélation**.  
Une difficulté pourrait être le manque de données fines sur les âges exacts des travailleurs.

---

### Les communes isolées (géographiquement éloignées) sont-elles aussi celles où l’on observe les plus faibles niveaux de salaires et d’activité économique ?
Nous croiserons **SNHM14**, **E14TST** et l’indice **éloignement**.  
L’objectif est de rechercher une **corrélation géographique**. Les visualisations proposées sont : **scatter plot** et **carte de chaleur**.  
Le concept d'éloignement devra être précisé, car il peut englober divers critères.

---

### Le nombre d’habitants dans une tranche d’âge donnée (ex : 18–25 ans) influence-t-il les salaires moyens observés dans cette commune ?
Les données utilisées seront : **NB (effectif)** pour la tranche d’âge et **SNHM14**.  
Objectif : analyser une **relation entre population jeune et rémunération**. Visualisation : **scatter plot coloré**.  
On s’attend à voir que certaines communes jeunes (universitaires) ont un salaire moyen plus bas.

---

### Les régions les plus denses en population sont-elles aussi les plus diversifiées en termes de types d’entreprises ?
Variables mobilisées : **population totale** et diversité dans **E14TS*** (nombre de classes d’effectifs présentes).  
L’objectif est d’analyser la **corrélation entre densité et diversité économique**. Visualisation : **scatter plot** ou **bubble chart**.  
Une limite : comment définir le seuil pour qu’un type d’entreprise soit considéré comme “présent” dans une commune.

# Source
Lien Dataset : https://www.kaggle.com/datasets/etiennelq/french-employment-by-town

