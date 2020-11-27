#!/bin/sh

machine=$1

certificate=~/.ssh/server_factory
echo "$certificate: Checking certificate"
if test -e "$certificate"; then

  echo "$certificate: Available"
else

  echo "WARNING: $certificate not available, we will generate it"
  if echo "$certificate" | ssh-keygen -t ed25519 -C "client@server.factory"; then

    echo "$certificate: Generated"
  else

    echo "ERROR: $certificate not Generated"
  fi
fi