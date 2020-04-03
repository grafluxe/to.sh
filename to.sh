#!/bin/bash

#Author: Leandro Silva (http://grafluxe.com)
#Copyright: 2017 Leandro Silva
#License: MIT

source ~/.to/to-completion.sh;

_version_80324="1.1.0";

_dir_install_80324=~/.to;
_fi_completion_80324=$_dir_install_80324/to-completion.sh;
_fi_routes_80324=$_dir_install_80324/to-routes.txt;
_fi_help_80324=$_dir_install_80324/to-help.txt;

to() {
  if [ -z "$1" ]; then
    msg="to.sh\n";
    msg+="-\n";
    msg+="Usage: to [<tag> | <options>]\n";
    msg+="Help : to --help";

    echo -e "$msg";
  else
    case "$1" in
      "--add") _add_80324 $2;;
      "--remove") _remove_80324 $2;;
      "--list") _list_80324 $2;;
      "--help") echo "" && cat $_fi_help_80324 && echo "";;
      "--version") echo "to.sh v$_version_80324";;
      "--retag") _retag_80324 $2;;
      *) _goto_80324 $1;;
    esac;
  fi;
}

_get_route_80324() {
  if [ -f "$_fi_routes_80324" ]; then
    echo $(grep "$(pwd)\$" $_fi_routes_80324 | tail -1);
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
  completion_list="";

  while read route; do
    completion_list+=\ $(echo "$route" | awk -F ' -> ' '{print $1}');
  done < $_fi_routes_80324;

  fi_updated=$(sed "s/\(names\+=\).*;/\1\"$completion_list\";/" $_fi_completion_80324);

  echo "$fi_updated" > $_fi_completion_80324;
  source $_fi_completion_80324;
}

_add_80324() {
  route=$(_get_route_80324);

  if [ -z "$route" ]; then
    tag=$(echo $(basename $(pwd)) | sed "s/ /_/g");
    has_tag=$(grep "^$tag ->" $_fi_routes_80324);

    if [ ! -z "$has_tag" ]; then
      path=$(echo $has_tag | awk -F ' -> ' '{print $2}');

      msg="Tag Already Exists\n";
      msg+="-\n";

      if _show_verbose_80324 $1; then
        msg+="Command: to $tag\n";
        msg+="Path   : $path\n";
        msg+="Tag    : $tag\n";
        msg+="Note   : You must delete the previous route before proceeding.\n";
        msg+="Help   : to --help";
      else
        msg+="Path: $path\n";
        msg+="Note: You must delete the previous route before proceeding.";
      fi;
    else
      path=$(pwd);

      echo "$tag -> $path" >> $_fi_routes_80324;
      _update_completion_list_80324;

      msg="Route Added\n";
      msg+="-\n";

      if _show_verbose_80324 $1; then
        msg+="Command: to $tag\n";
        msg+="Path   : $path\n";
        msg+="Tag    : $tag";
      else
        msg+="Tag: $tag";
      fi;
    fi;
  else
    msg="Route Already Exists";

    if _show_verbose_80324 $1; then
      route_data=(${route/ -> / });
      tag=${route_data[0]};
      path=${route_data[1]};

      msg+="\n-\n";
      msg+="Command: to $tag\n";
      msg+="Path   : $path\n";
      msg+="Tag    : $tag";
    fi;
  fi;

  echo -e "$msg";
}

_remove_80324() {
  route=$(_get_route_80324);

  if [ ! -z "$route" ]; then
    echo "$(grep -v "$(pwd)\$" $_fi_routes_80324)" > $_fi_routes_80324;
    _update_completion_list_80324;

    msg="Route Removed";

    if _show_verbose_80324 $1; then
      msg+="\n-\n";
      msg+="route: $route";
    fi

    echo -e "$msg";
  else
    if _show_verbose_80324 $1; then
      msg="No Mapped Route\n";
      msg+="-\n";
      msg+="Note: There is no mapped route to remove.";

      echo -e "$msg";
    fi
  fi;
}

_list_80324() {
  if _show_verbose_80324 $1; then
    msg="File: $_fi_routes_80324\n";
    msg+="-";

    echo -e "$msg";
  fi

  cat $_fi_routes_80324 | sed "s/->/\`-> /" | column -t -s "\`";
}

_goto_80324() {
  if [ $(echo $1 | cut -c 1-2) = "--" ]; then
    msg="No Such Option Exists\n";
    msg+="Help: to --help";

    echo -e "$msg";
  else
    route=$(grep "$1 -> " $_fi_routes_80324 | tail -1);

    if [ -z "$route" ]; then
      msg="No Such Route Exists\n";
      msg+="Help: to --help";

      echo -e "$msg";
    else
      to_dir="$(echo "$route" | awk -F ' -> ' '{print $2}')";

      if [ -d "$to_dir" ]; then
        cd "$to_dir";
      else
        echo "$(grep -v "$route\$" $_fi_routes_80324)" > $_fi_routes_80324;

        msg="No Such Directory Exists\n";
        msg+="-\n";
        msg+="Note: The directory associated with this tag no longer exists. This route has been removed.\n";
        msg+="Path: $route";

        echo -e "$msg";
        _update_completion_list_80324
      fi;
    fi;
  fi;
}

_retag_80324() {
  route=$(_get_route_80324);

  if [ -z "$route" ]; then
    msg="No Such Route Exists";
  else
    if [ -z "$1" ]; then
      msg="Usage: to --retag <tag>";
    else
      path=$(pwd);
      tag=$@;
      valid_tag_name=$(echo $tag | grep " ");

      if [ -z "$valid_tag_name" ]; then
        echo -e "$(grep -v "$path\$" $_fi_routes_80324)\n$tag -> $path" > $_fi_routes_80324;

        msg="Tag Updated\n";
        msg+="-\n";
        msg+="From: $(echo $route | awk -F ' -> ' '{print $1}')\n";
        msg+="To  : $tag";

        _update_completion_list_80324;
      else
        msg="Bad Tag Name\n";
        msg+="-\n";
        msg+="Note: Your tag cannot contain spaces.\n";
        msg+="Help: to --help";
      fi;
    fi;
  fi;

  echo -e "$msg";
}
