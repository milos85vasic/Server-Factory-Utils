#!/bin/sh

address=$1
error="Could not obtain ip address for: $address"
if nslookup "${address}" | grep "can't find" >/dev/null 2>&1; then

  ping_result=$(ping -c 3 "$address")
  if echo "$ping_result" | grep "100.0% packet loss" >/dev/null 2>&1; then

    echo "$error"
    exit 1
  else

    if echo "$ping_result" | grep "cannot resolve" >/dev/null 2>&1; then

      echo "$error"
      exit 1
    else

      data_bytes="data bytes"
      line=$(echo "$ping_result" | grep "$data_bytes")
      line=$(echo "$line" | sed -e "s/PING $address \(.*\)$data_bytes/\1/" | tr -d '()' | cut -f1 -d":")
      line=$(echo "$line" | tr -d "[:blank:]")
      if [ "$line" != "" ]; then

        echo "$line"
      fi
    fi
  fi
else

  addr="Address:"
  lookup_data=$(nslookup "${address}" | sed '/^[[:space:]]*$/d' | grep "$addr")
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
