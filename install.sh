#!/bin/bash

#Author: Leandro Silva (http://grafluxe.com)
#Copyright: 2021 Leandro Silva
#License: MIT

version="1.2.0"

curl -Lko to-sh.zip https://github.com/Grafluxe/to.sh/archive/v$version.zip
unzip to-sh.zip
sh to.sh-$version/to-setup.sh
source ~/.profile
source ~/.zshrc
echo Cleaning up...
rm -fr to.sh-$version
rm to-sh.zip
echo Done!
