#!/bin/env bash

LOCAL="$CM_BUILD_DIR/android/local.properties"

echo "Create flutter sdk location varaible in local.properies"

echo "flutter.sdk=$HOME/programs/flutter" >$LOCAL

cat $LOCAL
