---
layout: post
title: Premiers pas dans les tests en javascript
category: Evaneos
author: christophe
comments: true
---

## Contexte

Les tests sont importants pour s'assurer que l'application est toujours en état de fonctionner. C'est aussi rassurant pour le développeur avant de faire sa mise en prod de vérifier que les fonctionnalités marchent encore. L'objectif de ce billet et d'avoir un apercu de quelques outils permettant de tester du javascript coté navigateur, jusqu'au tests sur IE dans une machine virtuelle.


## Le fichier de test

Il existe de nombreuses libraries pour faire des tests unitaires en javascript, à commencer par la [librarie native de nodejs](http://nodejs.org/api/assert.html). Mon choix s'est d'abord porté sur [Chai](http://chaijs.com/), style TDD assert, avant de me rendre compte qu'il n'était pas compatible avec les anciennes versions d'IE et j'ai donc exploré [Proclaim](https://github.com/rowanmanning/proclaim).

Installation :

```
npm install --save-dev proclaim
```

Voici donc ci-dessous un test tout simple :

`tests/test.js`

```js
var assert = proclaim;

test('basic DOM test', function() {
    var el = document.createElement("div");
    el.id = "myDiv";
    el.innerHTML = "Hello World!";
    document.body.appendChild(el);
    var myEl = document.getElementById('myDiv');
    assert.equal(myEl.innerHTML, "Hello World!");
    document.body.removeChild(el);
    el = null;
    myEl = null;
});
```

### Mocha

Ensuite, nous avons besoin d'une librairie qui encapsule ces tests et les lancent. [Mocha](http://visionmedia.github.io/mocha/) est l'une des plus connues.

Installation :

```
npm install --save-dev mocha
```

On peut lancer nos tests avec un fichier html:

`tests.html`

```html
<html>
<head>
    <meta charset="utf-8">
    <title>Mocha Tests</title>
    <link rel="stylesheet" href="node_modules/mocha/mocha.css" />
</head>
<body>
    <div id="mocha"></div>
    <script src="node_modules/mocha/mocha.js"></script>
    <script src="node_modules/proclaim/lib/proclaim.js"></script>
    <script>
        window.assert = proclaim;
        mocha.setup({ ui: 'tdd' });
    </script>
    <script src="tests/test.js"></script>
    <script>
        mocha.checkLeaks();
        mocha.run();
    </script>
</body>
</html>
```


### Karma

Karma permet de lancer les tests simultanément dans plusieurs navigateurs. Il faut installer les plugins correspondant aux navigateurs, créer un fichier de configuration, et on a le résultat dans la console.

Installation :

```
sudo npm install -g karma-cli && npm install --save-dev karma karma-mocha karma-proclaim karma-chrome-launcher karma-firefox-launcher
```

`karam.conf.js`

```js
module.exports = function(config) {
    config.set({

        // base path, that will be used to resolve files and exclude
        basePath: '',

        frameworks: ['mocha', 'proclaim'],

        browsers: [
            'Firefox',
            'Chrome',
        ],

        files: [
            'mocha.conf.js',
            'tests/test.js',
        ],

        // test results reporter to use
        // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
        reporters: ['progress'],


        // enable / disable colors in the output (reporters and logs)
        colors: true,


        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel: config.LOG_INFO,


        // enable / disable watching file and executing tests whenever any file changes
        autoWatch: true,
    });
};
```


`mocha.conf.js`

```js
window.mocha.setup({ui: 'tdd'});
window.mocha.checkLeaks();
```

Puis lancer avec `karma start`.


## Karma et IE

Il est possible de lancer ces tests sur IE via une machine virtuelle. Pour ca, il faut d'abord installer [ievms](https://github.com/xdissent/ievms) qui se charge de créer des marchines virtuelles dans VirtualBox.

De retour sur le projet, il faut installer un nouveau plugin:

```
npm install --save-dev karma-ievms
```

Puis rajouter dans la configuration de karma:

```
//...
    
        browsers: [
            'Firefox',
            'Chrome',
            'IE6 - WinXP',
            'IE7 - WinXP',
            'IE8 - WinXP',
            'IE9 - Win7',
            'IE10 - Win7',
            'IE11 - Win7'
        ]
```

A noter: Karma utiliser socket.io, et sur les anciens navigateurs il vaut mieux avoir flash installé.

## Testling

Pour terminer, on peut utiliser [Testling](https://ci.testling.com/) pour mettre en place ces tests à chaque push dans github et avoir un badge indiquant les navigateurs testés.

Il suffit de [configurer le web hook](https://ci.testling.com/guide/quick_start#configuring-the-web-hook) puis de modifier le fichier `package.json` :

```json

  "testling": {
    "html": "tests.html",
    "files": "test/*.js",
    "browsers": [
      "ie/6..latest",
      "chrome/latest",
      "chrome/canary",
      "firefox/3..3.6",
      "firefox/latest",
      "firefox/nightly",
      "safari/latest",
      "opera/11.0..latest",
      "iphone/6",
      "ipad/6",
      "android-browser/latest"
    ]
  }
```
