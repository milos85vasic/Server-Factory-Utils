#!/bin/sh

script_path="/usr/local/bin"
script_path_full="$script_path/server_factory_bridge_name.sh"

if test -e "$script_path_full"; then

  bridge=$(sh "$script_path_full")
  if sh create_bridge.sh "$bridge" 2> /dev/null; then

    echo "$bridge"
    exit 0
  else

    echo "ERROR: Could not create bridge [1]"
    exit 1
  fi
else

  for ITER in 1 .. 100
  do

    bridge="bridge$ITER"
    if ! ifconfig "$bridge" 2> /dev/null; then

      if sh create_bridge.sh "$bridge" 2> /dev/null; then

        echo """
        #!/bin/sh

        echo $bridge
        """ > "$script_path_full" && chmod 750 "$script_path_full"
        echo "$bridge"
        exit 0
      else

        echo "ERROR: Could not create bridge [2]"
        exit 1
      fi
    fi
  done
fi

echo "ERROR: Could not obtain bridge candidate"
exit 1