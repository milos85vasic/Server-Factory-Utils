#!/bin/sh

size=$2
diskPath=$1
disk="$diskPath/disk.qcow2"

if ! test -e "$disk"; then

  mkdir -p "$diskPath"
  if ! qemu-img create -f qcow2 "$disk" "${size}G" >> /dev/null; then

    echo "$disk was not created"
    exit 1
  fi
fi

echo "$disk"
