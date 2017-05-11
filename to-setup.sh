#!/bin/bash

#Author: Leandro Silva (http://grafluxe.com)
#Copywrite: 2017 Leandro Silva
#License: MIT

fi_main="$(dirname $0)/to.sh";
fi_completion_name="to-completion.sh";
fi_completion="$(dirname $0)/$fi_completion_name";
fi_bash=~/.bash_completion.d/$fi_completion_name;
fi_routes=~/.to-routes;
fi_profile=~/.profile;
has_src=$(cat $fi_profile | grep "$fi_main" | wc -l);

if [ $has_src = "0" ]; then
  touch $fi_profile;
  touch $fi_routes;
  mkdir -p $(dirname $fi_bash);
  cp $fi_completion $fi_bash;

  echo "if [ -f \"$fi_main\" ]; then \n  source \"$fi_main\"; \n  source \"$fi_bash\";\nfi;\n" >> $fi_profile;
  echo "Installed Successfully";
  echo "-";
  echo "To begin, refresh your profile (run 'source .profile'), the run the 'to --help' command.";
else
  echo "Already Installed";
  echo "For help, run the 'to --help' command.";
fi;
