#!/bin/env bash

gh release upload $CM_TAG \
build/**/outputs/apk/**/*.apk \
build/**/outputs/bundle/**/*.aab \
build/**/outputs/mapping/**/*-mapping.txt
