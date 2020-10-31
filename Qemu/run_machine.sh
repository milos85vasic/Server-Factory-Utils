#!/bin/sh

machine=$1
acceleration=$(sh get_acceleration.sh)

qemu-system-x86_64 -accel "$acceleration" -cpu host -m 2048 -smp 2 \
    -vga virtio -drive file="$machine.qcow2,format=qcow2,if=virtio"