---
layout: post
title: Configurer un blog Jekyll
category: Evaneos
author: clement
comments: true
---
Nous utilisons [Jekyll](http://jekyllrb.com) pour faire tourner ce blog technique. Il s'agit d'un générateur de blog statiques : on écrit les articles au format markdown, et il n'est pas nécessaire d'avoir de base de données.

Voici quelques infos sur comment installer jekyll mettre en place un blog de ce genre, et commencer à écrire des articles.

## Installer Ruby et Jekyll 

Les informations nécessaires sont sur les sites officiels de [Ruby](https://www.ruby-lang.org/fr/downloads/) et [Jekyll](http://jekyllrb.com/docs/installation/)

Sur Ubuntu, cela revient à :

    sudo apt-get install ruby1.9-dev && gem install jekyll

## Récupérer du blog

Le code est sur [Github](https://github.com/Evaneos/Evaneos.github.io), il suffit de cloner le repository dans un répertoire local.

## Fonctionnement des articles

Comme indiqué, les articles sont au format markdown. La syntaxe est simple mais relativement riche, donc le plus simple est de se référer à la [documentation](http://daringfireball.net/projects/markdown/syntax); des éditeurs en ligne tel que [Stackedit](https://stackedit.io/) permettent une édition WYSIWYG du markdown.

On stocke les articles publiés dans le répertoire _posts, et ceux en cours d'écriture dans le répertoire _drafts.
Dans un article publié, c'est le format du nom de fichier qui indique sa date de publication. Pour un brouillon, c'est la date de dernière modication du fichier. Un brouillon n'est affiché qu'en mode 'développement', il n'est donc visible qu'en local.

Tous les articles ont également une entête, qui contient ses méta données : auteur, tags, titre... Ce sont les fichiers du répertoire _layouts qui s'occupent de faire le lien entre ces meta données, et leur rendu dans la page.

## Tester les articles en local

Pour tester les articles en local, il faut donc :
* avoir installé Ruby et Jekyll
* se placer dans le répertoire du blog

Ensuite, on peut démarrer un serveu avec la commande suivante :

    jekyll serve --watch --drafts

Cela démarre un serveur sur le port 4000, on peut donc visualiser le blog en [local](http://localhost:4000/)
L'option --watch permet de ne pas avoir à redémarrer le serveur à chaque modification d'un article, et --drafts permet d'afficher les brouillons dans la liste des articles.





