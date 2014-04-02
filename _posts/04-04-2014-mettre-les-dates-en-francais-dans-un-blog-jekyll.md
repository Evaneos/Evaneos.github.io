---
layout: post
title: Mettre les dates en francais dans un blog Jekyll
category: Evaneos
author: christophe
comments: true
---
Comme précédemment vu, ce [blog tourne sur Jekyll](/configurer-un-blog-jekyll-2014-04-04/).

## Jekyll et internationalisation

L'internationalisation (ou i18n) n'est pas supportée nativement par Jekyll. Il existe [un plugin](https://github.com/gacha/gacha.id.lv/blob/master/_plugins/i18n_filter.rb) qui permet de le faire en plusieurs langues mais en utilisant un filtre différent. La [solution la plus simple](https://gist.github.com/remiprev/2665712) est de modifier la fonction strftime:

    _plugins/frdate.rb
```ruby
# encoding: utf-8
require 'date'
require 'time'
Date::MONTHNAMES = [nil] + %w(janvier février mars avril mai juin juillet août septembre octobre novembre décembre)
Date::DAYNAMES = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"]
 
class Time
    alias :strftime_nolocale :strftime
 
    def strftime(format)
        format = format.dup
        format.gsub!(/%a/, Date::ABBR_DAYNAMES[self.wday])
        format.gsub!(/%A/, Date::DAYNAMES[self.wday])
        format.gsub!(/%b/, Date::ABBR_MONTHNAMES[self.mon])
        format.gsub!(/%B/, Date::MONTHNAMES[self.mon])
        self.strftime_nolocale(format)
    end
end
```


## Hébergé par GitHub ?

Attention, Github compile par défaut avec l’option ```--safe``` de Jekyll qui ignore tous les plugins. La solution est de créer un script qui génère le site statique et envoie ce site sur le dépôt GitHub, comme expliqué [sur ce blog](http://arademaker.github.io/blog/2011/12/01/github-pages-jekyll-plugins.html). Il est même possible de gérer ce déploiement via l'intégration continue, par exemple [drone.io](http://drone.io).
