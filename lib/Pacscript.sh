#!/bin/bash
#
# Pacscript Library
#
# Version
# 0.1: Initial version of the library
#
# Maintained by Diegiwg
# Copyright (c) 2023
#

Pacscript.get_value() {
    doc_usage="Usage: get_value <file_path> <key>"

    if [ -z "${1}" -o -z "${2}" ]; then
        echo "${doc_usage}"
        return 1
    fi

    e_key="${2}"
    if [ -z "${e_key}" ]; then
        echo "Key is empty!"
        return 1
    fi

    e_file_path="${1}"
    if [ ! -f "${e_file_path}" ]; then
        echo "File does not exist!"
        return 1
    fi

    file_data=$(cat "${e_file_path}")
    if [ -z "${file_data}" ]; then
        echo "File is empty!"
        return 1
    fi

    grep -oP "(?<=^$e_key=\")[^\"]*" <<<"${file_data}"
}
