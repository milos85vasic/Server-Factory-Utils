#!/bin/sh

bridgeName=$1
bindBridgeTo="en0"

if ! ifconfig "$bridgeName" 2> /dev/null; then

  echo "$bridgeName: Network bridge is not yet available"
  echo "$bridgeName: Creating network bridge"
  if sudo ifconfig "$bridgeName" create && \
    echo "Step: Bridge created" && \
    sudo ifconfig "$bridgeName" addm "$bindBridgeTo" && \
    echo "Step: Bridge bound to: $bindBridgeTo" && \
    sudo ifconfig "$bridgeName" up && \
    echo "Step: Bridge is up"; then

      echo "$bridgeName: Network bridge created"
  else

    echo "ERROR: $bridgeName: Network bridge was not created"
    exit 1
  fi
else

  echo "$bridgeName: Network bridge is available"
fi