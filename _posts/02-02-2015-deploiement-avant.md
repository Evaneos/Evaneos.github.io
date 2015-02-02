---
layout: post
title: Retours sur le déploiement chez Evaneos
category: Evaneos
author: clement
reviewer: tilap
comments: true
---

La gestion du déploiement est un problème complexe, il nous fallu du temps pour mettre en place une solution industrialisée. Le besoin est arrivé lorsque tout s'est mis à grossir : la pile applicative, les projets et leurs besoins, et le nombre de personnes dans l'équipe.

Cet article est le premier d'une série de trois, où nous verrons :

 1. Avant : Comment nous avons géré les déploiement lorsque l'équipe et le projet était réduit
 2. Aujourd'hui : Comment nous faisons actuellement
 3. Demain : Quels sont les problèmes auxquels nous sommes confrontés aujourd'hui, et vers où nous nous dirigeons

## Anciennement

Dans ce premier article, nous allons revenir sur la méthode utilisée pour déployer lorsque l'équipe était réduite et que l'application était "simple".

Longtemps, le déploiement du code en production s'est fait de manière très simple. Nous n'avions qu'un seul gros projet en PHP, contenant le site public et son backoffice. A ce moment là du projet, lorsque l'équipe était réduite, diverses astuces ont permis de ne pas avoir à mettre en place un processus compliqué de développement et de déploiement.

### Les ressources externes 

Les ressources externes, par exemple. Nous n'avions pas besoin de précompiler les ressources. Grâce à divers bricolages, un script listait les fichiers javascripts nécessaires sur une page, et les aggrégait à la volée avant de les servir. Ca coute un peu plus cher côté serveur, mais une fois mis en cache, le problème ne se pose pas trop. Nous faisions pareil avec les fichiers Less, qui étaient de plus compilés à la volée en CSS.
Lorsque nous n'avions pas de serveur d'intégration, chacun développait sur sa machine, on vérifiait que tout marchait bien en déployant sur la machine de préproduction (identique à la machine de prod), et une fois le feu vert reçu par les personnes responsables du projet en question, on déployait en prod.

### Déployer le code

Pour déployer en préproduction, à cette époque on ne s'embétait pas trop. on va dans le répertoire du projet, git pull origin master et roulez jeunesse.
De toute façons, à partir du moment où la fonctionnalité était dans master elle devait être déployée. S'il y avait des problèmes, il fallait les corriger, le passage en préprod était un bon moyen d'identifier les problèmes éventuels dans un environnement au plus proche de la production.

Pour deployer en production, on prenait un peu plus de gants.
Un simple script bash a longtemps fait le travail. On se connectait sur le serveur en SSH, puis executait le script de déploiement :

    $ ev_create_branch nom_de_la_fonctionnalite

Le nom du script n'était pas forcément très clair, mais comme nous étions 4 dans l'équipe, tout le monde savait ce qu'il se passait. Ce script  :
- crée une nouvelle branche git avec la date courante et le nom du déploiement 
- récupére le code de la branche master via git dans cette nouvelle branche.
Une mise à jour manuelle d'une clé dans fichier de configuration permettait d'invalider le cache pour certaines ressources (les assets javascripts et css).

Ainsi, quand tout va bien, il n'y a rien à faire; quand il y a un problème, il suffit de lister les branche (avec git branch) de faire un checkout sur la branche précédente pour revenir au déploiement précédent.

En bonus, le script envoyait une requête sur NewRelic, pour ajouter un évènement de suivi. Sur les divers graphes s'ajoutait une barre à la date du déploiement. Lors de chutes de performances après un déploiement, cela permet de comprendre rapidement quelle peut en être l'origine.

Bref, un process très simple et qui a longtemps fait correctement son travail.

### La gestion de la base de donnée

Petit à petit, un ou deux outils annexes se sont greffés par dessus.
On a notamment "industrialisé" les mises à jour de base de donnée. Lorsqu'une table devait être créée, ou qu'il fallait ajouter une colonne, ou pour toute opération sur la base, on a mis en place un outil. Pour que tout le monde puisse en profiter de la même manière, et que l'on exécute en production le même script que sur les bases de développement, on écrivait les scripts dans un fichier d'un répertoire dédié.
Lors de la mise en production, un outil récupérait les nouveaux scripts, et les jouait.

COmme tout se fait de manière manuelle avec ce fonctionnement, il faut d'abord jouer le script de déploiement puis le script de mise à jour de base : il pouvait y avoir un léger downtime sur certaines page. Pour les pages publiques, c'était masqué par notre reverse proxy. Pour les outils de backoffice, il pouvait y avoir des problèmes pendant quelques instants. Entre l'exécution des deux scripts, le code utilisait des tables qui n'existait pas encore, ou qui avait été modifiées. Ca n'a jamais été un problème suffisament grave pour qu'une meilleure solution soit nécessaire.


### Validation

Niveau validation, ce fonctionnement marchait pour une petite équipe et sur des projets courts, mais dès que nous avons voulu avoir une gestion de projet plus rigoureuse nous nous sommes heurtés à des problèmes pratique : il n'y avait pas d'environnement dédié à la validation.

Les développeurs développent sur leur propre machine, dans une machine virtuelle qu'ils ont monté eux même, soit à partir des spécifications de la machine de prod, soit à partir d'un fichier ISO partagé par un des collègues.

Avant de déployer en production, on déploie en préproduction. On y vérifie que tout se passe bien, que la fonctionnalité marche comme prévue et qu'elle n'a rien cassée. C'est la grande époque de la validation manuelle.

Comme on déployait régulièrement des petites fonctionnalités, souvent développés individuellement et de manière autonome, cela ne posait pas trop de problèmes, mais dès qu'il était question de gros projets, d'agile, de développement à plusieurs, nous avons dû changer des choses.

### Conclusion

On a vu le fonctionnement du déploiement lors des premiers âges d'Evaneos. Des outils simples, pour une application qui l'était également. Dans le prochain article nous verrons les solutions que nous avons mises en place lorsque les besoins ont évolué.




