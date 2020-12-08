#!/bin/sh

machine=$1
echo "$machine: Checking reachability"
if ping -c 3 "$machine" >/dev/null 2>&1; then

  echo "$machine: Reachable"
else

  echo "ERROR: $machine is unreachable"
  exit 1
fi