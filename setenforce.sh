#!/bin/sh

if ! (getenforce | grep -i "disabled");
then

  if setenforce 0; then

    echo "SELinux enforce set to 0"
  else

    echo "SELinux enforce set to 0 failed"
    exit 1
  fi
fi