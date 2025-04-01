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
- **Nombre de lignes** : 36682
- **Nombre de colonnes** : 14  

---

#### Description des variables

| **Nom**        | **Description**                                           | **Type**    |
|----------------|-----------------------------------------------------------|-------------|
| **CODGEO**     | Code INSEE unique de la commune. Utilisé comme clé de jointure. | Nominale    |
| **LIBGEO**     | Nom de la commune. Sert à la lisibilité dans les visuels. | Nominale    |
| **REG**        | Code de la région (2 chiffres). Sert à regrouper les communes par région. | Ordinale    |
| **DEP**        | Code du département. Permet une agrégation intermédiaire. | Ordinale    |
| **E14TST**     | Nombre total d'établissements dans la commune.           | Numérique   |
| **E14TS0ND**   | Établissements sans effectif connu ou non déterminé.     | Numérique   |
| **E14TS1**     | Établissements de 1 à 5 salariés.                         | Numérique   |
| **E14TS6**     | Établissements de 6 à 9 salariés.                         | Numérique   |
| **E14TS10**    | Établissements de 10 à 19 salariés.                       | Numérique   |
| **E14TS20**    | Établissements de 20 à 49 salariés.                       | Numérique   |
| **E14TS50**    | Établissements de 50 à 99 salariés.                       | Numérique   |
| **E14TS100**   | Établissements de 100 à 199 salariés.                     | Numérique   |
| **E14TS200**   | Établissements de 200 à 499 salariés.                     | Numérique   |
| **E14TS500**   | Établissements de 500 salariés et plus.                  | Numérique   |


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
| **EU_circo**                  | Nom ou code de la circonscription électorale. | Nominal |
| **Code_région**               | Code numérique associé à chaque région. | Numérique |
| **nom_région**          | Nom officiel de la région. | Nominal |
| **chef.lieu_région**    | Ville principale de la région. | Nominal |
| **numéro_département**     | Code départemental (ex. 75 pour Paris). | Numérique |
| **nom_département**        | Nom du département. | Nominal |
| **préfecture**               | Ville où se trouve la préfecture du département. | Nominal |
| **numéro_circonscription** | Identifiant numérique de la circonscription électorale. | Numérique |
| **nom_commune**       | Nom de la ville ou du village. | Nominal|
| **codes_postaux**            | Liste ou valeur unique du code postal de la commune. | Nominal|
| **Code_insee**                   | Code géographique unique pour identifier une commune. | Nominal |
| **Latitude & Longitude**     | Coordonnées GPS de la commune. | Numérique |

#### Format et structure

- **Format** : CSV   
- **Nombre de lignes** : 33704   
- **Nombre de colonnes** : 12

### FICHIER 3: net_salary_per_town_per_category.csv

Nous avons choisi d'inclure ce fichier dans notre analyse car il permettra d'évaluer les écarts de rénumération à plusieurs niveaux (géographique, professionnel et démographique).Il nous permettra donc de comprendre la répartition des revenus et détecter d'éventuelles inégalités salariales.


#### Format et structure

- **Nombre d’observations** : 5136 
- **Nombre de variables** : 26  
- **Format** : **CSV**

**Bon à savoir** : Les salaires contenus dans ce fichier sont donnés en milliers d'euros.

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

Ce fichier contient des informations démographiques organisées par commune. Chaque ligne du tableau correspond à une tranche d'âge spécifique, un mode de cohabitation et un genre, avec une colonne indiquant le nombre de personnes concernées.

#### Format et structure

- **Nombre d’observations** : 1048575
- **Nombre de variables** : 6 
- **Format** : **CSV** 


| **Nom de la variable**              | **Description**                                                      | **Type**       |
|----------------------------------|----------------------------------------------------------------|-------------|
| **CODGEO**                         | Code géographique de la commune                               | Nominal|
| **LIBGEO**              | Nom de la commune correspondante                             | Nominal |
| **MOCO**           | Type de cohabitation des individus                           | Nominal |
| **AGE80_17**           | Tranche d’âge des individus (exprimée en code numérique)     | Numérique|
| **SEXE**    | Sexe des individus (1 pour homme, 2 pour femme)             | Nominal |
| **NB**            | Nombre total de personnes pour chaque combinaison de valeurs | Numérique |

Bon à savoir : le mode de cohabitation dans ce dataset a été donné sous forme de codes avec les significations suivantes :

| Code | Description                                    |
|------|----------------------------------------------|
| 11   | Enfants vivant avec deux parents           |
| 12   | Enfants vivant avec un seul parent         |
| 21   | Adultes en couple sans enfant              |
| 22   | Adultes en couple avec enfants             |
| 23   | Adultes vivant seuls avec enfants          |
| 31   | Personnes vivant en colocation |
| 32   | Personnes vivant seules                    |



## PLAN D'ANALYSE

Dans cette partie nous formulerons un ensemble de questions d'analyse qui nous permettront de parvenir à notre objectif principal, qui à titre de rappel consiste à faire ressortir les inégalités en matière d'emploi, de démographie et de salaire en France.

---

### Existe-t-il des différences significatives entre les salaires des différentes villes françaises ?
Cette question pourra nous permettre de mettre en lumière de potentielles disparités salariales géographiques. Les variables qui seront utilisées sont : **SNHM14** (le salaire moyen) et **LIBGEO** (nom de la ville) du fichier `net_salary_per_town_per_category.csv`.  
Notre objectif ici étant de faire une **comparaison** des différents salaires moyens par ville. Les visualisations envisagées sont : **une carte géographique**, **un Bar Chart**.  
D'après un article rédigé par **Tatamo Ny Aina, publié le 27/05/2024 sur "les villes françaises où les habitants sont le mieux payés en 2024"**, il existe effectivemment des disparités salariales entre les différentes villes françaises. En effet cet article montre que la moyenne des salaires est plus élevée dans les grandes villes. On s'attends donc à obtenir une information comme quoi le salaire moyen est plus elevé à Paris qu'à Troyes.

