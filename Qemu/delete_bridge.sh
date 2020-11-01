#!/bin/sh

script_path="/usr/local/bin"
script_path_full="$script_path/server_factory_bridge_name.sh"

if test -e "$script_path_full"; then

  bridge=$(sh $script_path_full)
  if sudo ifconfig "$bridge" destroy && sudo rm -f "$script_path_full"; then

    echo "'$bridge': Network bridge deleted"
  else

    echo "ERROR: '$bridge' Network bridge was not deleted"
    exit 1
  fi
else

  echo "No network bridge to delete"
fi