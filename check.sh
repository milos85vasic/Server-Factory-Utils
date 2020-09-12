#!/bin/sh

ELAPSED=0
TIMEOUT=$2
CONTAINER=$1

until [ $ELAPSED -eq "${TIMEOUT}" ] || docker ps -a --filter "status=running" --filter "name=${CONTAINER}" | grep "${CONTAINER}"; do

  echo "Waiting for container to start: ${CONTAINER}, retry: $((ELAPSED = ELAPSED + 1))" && sleep 1
done

if test "$ELAPSED" -eq "${TIMEOUT}"
then

  echo "Container is not running: ${CONTAINER}"
  exit 1
else

  echo "Container is running: ${CONTAINER}"
  exit 0
fi