**Source** : https://www.affairesinternationales.fr/voici-les-villes-francaise-ou-les-habitants-sont-le-mieux-payes-en-2024/

---

### Comment les salaires varient-ils en fonction des catégories professionnelles (cadres, employés, ouvriers, etc.) ?
Cette question permettra d’observer les disparités salariales selon le statut professionnel. Les variables mobilisées sont : **SNHMC14**, **SNHMP14**, **SNHME14**, **SNHMO14** du fichier `net_salary_per_town_per_category.csv`.  
L’objectif est de réaliser une **comparaison entre groupes**. Les visualisations adaptées seront : **bar chart groupé** ou **boxplot**.  
Si nous nous appuyons sur l'article publié par **editions-artalys le 30 janvier 2025 sur l'évolution du salaire moyen en France**, nous nous attendons à observer une hiérarchie des salaires, avec les cadres mieux rémunérés que les professions intermédiaires, elles-mêmes mieux rémunérées que les employés et ouvriers.

**Source** : https://www.editions-artalys.com/levolution-du-salaire-moyen-en-france-ce-que-vous-devez-savoir/#:~:text=Ces%20chiffres%20masquent%20des%20%C3%A9carts%20significatifs%20selon%20les,repr%C3%A9sente%20un%20facteur%20majeur%20dans%20l%E2%80%99%C3%A9volution%20des%20salaires 

---

### Existe-t-il un écart salarial entre les hommes et les femmes dans chaque catégorie professionnelle ?
Cette question explore les disparités de genre au sein de chaque catégorie. Les variables sont : **SNHMFC14**, **SNHMFP14**, **SNHMFE14**, **SNHMFO14** pour les femmes et **SNHMHC14**, **SNHMHP14**, **SNHMHE14**, **SNHMHO14** pour les hommes.  
L’objectif est de faire une **comparaison par sexe** pour un même poste. Les visualisations proposées sont : **bar chart comparatif** ou **heatmap catégorielle**.  
Nous pensons mettre en évidence que les femmes sont souvent moins rémunérées que les hommes, y compris à poste équivalent.

---

### Comment le salaire moyen évolue-t-il en fonction de l'âge ?
Nous étudierons les variables **SNHM1814**, **SNHM2614**, **SNHM5014**.  
L’objectif est de représenter l’**évolution des salaires** au fil des tranches d’âge. Le type de visualisation envisagée est donc : **une line chart**.  
Un article publié le 09/03/2019 dans **les clés du social sur l'évolution des salaires selon l'âge** stipule que le salaire net moyen est établi à 1350 € en moyenne à 25 ans, puis il augmente ensuite pendant 10 à 15 ans, stagne après autour de 2000 €, pour remonter dans les 10 dernières années de carrière jusqu’à 2300 € en moyenne. Nous nous attendons donc à obtenir une information selon laquelle le salaire moyen des séniors est plus élevé que celui des jeunes débutants.

**Source** : https://www.clesdusocial.com/comment-evoluent-les-salaires-selon-l-age#:~:text=Ainsi%2C%20le%20salaire%20net%20moyen%20est%20%C3%A9tabli%20%C3%A0,de%20carri%C3%A8re%20jusqu%E2%80%99%C3%A0%202%20300%20%E2%82%AC%20en%20moyenne.


---

### Les communes où la proportion de grandes entreprises est élevée présentent-elles un salaire moyen plus élevé ?
Nous utiliserons la somme des entreprises de grande taille (**E14TS100**, **E14TS200**, **E14TS500**) et **SNHM14**.  
L’objectif est d’identifier une **relation entre variables numériques**. Le type de visualisation recommandé est : **scatter plot avec régression**.  
Nous pensons que les grandes entreprises influencent positivement les salaires, mais un biais pourrait venir de la taille des villes.

---

### La structure d’âge d’une commune influence-t-elle la taille moyenne des entreprises qui s’y installent ?
Les variables concernées seront extraites de `population.csv` (tranches d’âge) et des tranches d'effectif d'entreprises **E14TS**.  
L’objectif est de tester une **relation entre population active et type d'entreprises**. Les types de visualisation envisagés sont donc : **un scatter plot**, **une matrice de corrélation**.  
Une difficulté pourrait être le manque de données fines sur les âges exacts des travailleurs.

---

### Les communes isolées (géographiquement éloignées) sont-elles aussi celles où l’on observe les plus faibles niveaux de salaires et d’activité économique ?
Nous croiserons **SNHM14**, **E14TST** et l’indice **éloignement**.  
L’objectif est de rechercher une **corrélation géographique**. Les visualisations proposées sont : **scatter plot** et **carte de chaleur**.  
Le concept d'éloignement devra être précisé, car il peut englober divers critères. Nous nous documentons encore sur la signification de ce concept.

---

### Les régions les plus denses en population sont-elles aussi les plus diversifiées en termes de types d’entreprises ?
Variables mobilisées : **population totale** et diversité dans **E14TS*** (nombre de classes d’effectifs présentes).  
L’objectif est d’analyser la **corrélation entre densité et diversité d'entreprises**.Les types de visualisation envisagés sont donc : **un scatter plot** ou **une bubble chart**.  


**Source**
Lien Dataset : https://www.kaggle.com/datasets/etiennelq/french-employment-by-town

