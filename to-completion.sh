#!/bin/bash

_to() {
  local cur=${COMP_WORDS[COMP_CWORD]};
  COMPREPLY=($(compgen -W "$names" -- $cur));
}

names="--add --rm --list --help --version ";
names+="";
complete -F _to to;
