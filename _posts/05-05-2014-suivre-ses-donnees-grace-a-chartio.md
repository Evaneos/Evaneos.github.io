---
layout: post
title: Suivre ses données grâce à Chart.io
category: Evaneos
author: clementn
comments: true
---

## Introduction

Chart.io, ou Chartio, est un site permettant d'effectuer des requêtes sur diverses bases de données de façon simplifiée, et de les afficher sous forme graphique.
Nous avons choisi cet outil afin de suivre l'évolution de nos données. Nous allons dans cet article vous en expliquer les raisons ainsi que le fonctionnement de Chartio.

## Concurrence

Ces derniers mois plusieurs outils de *Data Analysis* ont émergé et levé des fonds pour se développer. On peut citer notamment : **BIME Analytics, Birst, DataHero, Datameer** ou **Chartio**.
Nous avons essayé deux d'entre eux :

- **[BIME Analytics][1] :** cette start-up française, dont le siège se situe à Montpellier, a levé 3 millions d'euros en novembre 2013 pour se développer. Nous avons profité de l'offre d'essai gratuite, et avons ainsi pu mesurer les fonctionnalités proposées.
BIME offre la possibilité de stocker directement ses données sur le *cloud*  grâce à *Déjà vu*, dans la limite de 250.000 lignes. Une fois les bases connectées, il est nécessaire de construire les jointures entre les bases et d'écrire une requête SQL pour ne sélectionner que les colonnes qui nous intéressent. Cette étape franchie, il est possible de faire à peu près tout ce que l'on souhaite : BIME met à disposition tous les formats graphiques imaginables (par exemple un planishpère, qui permet d'afficher nos données sur une carte Google Map), nous autorise de multiples filtres, le choix des couleurs, du format... Tout cela se fait par *drag-and-drop*. Par contre, il n'est plus possible à ce stade de retrouver le nom de la table de laquelle une colonne a été issue. Ainsi, deux encarts pourront s'appeler "id" sans que l'on sache à quoi ils font référence. (Nous avons signalé ce problème lors de l'essai, et il a été remonté aux ingénieurs de BIME)
Les graphiques créés sont ensuite aposés sur des tableaux de bords. Ils sont très maléables, ont peut y ajouter du texte, des images... Il est possible de les partager publiquement, où au contraire d'en restreindre l'accès.
Pour résumer : une "machine de guerre" qui demande un certain coût au démarrage, pour la mise en place et la prise en main.

- **[Chartio][2] :** basé à San Franciso, Chartio est plus jeune que BIME et a levé 2,2 millions de dollars en janvier 2014. Leur jeunesse fait qu'ils sont très réactifs et à l'écoute de toute proposition d'amélioration.
Au niveau de la connexion, Chartio vient taper directement dans notre base de données via un tunnel SSH. Lors de la création d'un graphe, toutes les colonnes sont sélectionnables et l'on a la possibilité d'effectuer des requêtes soit en *drag-and-drop*, soit en entrant directement son code SQL. L'inconvénient majeur est qu'on ne peut joindre deux bases de données différentes entre elles. On peut par contre, une fois les données sélectionnées, effectuer des calculs sur celles-ci (et ainsi par exemple sommer deux chiffres provenants de deux bases distinctes).
Les possibilités d'affichage sont moins larges que BIME mais suffisantes (courbes, histogrammes, KPI...).


**Pourquoi Chartio plutôt que BIME ?**
Il faut savoir tout d'abord que les deux solutions nous étaient proposées à des tarifs à peu près équivalents (Chartio propose un tarif basé sur le nombre de comptes, tandis que BIME propose simplement un tarif mensuel). Si nous avons retenu Chartio, c'est essentiellement parce qu'il offre la possibilité à n'importe qui d'effectuer des requêtes SQL et de les mettre en page, à partir du moment où l'on connaît la signification des tables.
De plus, leur réactivité et amélioration continue a fait pencher la balance en leur faveur.

## Fonctionnement de Chartio

### Data Sources

Nous l'avons dit, Chartio se connecte directement à nos bases de données (MySQL, PostgreSQL, Oracle...). Mais ce n'est pas tout : il est aussi possible de connecter ses données Google Analytics, ou encore ses clouds Amazon. On peut également ajouter directement nos données Excel au format .CSV.

### Dashboards

Chartio est organisé en tableaux de bords, sur lequel on peut ajouter graphiques et textes, et les disposer à notre guise. On peut programmer l'envoi de rapport au format pdf à heure fixe.
Il est possible d'ajouter des filtres globaux sur un dashboard, qui seront appliqués à l'ensemble des *charts* présents sur celui-ci. Ce peut être des filtres de date, qui sélectionneront entre quelles dates les données doivent être retenues.

### Charts

Les *charts* sont les éléments présents sur les *dahsboards* : tableaux, courbes, histogrammes... 
La création d'un *chart* peut se faire de deux manières : en *drag-and-drop* ou bien en tapant directement sa requête SQL. La méthode *drag-and-drop* est très intuitive : on sélectionne ce que l'on mesure ("l'ordonnée"), selon quoi ("l'abscisse", bien souvent la date), et selon quels filtres.
Nos données sont sélectionnées et l'on peut ensuite faire des opérations sur elles avant de les afficher. Il est possible d'exporter les résultats au format .CSV.

## Le mot de la fin

En conclusion, Chartio nous est utile pour suivre nos données quotidiennement et croiser les données de nos bases avec Analytics. Les filtres globaux nous sont particulièrement utiles pour sélectionner notamment le marché concerné. Nous avons soumis plusieurs requêtes d'amélioration au support, toujours prompt à répondre et réceptif à nos propositions.



  [1]: http://fr.bimeanalytics.com/
  [2]: https://chartio.com/
