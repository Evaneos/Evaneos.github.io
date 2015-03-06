---
layout: post
title: Plugin Slack pour locker des environnements
category: Evaneos
author: tilap
comments: true
---

Chez **Evaneos**, nous utilisons [Slack](http://slack.com/) pour communiquer entre nous. Voici un petit exemple simple que nous permet cet outil fabuleux.

## Tu ne connais pas Slack ???

 **Slack** est un outil de discussion pour équipe. Il reprend le fonctionnement de base d'_IRC_, amplement enrichi d'une surcouche d'**ergonomie**, de **versions applicatives** mobile et desktop, ainsi que d'une pléthore de **fonctionnalités additionnelles**.

Parmi ces fonctionnalités, la **possibilité d'intégrer des outils tiers** en font une killer app. A coté des intégration "out-of-the-box" comme github, rss, trello, jira, vous pouvez développer vos propres outils.


## Notre besoin

### Environnement, es-tu libre ?

Les développeurs d'**Evaneos** ont plusieurs environnements à disposition. Ils y déploient leur code afin de le vérifier, le faire valider, reproduire des cas complexes de bugs, ou bien préparer des mises en production.

Mais le nombre de ces environnements est limité. Les développeurs sont donc obligés de prévenir tout le monde lorsqu'ils en utilisent un, sous peine de voir leur environnement pris par un autre développeur.

### Jusqu'à maintenant...

Historiquement, nous avions un chan Skype, puis Slack, sur lequel nous marquions "environnement-3 locked" ou "environnement-3 unlocked". Et nous parcourions l'historique de la discussion pour savoir si l'environnement était disponible ou pas.

_Bref, paye ta galère_

Avec la multiplication des environnement (et des développeurs), c'est vite devenu compliqué à suivre. Nous avons pensé à faire un page web simple - après tout c'est notre job et c'est facile à faire - mais ça rajoutais un outil de plus. De là, l'idée d'intégrer ce système de "lock" dans slack était évidente.

## Cerbère

"Cerbère" est un script simple, codé en PHP-simple-mais-qui-marche, hébergé sur un serveur distant (un serveur à vous). Le code est disponible sur [github](https://github.com/tilap/slack-cerbere)

#### Ce qu'il sait faire...

Lors du lancement de commandes spécifiquement configurées dans Slack, le script est appellé via un POST http, exécute la commande (avec des arguments en option), renvoit un résultat et interagit avec les chans de Slack en fonction de ces besoins.

Dans notre cas, nous avons ajouté 3 commandes :

- `/cerbere`
- `/lock`
- `/unlock`

La commande `/cerbere` dispose de plusieurs arguments possibles (help, add, remove, status, ...) et permet d'ajouter, supprimer, consulter les status des différents environnements. De cette façon, l'outil reste flexible par rapport à la montée en nombre des environnements de dev que nous avons.

Pour chaque environnement, le script stocke son statut (locked ou unlocked) et un court historique avec utilisateur et date.

A la reception de la commande `/lock` ou `/unlock`, il met à jour le statut et l'historique. Bien entendu, il s'assure que l'environnement en question est disponible, sinon indique qui l'a locké et depuis quand.

Un autre avantage de ce **Cerbere** intégré à Slack, c'est qu'il n'y a plus besoin de chan. La commande est exécutable de n'importe quel chan de discussion, et le résultat rendu n'est visible que par l'utilisateur l'ayant appelé. Pour la forme, un chan de log technique est un chan de log fonctionnel indiquant tous les changements faits est possible.

#### Mort programmée

Cerbère sera sûrement remplacé dans les temps à venir par un système de token géré directement dans les scripts de déploiement.

En attendant cette amélioration vers une intégration continue plus forte, je pense à parfaire la commande `/cerbere bite` (mordre en anglais) qui permet, adjoint à un cron, de rappeller aux développeurs ayant locké un environnement de ne pas oublier de le libérer. Son implémentation a déjà commencée, le système de notification restant à parfaire.

## Liens utiles

- [Slack](https://slack.com/), le système de messagerie
- Le repo du projet [Cerbere](https://github.com/tilap/slack-cerbere) : https://github.com/tilap/slack-cerbere
- La [documentation](https://api.slack.com/) Slack pour y voir l'étendue de ses possibilités
