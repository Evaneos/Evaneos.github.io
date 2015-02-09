---
layout: post
title: Le déploiement chez Evaneos aujourd'hui
category: Evaneos
author: clement
reviewer: tilap
comments: true
---

La gestion du déploiement est un problème complexe, il nous fallu du temps pour mettre en place une solution industrialisée. Le besoin est arrivé lorsque tout s'est mis à grossir : la pile applicative, les projets et leurs besoins, et le nombre de personnes dans l'équipe.

*Cet article est le second d'une série de trois, où nous verrons :*

 1. *Avant : Comment nous avons géré les déploiement lorsque l'équipe et le projet était réduit*
 2. *Aujourd'hui : Comment nous faisons actuellement*
 3. *Demain : Quels sont les problèmes auxquels nous sommes confrontés aujourd'hui, et vers où nous nous dirigeons*

## Aujourd'hui

Evaneos a beaucoup grandi et, inévitable, de la complexité s'est rajoutée. Au niveau applicatif, on est passé en quelques mois d'une application monolithique PHP à :
 - plusieurs applications (le site public frontal, outils backoffice, applicatifs divers, API REST...)
 - plusieurs projets qui sont réalisés en parallèle
 - plusieurs technos front et back (PHP, node, javascript côté client)
 - plusieurs étapes à ne pas oublier pour faire un déploiement : chaque application compile ses ressources et les déploie via des outils (des scripts gulp).

Il est rapidement devenu impensable de continuer à déployer à la main. Comme l'équipe elle aussi s'est agrandie, nous en sommes arrivés à mettre en place un outil spécifique pour le déploiement de nos différents projets. On le fait régulièrement évoluer pour s'adapter à nos besoins toujours en mouvement.

## D'une VM bricolée à Docker

