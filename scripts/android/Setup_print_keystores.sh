#!/bin/env bash

echo "Create keystore file from base64 format to $CM_KEYSTORE_PATH"

echo $CM_KEYSTORE | base64 --decode >$CM_KEYSTORE_PATH

DEBUG_PATH=~/.android/debug.keystore
RELEASE_PATH=$CM_KEYSTORE_PATH

keytool -list -v -keystore $DEBUG_PATH \
    -storepass android -alias androiddebugkey

keytool -list -v -keystore $RELEASE_PATH \
    -storepass $CM_KEYSTORE_PASSWORD -alias $CM_KEY_ALIAS
