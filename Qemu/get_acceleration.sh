#!/bin/sh

if uname | grep -i "darwin" > /dev/null; then

  echo "hvf"
else

  if uname | grep -i "linux" > /dev/null; then

    echo "kvm"
  else

    echo "tcg"
  fi
fi

