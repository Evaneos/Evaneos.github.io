#!bin/bash
echo
echo "########################################"
echo "Evaneos blog install"
echo "########################################"
echo
echo "### Cloning repository"
echo
git clone git@github.com:Evaneos/Evaneos.github.io
echo
echo "### Installing docker image"
echo
docker pull grahamc/jekyll
echo
echo "### Grabbing source code"
echo
cd Evaneos.github.io
git fetch -v
git checkout sources
echo
echo "Installation finished!"
echo
echo "run the blog locally on http://localhost:4123 with"
echo "docker run --rm -v "$PWD:/src" -p 4123:4000 grahamc/jekyll serve -H 0.0.0.0"

