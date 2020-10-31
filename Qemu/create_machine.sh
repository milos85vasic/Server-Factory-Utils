#!/bin/sh

iso=$2
machine=$1

sh create_disk.sh "$machine" 20 && \
qemu-system-x86_64 -accel hvf -cpu host -m 2048 -smp 2 -cdrom "$iso" \
 -vga virtio -drive file="$machine.qcow2,format=qcow2,if=virtio"