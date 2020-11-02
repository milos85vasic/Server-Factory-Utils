#!/bin/bash

echo "Executing /etc/qemu-ifup"
echo "Creating bridge"
sysctl -w net.link.ether.inet.proxyall=1
sysctl -w net.inet.ip.forwarding=1
sysctl -w net.inet.ip.fw.enable=1
ifconfig bridge0 create
echo "Bringing up $1 for bridged mode"
ifconfig $1 0.0.0.0 up
echo "Add $1 to bridge"
ifconfig bridge0 addm en0 addm $1
echo "Bring up bridge"
ifconfig bridge0 up