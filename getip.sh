#!/bin/sh

ping -c1 -4 "$1" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'
