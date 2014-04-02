---
layout: post
title: Configurer un blog Jekyll
category: Evaneos
author: clement
comments: true
---
Nous utilisons [Jekyll](http://jekyllrb.com) pour faire tourner ce blog technique. Il s'agit d'un générateur de blog statiques dynamiques : on écrit les articles au format markdown, et il n'est pas nécessaire d'avoir de base de données.

Voici quelques infos sur comment installer jekyll mettre en place un blog de ce genre, et commencer à écrire des articles.

## Installer Ruby

Les infos nécessaires sont sur le [site officiel](https://www.ruby-lang.org/fr/downloads/)

## Installer Jekyll

Les infos nécessaires sont sur le [site officiel](http://jekyllrb.com/docs/installation/)

## Récupérer du blog

Le code est sur [Github](https://github.com/Evaneos/Evaneos.github.io), il suffit de cloner le repository dans un répertoire local.

## Fonctionnement des articles

Comme indiqué, les articles sont au format markdown. Les détails sur la syntaxe se trouve dans la documentation officielle du format Markdown.

On stocke les articles publiés dans le répertoire _posts, et ceux en cours d'écriture dans le répertoire _drafts.
Dans un article publié, c'est le format du nom de fichier qui indique sa date de publication. Pour un brouillon, c'est la date de dernière modication du fichier. Un draft n'est affiché qu'en mode 'développement', il n'est visible qu'en local.

Tous les articles ont également une entête, qui contient ses méta données : auteur, tags, titre...

Ensuite, concernant le 

## Tester les articles en local

Pour tester les articles en local, il faut démarrer un server avec la commande suivante, après s'être placé dans le répertoire du blog :

    jekyll serve --watch --drafts

Cela démarre un serveur sur le port 4000, on peut donc visualiser le blog en [local](http://localhost:4000/)
L'option --watch permet de ne pas avoir à redémarrer le server à chaque modification d'un article, et --drafts permet d'afficher les brouillons dans la liste.





