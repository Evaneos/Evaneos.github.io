---
layout: post
title: Configuration d'applications Javascript
category: Evaneos
comments: true
author: clement
---

Dans cet article je vais vous présenter comment nous gérons les déploiements d'applications javascript. Notre backoffice est constitué d'un grand nombre d'applications ayant chacun un rôle propre. Il y a notamment plusieurs CRUD pour les différents rôles métiers et les différents aspects de notre travail, ainsi que des outils de statistiques pour les différents pôles. Bref pour répondre aux divers besoins métiers, pour être efficace, et pour éviter la duplication, l'utilisation de Grunt et Bower s'est avérée être un atout.

### Bower pour la gestion des dépendances

Les librairies externes sont gérées via [Bower](http://bower.io/), un gestionnaire de dépendances pour les librairies Javascript, qui tourne sous NodeJS. On lui fournit un fichier JSON de configuration, et les librairies sont téléchargées dans un répertoire local. C'est notamment dans ce fichier de configuration que l'on spécifie les numéros de version à utiliser.

L'utilisation de Bower a permis de centraliser les librairies externes, qui avant ne suivaient pas de véritable logique : quand on avait besoin d'une librairie, on la téléchargeait, et la mettait dans un répertoire public. Cela fonctionne bien à très court terme, mais devient vite compliqué dès qu'on veut mettre à jour une librairie, ou utiliser une librairie déjà présente car on ne sait pas qui s'en sert. Bref, cela n'était plus compatible avec nos besoins d'industrialisation.

Comme nous utilisons un seul fichier de configuration Bower, toutes les applications du backoffice doivent fonctionner avec des librairies dans la même version. Cette contrainte nous permet d'éviter de multiplier les différences de versions entre les applications, mais peut être source de régressions difficiles à anticiper lorsque les librairies utilisées introduisent des changements non-rétrocompatibles.


### Grunt comme chef d'orchestre

[Grunt](http://gruntjs.com/) sert à configurer et exécuter des tâches récurrentes. Nous utilisons Grunt pour gérer les tâches liées au développement ou au déploiement des différentes applications du backoffice. Chez nous cela signifie principalement :
- la concaténation et la minification des différents fichiers JS
- la compilation des fichiers LESS en CSS

#### Gestion de la configuration d'une application

Chaque application correspond à une Single Page Application (SPA) qui contient quelques écrans. Elle est associée à un contrôlleur PHP, et est configurée par un fichier Yaml, ce qui permet l'utilisation du fichier de configuration à la fois côté javascript et côté PHP.

Voici un exemple de ce que peut contenir un fichier de configuration d'une application :

    id: dashboard
    name: Dashboard
    acl:
        - ROLE_ADMIN
        - ROLE_DEVELOPPER
        - ...
    dependencies:
        - jquery
        - underscore
        - angular
    icon: icon-dashboard

Ce fichier est mangé par Grunt qui s'en sert pour connaître les dépendances lorsqu'il faut générer le javascript compilé d'une application. Il est également utilisé par la partie PHP pour gérer le reste : affichage de la bonne icône dans un menu, gestion du contrôle d'accès pour les contrôleurs associés...

#### Compilation d'une application

La compilation est relativement simple : on concatène tous les fichiers javascripts de l'application en un fichier, et on minifie le tout. On produit un fichier du type nom_de_lapplications.js (ou nom_de_lapplications.min.js si minifié).
Pour les librairies, on concatène toutes les librairies en un fichier vendor_nom_de_lapplications.min.js.

Dans le contrôleur de l'application, quand on charge le fichier de configuration on sait dans quelle application on se trouve, et donc quels sont les fichiers javascript à inclure.

Pour le CSS, c'est la même chose.

#### Déploiement d'une application

Comme dit précédemment, nous avons des tâches de compilation pour les fichiers Javascript et pour le CSS. Une fois compilé, les fichiers compilés ne sont pas inclus parmi les fichiers versionnés de Git. Cela n'a en effet pas de sens de versionner des fichiers compilés, qui n'ont pas grand chose à voir avec l'historique des tâches de développement.

On ne peut donc pas réaliser un déploiment classique (qui revient grossièrement à un git pull).

Au lieu de cela, la mise en ligne des fichiers compilés (javascript et css) se fait via un rsync dans le répertoire où les fichiers doivent arriver.

#### Et la gestion d'environnement ?

En développement, il est assez désagréable de devoir concaténer tous les fichiers javascripts à chaque modification, et c'est encore pire lorsque l'on travaille avec les fichiers less.

Afin de rendre le développement plus fluide, le fonctionnement est donc légèrement différent:

- côté CSS, une tâche grunt surveille les fichiers less, et les recompile à chaque modification
- côté Javascript, ce n'est pas le fichier compilé qui est inclus dans la page, mais les différents fichiers, dans l'ordre où ils seront compilés. La seul véritable différence qu'il peut y avoir lors de la mise en production vient de la concaténation/minification, qui doit être testée avant un déploiement.



Evidemment, bien que Grunt et Bower nous ait apporté beaucoup, tout n'est pas rose. Configurer des tâches Grunt est particulièrement désagréable, car la syntaxe utilisée n'est pas pratique. De plus, la courbe d'apprentissage n'est pas aussi rapide que nous le pensions au départ. Mais une fois mis en place, cela nous a permis d'uniformiser la conception et le déploiement des applications.


