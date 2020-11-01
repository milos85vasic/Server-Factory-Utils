#!/bin/sh

for ITER in 1 .. 100
do
  bridge="bridge$ITER"
  if ! (ifconfig "$bridge" > /dev/null); then

    echo "$bridge"
    exit 0
  fi
done

echo "ERROR: Could not obtain bridge name"
exit 1