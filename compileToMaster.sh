#!/bin/sh

# Script manuel, en attendant la version avec drone.io

if [[ -n `git status --porcelain | tr -d '\n'` ]]; then
	echo "You need to commit before compiling to master"
	exit 1	
fi

git checkout sources
jekyll build || exit 1
git checkout master
git ls-files | xargs rm
find . -depth -type d -empty -exec rmdir {} \;
mv _site/* .
rmdir _site
touch .nojekyll

git add -A
git commit -m "auto commit"
git push origin master
git checkout sources
