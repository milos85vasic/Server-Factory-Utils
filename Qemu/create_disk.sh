#!/bin/sh

disk=$1
size=$2

qemu-img create "$disk.img" "${size}G"