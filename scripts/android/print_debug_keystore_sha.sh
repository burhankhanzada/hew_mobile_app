#!/bin/env bash

keytool -list -v -keystore ~/.android/debug.keystore -storepass android -alias androiddebugkey

echo $ANDROID_SDK_ROOT
