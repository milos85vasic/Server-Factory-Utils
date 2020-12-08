#!/bin/sh

machine=$1
if [ -z "$2" ]
then

  port="22"
else

  port=$2
fi
echo "$machine: Checking reachability"
if ping -c 3 "$machine" >/dev/null 2>&1; then

  echo "$machine: Reachable"
else

  echo "ERROR: $machine is unreachable"
  exit 1
fi

no_manager="none"
install="$no_manager"
if ssh -p "$port" root@"$machine" "which yum"; then

  install="yum install -y"
else
  if ssh -p "$port" root@"$machine" "which dnf"; then

    install="dnf install -y"
  else
    if ssh -p "$port" root@"$machine" "which apt"; then

      install="apt install -y"
    else
      if ssh -p "$port" root@"$machine" "which pacman"; then

        install="pacman -Syu"
      fi
    fi
  fi
fi

if [ "$install" = "$no_manager" ]; then

  echo "ERROR: No package manager recognized"
  exit 1
else

  echo "Package manager is recognized"
fi

packages="nss-mdns avahi"
if ssh -p "$port" root@"$machine" "$install $packages"; then

  echo "$packages: Installed"
else

  echo "ERROR: $packages  not installed"
  exit 1
fi
