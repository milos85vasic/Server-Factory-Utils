#!/bin/sh

if ! test -e /usr/local/bin/ip; then

  echo "'ip' command not found on the system"
  if uname | grep -i "darwin" > /dev/null; then

    echo "'ip' command will be installed"
    if curl --remote-name -L https://github.com/brona/iproute2mac/raw/master/src/ip.py && \
      chmod +x ip.py && \
      mv ip.py /usr/local/bin/ip; then

        echo "'ip' command installed"
    else

      echo "'ip' command installation failed"
      exit 1
    fi
  else

    echo "ERROR: 'ip' command is required to continue, please install it for your system"
    exit 1
  fi
fi

bindBridgeTo="en0"
bridgeName=$(sh create_and_get_bridge.sh)

if ! (ifconfig "$bridgeName"); then

  echo "$bridgeName: Network bridge is not yet available"
  echo "$bridgeName: Creating network bridge"
  if sudo ifconfig "$bridgeName" create && \
    echo "Step: Bridge created" && \
    sudo ifconfig "$bridgeName" addm "$bindBridgeTo" && \
    echo "Step: Bridge bound to: $bindBridgeTo" && \
    sudo ifconfig bridge0 up && \
    echo "Step: Bridge is up"; then

      echo "$bridgeName: Network bridge created"
  else

    echo "ERROR: $bridgeName: Network bridge was not created"
    exit 1
  fi
else

  echo "$bridgeName: Network bridge is available"
fi