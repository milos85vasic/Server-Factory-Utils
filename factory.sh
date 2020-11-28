#!/bin/sh

if which java; then

  factoryType=$1
  configuration=$2
  factoryPath=$(sh "${factoryType}_factory_path.sh")

  jarFile="$factoryPath/factory_$factoryType.jar"
  if test -e "$jarFile"; then

    cd ~ && java -jar "$jarFile" "$configuration" --installationHome="$factoryPath"
  else

    echo "No $factoryType factory jar found at: $factoryPath"
    exit 1
  fi
else

  echo "No Java installation available. Please install Java and try again."
  exit 1
fi
