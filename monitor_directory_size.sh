#!/bin/sh

directory="$1"
if test -e "$directory"; then

  size=$(sh get_directory_size.sh "$directory")
  printf "\r                                 "
  printf "%s, $size"
  sleep 3
  sh monitor_directory_size.sh "$directory"
else

  echo "ERROR: Directory does not exits"
  exit 1
fi
