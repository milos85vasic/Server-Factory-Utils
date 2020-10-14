#!/bin/sh

factoryType=$1
if test -e build.gradle && test -e Factory; then

  if which gradle; then
    if test -e gradlew; then

      echo "Gradle wrapper is available"
    else

      gradle wrapper
    fi

    ./gradlew clean && ./gradlew install
  fi
fi

if test Application/Release/Application.jar; then

  factoryPath="/usr/local/bin"
  echo "Please enter your sudo password to install the software" &&
    if sudo cp -f Application/Release/Application.jar "$factoryPath/factory_$factoryType.jar" &&
      cp -f Core/Utils/factory.sh "$factoryPath/factory_$factoryType.sh"; then

      definitions="$factoryPath/Definitions"
      detailsJson="$definitions/Details.json"
      if test -e "$detailsJson"; then
        # shellcheck disable=SC2002
        if cat "$detailsJson" | grep "definitions_version"; then

          echo "Existing software definitions found, cleaning up"
          if sudo rm -rf "$definitions"; then

            echo "Clean up completed"
          else

            echo "Clean up failed"
            exit 1
          fi
        fi
      fi

      if sudo cp -R Definitions "$definitions"; then

        echo "Software has been installed with success"
      else

        echo "Software installation failed, could not copy software definitions"
      fi
    else

      echo "Software installation failed"
      exit 1
    fi
else

  echo "No Application.jar found"
  exit 1
fi
