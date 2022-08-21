#!/bin/env bash

local_path="android/local.properties"

function prop {
    grep "${1}" ${local_path} | cut -d'=' -f2
}

build_mode=$(prop 'flutter.buildMode')

gh release upload $CM_TAG \
build/**/outputs/apk/**/*.apk \
build/**/outputs/bundle/**/*.aab

if [ build -ne "debug" ]; then
    gh release upload $CM_TAG build/**/outputs/mapping/**/*-mapping.txt
fi
