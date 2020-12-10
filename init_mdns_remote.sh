#!/bin/sh

name=$2
machine=$1
if [ -z "$3" ]; then

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
if ssh -p "$port" root@"$machine" "which dnf"; then

  if ssh -p "$port" root@"$machine" "cat /etc/os-release | grep -i centos" >/dev/null 2>&1; then

    if ssh -p "$port" root@"$machine" "dnf install -y epel-release"; then

      echo "EPEL installed"
    else

      echo "Could not install EPEL"
      exit 1
    fi
  else

    packages="avahi-tools"
  fi
  install="dnf install -y"
  packages="nss-mdns avahi $packages"
else
  if ssh -p "$port" root@"$machine" "which yum"; then

    install="yum install -y"
    packages="nss-mdns avahi avahi-tools"
  else
    if ssh -p "$port" root@"$machine" "which apt"; then

      install="apt install -y"
      packages="avahi-daemon avahi-discover avahi-utils libnss-mdns mdns-scan"
    else
      if ssh -p "$port" root@"$machine" "which pacman"; then

        # TODO: Support for Arch and Manjaro
        install="pacman -Syu"
        packages="nss-mdns avahi avahi-tools"
      fi
    fi
  fi
fi

if [ "$install" = "$no_manager" ]; then

  echo "ERROR: No package manager recognized"
  exit 1
fi

if ssh -p "$port" root@"$machine" "$install $packages"; then

  echo "$packages: Installed"
else

  echo "ERROR: $packages  not installed"
  exit 1
fi

service="avahi-daemon.service"
enable_service="systemctl enable --now $service"
if ssh -p "$port" root@"$machine" "$enable_service"; then

  echo "$service: Enabled"
else

  echo "ERROR: $service  not enabled"
  exit 1
fi

if ssh -p "$port" root@"$machine" "hostnamectl set-hostname $name"; then

  echo "$name: Set to $machine"
else

  echo "ERROR: $name not set to $machine"
  exit 1
fi

restart_service="systemctl restart $service"
if ssh -p "$port" root@"$machine" "$restart_service"; then

  echo "$service: Restarted"
else

  echo "ERROR: $service  not restarted"
  exit 1
fi

echo "$name: Checking reachability"
if ping -c 3 "$name" >/dev/null 2>&1; then

  echo "$name: Reachable"
else

  echo "ERROR: $name is unreachable"
  exit 1
fi

echo "mDNS setup completed with success"