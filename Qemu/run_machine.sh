#!/bin/sh

machine=$1

qemu-system-x86_64 -cpu host -enable-kvm -m 2048 -smp 2 -drive file="$machine.img"