#!/bin/sh

machine=$1
display=$(sh get_display.sh)
acceleration=$(sh get_acceleration.sh)

qemu-system-x86_64 -accel "$acceleration" -cpu host -m 2048 -smp 2 \
  -display "$display",show-cursor=on -usb -device usb-tablet -vga virtio \
  -drive file="$machine.qcow2,format=qcow2,if=virtio"