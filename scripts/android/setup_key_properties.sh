#!/bin/env bash

echo "Create keystore file from base64 format to $CM_KEYSTORE_PATH"

echo $CM_KEYSTORE | base64 --decode >$CM_KEYSTORE_PATH

KEY_PROPERTIES_PATH="$CM_BUILD_DIR/android/key.properties"

cat >>$KEY_PROPERTIES_PATH <<EOF
storePassword=$CM_KEYSTORE_PASSWORD
keyPassword=$CM_KEY_PASSWORD
keyAlias=$CM_KEY_ALIAS
storeFile=$CM_KEYSTORE_PATH
EOF

cat $KEY_PROPERTIES_PATH
