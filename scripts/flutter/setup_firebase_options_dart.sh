#!/bin/env bash

PATH="$CM_BUILD_DIR/lib/firebase_options.dart"

echo "Create firebase_options.dart file from base64 format to $PATH"

echo $FIREBASE_OPTIONS | base64 --decode >$PATH

cat $PATH
