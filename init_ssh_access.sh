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
    if eval "$(ssh-agent -s)"; then

      if sh is_macos.sh; then

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

if ssh root@"$certificate" mkdir -p .ssh; then

  echo "$machine: .ssh directory created"
  if cat "$certificate".pub | ssh root@"$machine" 'cat >> .ssh/authorized_keys'; then

    echo "$machine: Certificate imported"
  else

    echo "ERROR: $machine certificate not imported"
    exit 1
  fi
else

  echo "ERROR: $machine .ssh directory not created"
  exit 1
fi