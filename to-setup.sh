#!/bin/bash

#Author: Leandro Silva (http://grafluxe.com)
#Copyright: 2017 Leandro Silva
#License: MIT

dir_here=$(dirname $0);
dir_install=~/.to;

fi_profile_bash=~/.profile;
fi_profile_zsh=~/.zshrc;

fi_main_here=$dir_here/to.sh;
fi_completion_here=$dir_here/to-completion.sh;
fi_help_here=$dir_here/to-help.txt;
fi_license_here=$dir_here/LICENSE.md;

fi_main=$dir_install/to.sh;
fi_completion=$dir_install/to-completion.sh;
fi_help=$dir_install/to-help.txt;
fi_license=$dir_install/LICENSE.md;
fi_routes=$dir_install/to-routes.txt;

function has_src {
  cat $1 | grep "to.sh" | wc -l;
}

# bash
if [[ -f $fi_profile_bash ]]; then
  has_src_bash=$(has_src $fi_profile_bash);
else
  has_src_bash="0";
fi

if [ $has_src_bash = "0" ]; then
  echo "\nif [ -f ~/.to/to.sh ]; then\n  source ~/.to/to.sh;\nfi\n" >> $fi_profile_bash;
fi;

# zsh
if [[ -f $fi_profile_zsh ]]; then
  has_src_zsh=$(has_src $fi_profile_zsh);
else
  has_src_zsh="0";
fi

if [ $has_src_zsh = "0" ]; then
  load="\nif [ -f ~/.to/to.sh ]; then\n";
  load+=" autoload compinit && compinit;\n";
  load+=" autoload bashcompinit && bashcompinit;\n";
  load+=" emulate sh -c 'source ~/.to/to.sh';\n";
  load+="fi\n";

  echo $load >> $fi_profile_zsh;
fi;

if [ ! -d "$dir_install" ]; then
  mkdir -p $dir_install;

  cp $fi_main_here $fi_main;
  cp $fi_completion_here $fi_completion;
  cp $fi_help_here $fi_help;
  cp $fi_license_here $fi_license;

  touch $fi_routes;

  msg="Installed Successfully\n";
  msg+="-\n";
  msg+="To begin, open a new shell tab/window, then run the 'to --help' command.";
else
  msg+="Already Installed\n";
  msg+="-\n";
  msg+="For help, run the 'to --help' command.";
fi;

echo "$msg";
