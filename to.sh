#!/bin/bash

#Author: Leandro Silva (http://grafluxe.com)
#Copywrite: 2017 Leandro Silva
#License: MIT

_routes_80324=~/.to-routes;
_version_80324="0.1.0";

to() {
  if [ $1 = "--add" ]; then
    _add_80324 $2;
  elif [ $1 = "--rm" ]; then
    _remove_80324 $2;
  elif [ $1 = "--list" ]; then
    _list_80324 $2;
  elif [ $1 = "--help" ]; then
    _help_80324;
  elif [ $1 = "--version" ]; then
    echo "to.sh v$_version_80324";
  else
    _goto_80324 $1;
  fi;
}

_get_route_80324() {
  if [ -f $_routes_80324 ]; then
    echo $(grep "$(pwd)\$" $_routes_80324 | tail -1);
  else
    echo "";
  fi;
}

_show_verbose_80324() {
  if [ "$1" = "-v" ]; then
    return 0;
  else
    return 1;
  fi;
}

_update_completion_list_80324() {
  completion_path=~/.bash_completion.d/to-completion.sh;
  completion_list="";

  while read route; do
    completion_list+=$(echo " $route" | awk -F ' ->' '{print $1}');
  done <~/.to-routes;

  updated_fi=$(sed '$d' $completion_path | sed '$d');
  updated_fi+=$(echo -e "\nnames+=\"$completion_list\"; \ncomplete -F _to to;");

  echo "$updated_fi" > $completion_path;
  source $completion_path;
}

_add_80324() {
  route=$(_get_route_80324);

  if [ -z "$route" ]; then
    name=$(basename $(pwd));
    path=$(pwd);

    echo "$name -> $path" >> $_routes_80324;
    _update_completion_list_80324;
    echo "Route Added";

    if _show_verbose_80324 $1; then
      echo "-";
      echo "Command: to $name";
      echo "Path   : $path";
    fi;
  else
    echo "Route Already Exists";

  if _show_verbose_80324 $1; then
      route_data=(${route// -> / });
      name=${route_data[0]};
      path=${route_data[1]};

      echo "-";
      echo "Command: to $name";
      echo "Path   : $path";
      echo "Note   : If you had a previous route with the same name, this routes mapping will take its place.";
    fi;
  fi;
}

_remove_80324() {
  route=$(_get_route_80324);

  if [ ! -z "$route" ]; then
    echo "$(grep -v "$(pwd)\$" $_routes_80324)" > $_routes_80324;
    _update_completion_list_80324;
    echo "Route Removed";

    if _show_verbose_80324 $1; then
      echo "-";
      echo "route: $route";
    fi
  else
    if _show_verbose_80324 $1; then
      echo "No Mapped Route";
      echo "-";
      echo "Note: There is no mapped route to remove.";
    fi
  fi;
}

_list_80324() {
  if _show_verbose_80324 $1; then
    echo "File: $_routes_80324";
    echo "-";
  fi

  cat $_routes_80324;
}

_goto_80324() {
  if [ $(echo $1 | cut -c 1-2) = "--" ]; then
    echo "No Such Option Exists";
    echo "Help: to --help";
  else
    route=$(grep "$1 -> " $_routes_80324 | tail -1);

    if [ -z "$route" ]; then
      echo "No Such Route Exists";
      echo "Help: to --help";
    else
      cd "$(echo "$route" | awk -F ' -> ' '{print $2}')";
    fi;
  fi;
}

_help_80324() {
  echo -e "\n\
    to.sh \n\
    ===== \n\
    \n\
    DESCRIPTION \n\
      Change to your favorite and most visited directories quickly and easily. This project was \n\
      created to help expedite moving between directories (via any bash enabled CLI). \n\
    \n\
    USAGE \n\
      to [<route-name> | <options>] \n\
        'cd' into a directory that you want add to the route list and run the 'to --add' command. \n\
        Once added, run 'to <name>' to 'cd' into that directory from wherever you are. The 'name' \n\
        param matches the directory name you added to the route list. To see all availabe routes, \n\
        run the 'to --list' command. \n\
    \n\
        Sample: cd my/path/myapp; to --add; cd ~; to myapp \n\
    \n\
    OPTIONS \n\
      --add [<-v>] \n\
        Adds your current working directory to the route list (with a name matching your directory \n\
        name). Use the optional '-v' parameter for a more verbose message. \n\
    \n\
      --rm [<-v>] \n\
        Removes your current working directory from the route list (if it exists). Use the \n\
        optional '-v' parameter for a more verbose message. \n\
    \n\
      --list [<-v>] \n\
        Lists your available routes. Use the optional '-v' parameter for a more verbose message. \n\
    \n\
      --help \n\
        Opens the help page. \n\
    \n\
      --version \n\
        Outputs the version you're currently using. \n\
    \n\
    INFO \n\
      Project home \n\
        http://github.com/Grafluxe/to.sh \n\
        Additional docs can be in the README. \n\
    \n\
      Author \n\
        Leandro Silva \n\
    \n\
      Copywrite \n\
        (c) 2017 Leandro Silva (http://grafluxe.com) \n\
    \n\
      License \n\
        MIT \n\
    \n\
  ";
}
