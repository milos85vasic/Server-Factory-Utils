#!/bin/sh

if uname | grep -i "darwin" > /dev/null; then

  echo "cocoa"
else

  if uname | grep -i "linux" > /dev/null; then

    echo "gtk"
  else

    echo "sdl"
  fi
fi

