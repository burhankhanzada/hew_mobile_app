#!/bin/env bash

FIREBASE_OPTIONS_PATH="$CM_BUILD_DIR/lib/firebase_options.dart"

echo "Create firebase_options.dart file from base64 format to $FIREBASE_OPTIONS_PATH"

echo $FIREBASE_OPTIONS | base64 --decode >$FIREBASE_OPTIONS_PATH

cat $FIREBASE_OPTIONS_PATH
