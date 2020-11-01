#!/bin/sh

iso=$2
machine=$1
display=$(sh get_display.sh)
acceleration=$(sh get_acceleration.sh)
disk=$(sh create_disk.sh "$machine" 20)
#tapName=$(sh create_and_get_tap.sh)
#bridgeName=$(sh create_and_get_bridge.sh)

if ! test -e /etc/qemu-ifup && uname | grep -i "darwin" > /dev/null; then

  echo "qemu-ifup: Scrip version for macOS is missing, it will be installed"
  if sudo cp macOS/qemu-ifup.sh /etc && sudo mv /etc/qemu-ifup.sh /etc/qemu-ifup; then

    echo "qemu-ifup: Scrip version for macOS is installed"
  else

    echo "qemu-ifup: Scrip version for macOS was not installed"
    exit 1
  fi
fi

sh create_network.sh && \
#  ip link set "$tapName" master "$bridgeName"
  sudo qemu-system-x86_64 -accel "$acceleration" -cpu host -m 2048 -smp 2 \
    -display "$display",show-cursor=on -usb -device usb-tablet -vga virtio \
    -drive file="$disk,format=qcow2,if=virtio" \
    -netdev tap,id=tap1 -device rtl8139,netdev=tap1 \
    -cdrom "$iso"

# -net nic -net tap,ifname=tap0 \
