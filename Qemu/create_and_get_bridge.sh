#!/bin/sh

script_path="/usr/local/bin"
script_path_full="$script_path/get_server_factory_bridge_name.sh"

if test -e "$script_path_full"; then

  sh "$script_path_full"
else

  for ITER in 1 .. 100
  do
    bridge="bridge$ITER"
    if ! (ifconfig "$bridge" > /dev/null); then

      echo """
      #!/bin/sh

      echo $bridge
      """ > "$script_path_full" && chmod 750 "$script_path_full"
      sh "$script_path_full"
      exit 0
    fi
  done
fi

echo "ERROR: Could not obtain bridge name"
exit 1