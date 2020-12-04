#!/bin/sh

to_set=$1
if hostnamectl set-hostname "$to_set"; then

  echo "Hostname set to: $to_set"
  if systemctl status avahi-daemon.service | grep running; then

    if ! systemctl restart avahi-daemon.service; then

      echo "ERROR: could not restart avahi daemon service"
      exit 1
    fi
  fi
else

  echo "ERROR: could not set hostname to: $to_set"
  exit 1
fi
