#!/bin/sh

bridgeName="server_factory_network_bridge"

if ! (ifconfig server_factory_network_bridge); then

  echo "$bridgeName: Network bridge is not yet available"
  echo "$bridgeName: Creating network bridge"
else

  echo "$bridgeName: Network bridge is available"
fi