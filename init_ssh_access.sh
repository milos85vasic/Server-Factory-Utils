#!/bin/sh

machine=$1
if [ -z "$2" ]
then

  port="22"
else

  port=$2
fi

certificate=~/.ssh/server_factory
echo "$certificate: Checking certificate"
if test -e "$certificate"; then

  echo "$certificate: Available"
else

  echo "WARNING: $certificate not available, we will generate it"
  if echo "$certificate" | ssh-keygen -t ed25519 -C "client@server.factory"; then

    echo "$certificate: Generated"
    if eval "$(ssh-agent -s)"; then

      if uname | grep -i "darwin" >/dev/null 2>&1; then

        config=~/.ssh/config
        if ! test -e "$config" && touch "$config"; then

          echo "$config: Created"
        fi
        if test -e "$config"; then

          echo "$config: Ready"
          if echo """

            Host client.server.factory
                AddKeysToAgent yes
                IdentityFile $certificate
          """ | tee "$config" ; then

            echo "$certificate: Identity added to config"
          else

            echo "ERROR: $certificate failed to add identity"
            exit 1
          fi
        else

          echo "ERROR: $config not available"
          exit 1
        fi
      fi

      if ssh-add "$certificate"; then

        echo "$certificate: Loaded"
      else

        echo "ERROR: $certificate not loaded"
        exit 1
      fi
    else

      echo "ERROR: SSH agent failure"
      exit 1
    fi
  else

    echo "ERROR: $certificate not Generated"
    exit 1
  fi
fi

if ! ping -c 3 "$machine"; then

  echo "ERROR: $machine is unreachable"
  exit 1
fi

authorized_keys=".ssh/authorized_keys"
if ssh -p "$port" root@"$machine" cat "$authorized_keys" | grep "$(cat $certificate.pub)" >/dev/null 2>&1; then

  echo "$certificate: Available on $machine"
else

    if ssh -p "$port" root@"$machine" mkdir -p .ssh; then

      echo "$machine: .ssh directory created"
      if cat "$certificate".pub | ssh -p "$port" root@"$machine" "cat >> $authorized_keys"; then

        echo "$machine: Certificate imported"
        if ssh -p "$port" root@"$machine" 'echo Hello'; then

          echo "$machine: Ready"
        else

          echo "ERROR: $machine is not ready"
          exit 1
        fi
      else

        echo "ERROR: $machine certificate not imported"
        exit 1
      fi
  else

    echo "ERROR: $machine .ssh directory not created"
    exit 1
  fi
fi