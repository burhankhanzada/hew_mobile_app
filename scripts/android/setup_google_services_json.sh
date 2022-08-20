#!/bin/env bash

PATH="$CM_BUILD_DIR/android/app/google_services.json"

echo "Create google_services.json file from base64 format to $PATH"

echo $GOOGLE_SERVICES | base64 --decode >$PATH

cat $PATH
