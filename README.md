# Evaneos.com technical blog

You're on the public github repo of the [Evaneos.com technical blog](http://evaneos.github.io)

Here are some [article ideas (fr)](https://github.com/Evaneos/Evaneos.github.io/blob/master/idees_articles.md).


## How to contribute

All the source blog is on github, and **you're welcome to contribute**. You can make it run on your computer with [docker](https://www.docker.com/) **in a minute** (six at least).

### Get the website on your local computer

```
cd ~
git clone git@github.com:Evaneos/Evaneos.github.io
docker pull grahamc/jekyll
cd Evaneos.github.io
git fetch -v
git checkout sources
docker run --rm -v "$PWD:/src" -p 4000:4000 grahamc/jekyll serve -H 0.0.0.0
```
You can then access the website on http://localhost:4000/

If you want to see the draft posts, add --drafts to the docker run command:

```
docker run --rm -v "$PWD:/src" -p 4000:4000 grahamc/jekyll serve --drafts
```

### If you DON'T HAVE the write access to Evaneos/Evaneos.github.io repo (non Evaneos.com staff)

**Create your content**

- fork the Evaneos/Evaneos.github.io git repository
- Create your post file in /_posts/ by naming it as the other ones (dd-mm-yyyy-title-with-dash-separator.md)
- Write your content inside (for format information, read below)

**Send us your content!**
- Commit and push your changes on the forked repository, on the **sources** branch.
- Create a pull request to the Evaneos/Evaneos.github.io **sources** branch

### If you DO HAVE the write access to Evaneos/Evaneos.github.io repo (ie for Evaneos.com staff)

**Create your content**

- Create your post file in /_drafts/ by naming it as the other ones (dd-mm-yyyy-title-with-dash-separator.md). If the folder does not exists, create it...
- Write your content inside (for format information, read below). Remeber to run docker with the --draft, so you'll see your content on the website.
- Commit and push your changes on the **sources** branch.. Work with others on the draft file.

**Publish your content**

- Once your draft is ok, move the file in /_posts/
- run ```compileToMaster.sh``` script that will output the compiled website source.
- commit and push to the **master** branch.

## Posts formatting

A post file has a header containing meta data, and the post content in markdown syntax. If you don't know markdown, ask Google or read [that page](http://daringfireball.net/projects/markdown/).

The header comes with that stuff:
```
---
layout: post
title: Configurer un blog Jekyll
category: Evaneos
author: clement
reviewer: tilap
comments: true
---
```

*Note: see the author section below to add author infos*

## Authors

To add/update an author, edit the /_config.yml file.
You can optionally add user twitter account.

For any question, feel free to contact us (yvan[at]evaneos[dot]com) and do not hesitate to open issue, we like to solve them :)
