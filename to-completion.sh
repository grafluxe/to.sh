#!/bin/bash

#Author: Leandro Silva (http://grafluxe.com)
#Copywrite: 2017 Leandro Silva
#License: MIT

_to() {
  local cur=${COMP_WORDS[COMP_CWORD]};
  COMPREPLY=($(compgen -W "$names" -- $cur));
}

names="--add --rm --list --help --version ";
names+="";
complete -F _to to;
