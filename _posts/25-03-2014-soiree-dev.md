---
layout: post
title: Les soirées Dev
category: Evaneos
comments: true
author: clement
---

Pour démarrer ce blog technique, quoi de mieux qu'un article qui ne parle pas de technique ? Je vais plutôt commencer par vous parler d'un des éléments de notre **culture d'entreprise**.

La particularité de notre équipe chez Evaneos.com, est d'être constituée de *passionnés*. Des passionnés par l'univers du web, et de tout ce qui gravite autour : qu'il s'agisse d'une librairie javascript intéressante, d'une nouveauté dans un language backend, des nouvelles idées en matière d'ergonomie grâce à la montée de web mobile, d'un point de détail de génie logiciel qui commence à trouver sa place dans le web... la liste pourrait continuer longtemps, mais tous les aspects de la technique et de ce que cela permet de réaliser sont, pour nous, très motivants.

Ainsi, nous faisons tous, chacun de notre côté, pas mal de veille pour nous tenir à jour (ou tenter de l'être), mais il n'est pas toujours facile de l'être. Le web étant en continuelle évolution, il est difficile de jouer avec tout ce que l'on souhaiterait. Notre temps étant limité, ce n'est pas non plus forcément souhaitable, alors on a cherché un compromis.

Une solution que nous avons trouvé, c'est d'organiser des **soirées dev**. L'idée ? Rester tard un soir, commander des pizzas, et passer la soirée à bricoler un bout de code qu'on a envie de faire depuis un moment, mais qui, pour diverses raisons, n'a jamais pris réalité. Seul ou en groupe, en rapport avec ce qu'on fait au travail ou non, sur un langage, une librairie, un applicatif... l'important c'est de s'amuser.

Voici un petit éventail de ce qui a été bricolé lors de la dernière soirée dev :

 - Mise en place d'un serveur local [Open Street maps](http://openstreetmap.fr/)
 - Découverte d'[Elasticsearch](www.elasticsearch.org) autour de la conception d'une petite appli de recherche de films
 - Bricolage autour de [logstash](http://logstash.net/) pour avoir un moteur de recherche dans nos logs basé sur Elasticsearch et Kibana. Pour ceux que ça intéresse, voici un [point de départ possible](http://linuxfr.org/news/gestion-des-logs-avec-logstash-elasticsearch-kibana)
 - Découverte de [SailsJS](http://sailsjs.org/) via le bricolage d'une petit appli. SailsJS est un framework javascript MVC basé sur du nodeJS.
 - Essai de mise en corrélation de titres d'articles de journeaux, pour essayer de déterminer qui reprend ses informations chez les autres.

Comme vous pouvez le voir, les mots qui reviennent sont "essai", "bricolage", "découverte"... On ne cherche pas à concevoir des applications finies, ce qui est plutôt difficile quand on ne connait pas une technologie. On cherche plutôt à découvrir la technologie en question, s'ouvrir l'esprit à de nouveaux outils, et expérimenter. Tout ne marche pas comme prévu, par exemple nous avons eu de nombreux problèmes de compatibilité avec le serveur OpenStreetMaps, j'ai pu voir que mettre en place et requêter Elasticsearch est loin d'être trivial en une soirée... En fait, cette phase de découverte permet de prendre conscience des possibilités et des limitations de nouveaux outils, que ce soit pour s'en servir, ou au contraire pour les rayer de la liste des possibles.

Ha, et se réunir pour faire les geeks ajoute un côté ludique **très** motivant.

Si vous n'organisez pas déjà des activités de ce genre avec votre équipe, pensez-y !