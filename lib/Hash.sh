#!/bin/bash
#
# Hash Library
#
# Version
# 0.1: Initial version of the library, with only function for hash a file in URl
# 0.2: Fixing the function for hash a file in URL
#
# Maintained by Diegiwg
# Copyright (c) 2023
#

# Function: Hash.from_url()
#
# Description:
# This function calculates the hash value of a file obtained from a URL. It supports multiple hash algorithms such as SHA-1, SHA-224, SHA-256, SHA-384, and SHA-512. The function retrieves the file from the provided URL using curl and calculates the hash value based on the specified algorithm.
#
# Usage: from_url <url_string> [algorithm]
#
# Parameters:
# - url_string: The URL of the file to be downloaded and hashed.
# - algorithm (optional): The hash algorithm to be used. If not provided, it defaults to "sha256". Supported values are "sha1", "sha224", "sha256", "sha384", and "sha512".
#
# Returns:
# The calculated hash value of the file obtained from the URL.
#
# Examples:
# 1. Calculate the SHA-256 hash of a file from a URL:
#    Hash.from_url "https://example.com/file.txt"
#
# 2. Calculate the SHA-1 hash of a file from a URL:
#    Hash.from_url "https://example.com/file.txt" "sha1"
#
# 3. Calculate the SHA-512 hash of a file from a URL:
#    Hash.from_url "https://example.com/file.txt" "sha512"
#
# Note:
# - This function requires the 'curl' command-line tool to be installed.
# - The hash algorithm must be supported by the underlying system for accurate results. If an unsupported algorithm is specified, an error message will be displayed.
#

function Hash.from_url() {
    e_url="${1}"
    if [ -z "${e_url}" ]; then
        echo "Usage: from_url <url_string> [algorithm]"
        return 1
    fi

    e_algorithm="sha256"
    if [ -n "${2}" ]; then
        e_algorithm="${2}"
    fi

    local hash
    case "${e_algorithm}" in
    sha1)
        if command -v sha1sum >/dev/null; then
            hash=$(curl -s "${e_url}" -o - | sha1sum)
        else
            echo "Algorithm not supported on the host system"
            return 1
        fi
        ;;
    sha224)
        if command -v sha224sum >/dev/null; then
            hash=$(curl -s "${e_url}" -o - | sha224sum)
        else
            echo "Algorithm not supported on the host system"
            return 1
        fi
        ;;
    sha256)
        if command -v sha256sum >/dev/null; then
            hash=$(curl -s "${e_url}" -o - | sha256sum)
        else
            echo "Algorithm not supported on the host system"
            return 1
        fi
        ;;
    sha384)
        if command -v sha384sum >/dev/null; then
            hash=$(curl -s "${e_url}" -o - | sha384sum)
        else
            echo "Algorithm not supported on the host system"
            return 1
        fi
        ;;
    sha512)
        if command -v sha512sum >/dev/null; then
            hash=$(curl -s "${e_url}" -o - | sha512sum)
        else
            echo "Algorithm not supported on the host system"
            return 1
        fi
        ;;
    *)
        echo "Algorithm not supported"
        return 1
        ;;
    esac

    grep -oP '^\w+' <<<"${hash}"
}
