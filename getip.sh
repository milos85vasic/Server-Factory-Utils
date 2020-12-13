#!/bin/sh

if uname | grep -i "darwin" >/dev/null 2>&1; then

  ping -c 1 "$1" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'
else

  ping -c 1 -4 "$1" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'
fi
