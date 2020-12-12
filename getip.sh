#!/bin/sh

if uname | grep -i "darwin" >/dev/null 2>&1; then

  ping -c1 "$1" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'
else

  ping -c1 -4 "$1" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'
fi
