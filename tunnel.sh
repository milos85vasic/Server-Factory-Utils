#!/bin/sh

port=$1
host=$2

ssh -L "$port":localhost:"$port" "$host"