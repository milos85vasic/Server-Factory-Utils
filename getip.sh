#!/bin/sh

ping -c1 "$1" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'
