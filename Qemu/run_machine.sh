#!/bin/sh

machine=$1

qemu-system-x86_64 -accel hvf -cpu host -m 2048 -smp 2 \
 -vga virtio -drive file="$machine.qcow2,format=qcow2,if=virtio"