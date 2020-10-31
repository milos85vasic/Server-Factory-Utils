#!/bin/sh

disk=$1
size=$2

if ! test -e "$disk.qcow2"; then

  qemu-img create -f qcow2 "$disk.qcow2" "${size}G"
else

  echo "$disk.qcow2 already exist"
fi
