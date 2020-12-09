#!/bin/sh

address=$1
error="Could not obtain ip address for: $address"
if ! which nslookup >/dev/null 2>&1 ||
  nslookup "$address" | grep "can't find" >/dev/null 2>&1; then

  ping -c1 "$address" | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'
else

  addr="Address:"
  lookup_data=$(nslookup "$address" | sed '/^[[:space:]]*$/d' | grep "$addr")
  addresses=$(echo "$lookup_data" | tr -d "[:blank:]")
  addresses=$(echo "$addresses" | sed -e "s/^$addr//" | tr '\r\n' ';')
  export IFS=";"
  for candidate in $addresses; do

    if expr "$candidate" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null 2>&1; then

      echo "$candidate"
      exit 0
    fi
  done

  echo "$error"
  exit 1
fi
