#!/bin/sh

if uname | grep -i "darwin" > /dev/null; then

  echo "hvf"
else

  echo "tcg"
fi

