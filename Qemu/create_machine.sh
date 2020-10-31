#!/bin/sh

iso=$2
machine=$1

sh create_disk.sh "$machine" 20 && \
qemu-system-x86_64 -cdrom "$iso" -cpu host -enable-kvm -m 2048 -smp 2 -drive file="$machine.img"