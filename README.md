# Blog technique Evaneos.com

Ceci est le dépot github du [blog technique Evaneos.com](http://evaneos.github.io/). Principalement utilisé par les développeurs d'[Evaneos.com](http://www.evaneos.com), vous pouvez y contribuer librement si le souhaitez.

Voici des [idées de futurs articles](https://github.com/Evaneos/Evaneos.github.io/blob/master/idees_articles.md) proposées par les développeur d'Evaneos.


## Comment l'installer

### Prérequis

- git
- docker

### Installation

**One-line-install (curl requis)**
```
curl -sS https://raw.githubusercontent.com/Evaneos/Evaneos.github.io/sources/installer.sh | sh
```

**A la main**

Ni plus ni moins que via les commandes du fichier [Installer.hs](https://raw.githubusercontent.com/Evaneos/Evaneos.github.io/sources/installer.sh) :

    git clone git@github.com:Evaneos/Evaneos.github.io
    docker pull grahamc/jekyll
    cd Evaneos.github.io
    git fetch -v 
    git checkout sources 

## Utilisation en local

Dans le répertoire de votre blog

    docker run --rm -v "$PWD:/src" -p 4123:4000 grahamc/jekyll serve -H 0.0.0.0

Le blog sera alors disponible sur http://localhost:4123/
