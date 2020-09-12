#!/bin/sh

PORT=$1
ELAPSED=1
TIMEOUT=120

until [ $ELAPSED -eq "${TIMEOUT}" ] || echo "^C" | telnet 127.0.0.1 "${PORT}" | grep "Connected"; do
  echo "Waiting for port to bind: ${PORT}, retry: $ELAPSED"
  sleep $((ELAPSED = ELAPSED + 1))
done

if test "$ELAPSED" -eq ${TIMEOUT}
then

  echo "Port is not bound: ${PORT}"
  exit 1
else

  echo "Port is bound: ${PORT}"
  exit 0
fi
