#!/bin/sh

if ifconfig server_factory_network_bridge | grep -i "does not exist"; then

  echo "Creating network bridge: server_factory_network_bridge"
else

  echo "Network bridge is available: server_factory_network_bridge"
fi