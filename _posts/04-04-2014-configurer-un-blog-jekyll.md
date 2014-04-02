---
layout: post
title: Configurer un blog Jekyll
category: Evaneos
author: clement
reviewer: tilap
comments: true
---
Nous utilisons [Jekyll](http://jekyllrb.com) pour faire tourner ce blog technique. Il s'agit d'un générateur de blog statiques : on écrit les articles au format markdown, qui sont ensuite généré en html. Il n'est donc pas nécessaire d'avoir de base de données, allégeant le serveur, et permettant un rendu rapide des pages pour le lecteur.

Voici quelques infos sur comment installer *Jekyll* mettre en place un blog de ce genre, et commencer à écrire des articles.

## Installation

**Installer Ruby**

Les infos nécessaires sont sur le [site officiel](https://www.ruby-lang.org/fr/downloads/)

**Installer Jekyll**

Les infos nécessaires sont sur le [site officiel](http://jekyllrb.com/docs/installation/)

**Récupérer du blog vierge**

Le code est sur [Github](https://github.com/Evaneos/Evaneos.github.io), il suffit de cloner le repository dans un répertoire local.

## Fonctionnement des articles

Comme indiqué, les articles sont au format markdown. La syntaxe est simple mais relativement riche, donc le plus simple est de se référer à la [documentation](http://daringfireball.net/projects/markdown/syntax). Pour les plus frileux, il existe des éditeurs en ligne tel que [Stackedit](https://stackedit.io/) permettent une édition WYSIWYG du markdown.

Sur Jekyll, les articles publiés sont stockés dans le répertoire *_posts*, et les articles en cours d'écriture dans le répertoire *_drafts*.
Dans un article publié, c'est le format du nom de fichier qui indique sa date de publication. Pour un brouillon, c'est la date de dernière modication du fichier. Un draft n'est affiché qu'en mode 'développement' et n'est donc visible qu'en local.

Tous les articles ont également une entête, qui contient ses méta données : auteur, tags, titre... Ce sont les fichiers du répertoire *_layout* qui s'occupent de faire le lien entre ces meta données, et leur rendu dans la page. Au besoin, ces entêtes peuvent être enrichies et réutilisées pour des besoins plus spécifiques.

### Tester les articles en local

Pour tester les articles en local, il faut donc :

* avoir installé Ruby et Jekyll
* se placé dans le répertoire du blog

Ensuite, on peut démarrer un server avec la commande suivante :

    jekyll serve --watch --drafts

Cela démarre un serveur sur le port 4000, on peut donc visualiser le blog en [local](http://localhost:4000/)
L'option --watch permet de ne pas avoir à redémarrer le server à chaque modification d'un article, et --drafts permet d'afficher les brouillons dans la liste des articles.

## Hébergé par Github ?

Une fois votre blog réalisé, vous pouvez l'héberger gratuitement sur un sous domaine de [Github.io](http://github.io/) sous réserve d'héberger votre projet sur un repo Github. Il vous suffit pour cela de créer un repo username.github.io, et tout sera synchronisé en post hook de façon transparente.

Vous avez aussi la possibilité de mettre votre propre nom de domaine très facilement. Pour plus de renseignement, rendez vous sur [Github.io](http://github.io/).









