#!/bin/bash

_to_80324() {
  local cur=${COMP_WORDS[COMP_CWORD]};
  COMPREPLY=($(compgen -W "$names" -- $cur));
}

names="--add --remove --list --help --version --retag ";
names+="";
complete -F _to_80324 to;
