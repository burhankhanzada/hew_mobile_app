#!/bin/env bash

GOOGLE_SERVICES_PATH="$CM_BUILD_DIR/android/app/google_services.json"

echo "Create google_services.json file from base64 format to $GOOGLE_SERVICES_PATH"

echo $GOOGLE_SERVICES | base64 --decode >$GOOGLE_SERVICES_PATH

cat $GOOGLE_SERVICES_PATH
