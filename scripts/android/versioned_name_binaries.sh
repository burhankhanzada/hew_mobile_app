#!/bin/env bash

local_path="android/local.properties"

function prop {
    grep "${1}" ${local_path} | cut -d'=' -f2
}

build_mode=$(prop 'flutter.buildMode')
version_name=$(prop 'flutter.versionName')
version_code=$(prop 'flutter.versionCode')

versioned_name="$build_mode-$version_name-$version_code"

function update_name {

    local file=$1
    local file_directory=${file%/*}
    local file_name=${file##*/}
    local file_extension=${file_name##*.}

    local from=$file_name

    if [ build -ne "debug" -a $file_name -eq "mapping.txt" ]; then
        to="$versioned_name-mapping.txt"
    else
        to=$versioned_name.$file_extension
    fi

    mv $file $file_directory/$to

    echo -e "\nRenamed $from > $to"
}

OUTPUTS=build/**/outputs

update_name $OUTPUTS/apk/**/*.apk
update_name $OUTPUTS/bundle/**/*.aab
update_name $OUTPUTS/mapping/**/mapping.txt