En parallèle de l'amélioration du déploiement, nous avons amélioré nos environnement de développement. Au lieu d'une machine virtuelle globalement identique à la prod mais installé manuellement, tout le monde a la même machine, qui vit dans un **container [docker](https://www.docker.com/)**. Il suffit de récupérer le script d'installation, de créer le container et tout se fait bien pour tout le monde. Plus flexibles et légers que les machines virtuelles classiques, on a rapidement été séduits.

... bon, ok, ça pose encore parfois problème pour les gens qui ont des Mac à cause de la manière dont docker fonctionne, mais globalement, on a vraiment gagné en confort et en uniformité.

## Le script de déploiement

Parlons maintenant de l'outil de déploiement. Le déploiement se fait maintenant depuis les machines de développement, il n'est plus nécessaire de se connecter soi même en SSH sur la machine de préproduction puis de production (même si, en arrière plan, c'est ce qui se passe) pour exécuter toutes les commandes nécessaires au déploiement. 

Nous en avons profité pour ajouter la possibilité de réaliser le déploiement sur notre serveur d'intégration, un serveur dans nos locaux qui sert pour faire la validation des tâches pendant les projets.

Comme le déploiement est devenu un peu plus compliqué que le git pull amélioré que nous avons longtemps utilisé (cf l'article précédent), nous avons du mettre de côté notre script bash. Nous avons choisi **[Fabric](http://www.fabfile.org/)**, un outil de déploiement en python un peu plus sérieux. Le script est dans un répertoire du projet (de même que la configuration docker), et tout le monde le récupère en même temps que le dépôt Git.

Faire un déploiement, pour le développeur, est du coup très simple, il suffit d’exécuter une commande qui ressemble à :

```
$ fab [nom du serveur où déployer] [branche éventuelle à déployer] deploy
```

En arrière plan, le script fait ceci :

  - Il **télécharge le code** demandé dans un nouveau répertoire sur le serveur demandé
  - Il **récupère les dépendances** des différents projets via composer, npm et bower
  - Il joue les **tâches gulp** (compilation du JS, du CSS, mise en cache diverses, déploiement des assets), et il **exécute les divers scripts**.
  - Grâce à des liens symboliques, il place les **fichiers de configuration** au bon endroit
  - Dernière étape, le déploiement est activé à l'aide d'un **lien symbolique** du répertoire pointé par le vhost du serveur vers le répertoire dans lequel le déploiement vient d'être réalisé

Comme dans un script on fait ce qu'on veut, nous avons ajouté quelques fonctionnalités sympa :

  - il envoie une **notification sur [Slack](http://slack.com)**. C'est l'outil de discussion temps réel utilisé par l'équipe. Comme ça, l'équipe est prévenue qu'un déploiement/rollback a lieu. Lorsque le déploiement réussit ou échoue il y a également une notification et oui, ces notifications contiennent des emojis rigolos.
  - il **notifie toujours [NewRelic](http://newrelic.com/)**, afin de faire du monitoring en conséquences.

## Différentes manières de déployer

Le fonctionnement du script que j'ai décrit s'insert dans notre méthodologie de gestion de projets. On ne déploie pas n'importe quoi n'importe quand, et on ne le fait pas de la même manière sur le serveur d'intégration qu'en prod.

### Dans les environnements de développement et de validation

Sur les serveurs de dev, on déploie n'importe quelle branche a n'importe quel moment. Cela permet de faire la validation nécessaire au cours du projet (Scrum, kanban, mix de tout ça... la méthodologie dépend de beaucoup de choses et évolue elle aussi constamment).
Nous ne générons **pas d'environnement à la volée**, mais nous avons suffisamment d'environnement de tests sur lesquels déployer sur notre serveur interne pour faire valider n'importe quelle fonctionnalité. Vu que l'on pousse une branche, on peut tester la fonctionnalité en isolation (par exemple dans le cadre d'un POC). Le plus souvent, on conserve un environnement pendant le temps d'un projet, on déploie les fonctionnalités au fur et à mesure. La personnes (ou les personnes, parfois) en charge de la validation effectue les validations quand elle en a l'occasion, et à la fin du projet on peut déployer en production.

### Déploiement en production

En préprod et prod, on ne déploie pas n'importe quoi. Il faut d'abord taguer (au sens git, via git tag) une version stable et mettable en ligne de la branche master dans laquelle on a rapatrié tout ce qu'on souhaite ajouter (branche de projet, de bugfix, etc). Le déploiement se fait alors à partir de ce tag. On utilise [semver](http://semver.org/) pour nommer les tags.

### Et donc ?

Ce fonctionnement est plutôt pratique et permet de déployer les différents projets de manière simple, sur les différents environnements. En préproduction et en production, on a aucune question à se poser: si le déploiement marche en préprod, il passera en prod.

## Les limites ?

Le fonctionnement actuel n'est pas encore parfait, et il reste encore des choses à améliorer pour gagner encore en fluidité et en rigueur.

### La gestion des environnements et des bases de données

La manière dont on fonctionne avec les environnement de validation est parfois une limitation. On doit discuter avec les autres équipes pour demander qui utilise quel environnement et pour combien de temps encore. Quand on fait valider quelquechose, il faut indiquer à la personne que non, il ne faut plus valider dans l'environnement A, mais dans le B cette fois ci.

Au niveau des bases de données, on danse d'une manière un peu similaire, ce qui peut amener à des incompréhensions ou des problèmes de configuration pour certains environnement.

### Les ressources externes

Nous avons deux problèmes avec les ressources externes : 

 - Récupérer les dépôts via composer/npm/bower est effroyablement long et prend un temps considérable
 - La compilation des ressources se fait sur le serveur qui les exploite. C'est un problème pour deux raisons d'une part, c'est long, d'autre part, cela oblige a installer des applicatifs sur le serveur de production. Ces applicatifs (gulp et tous les outils de compilation associés par exemple) ne sont pas nécessaires à l'exécution de l'applicatif à proprement parler. De plus, ils peuvent augmenter la surface d'attaque.

Dans le prochain article, je reviendrais sur les problèmes que nous avons avec ce fonctionnement, et je présenterais les solutions que nous sommes en train de mettre en place pour les résoudre.
