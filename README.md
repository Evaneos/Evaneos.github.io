# Blog technique Evaneos.com

Ceci est le dépot github du blog technique Evaneos.com

Si nécessaire, voici la référence sur [la syntaxe markdown](http://daringfireball.net/projects/markdown/).

Voici des [idées de futurs articles](https://github.com/Evaneos/Evaneos.github.io/blob/master/idees_articles.md).


# Environnement pour tester les articles :

    git clone git@github.com:Evaneos/Evaneos.github.io
    docker pull grahamc/jekyll
    cd Evaneos.github.io
    git fetch -v 
    git checkout sources 
    docker run --rm -v "$PWD:/src" -p 4123:4000 grahamc/jekyll serve -H 0.0.0.0

# Publier des articles

 - Créer l'article à partir d'une branche fille de source
 - Merger dans sources la branche de développement
 - Jouer le script compileToMaster.sh
 - Done !

