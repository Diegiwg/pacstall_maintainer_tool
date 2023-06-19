#!/bin/bash
#
# String Manipulation Functions
#
# Version
# 0.1: Initial version of the library, with some basic functions (contains, capitalize ...)
#
# Maintained by Diegiwg
# Copyright (c) 2023
#

# Function that checks if the string contains the specified substring
# Input: string, substring
# Output: 0 if the string contains the substring, 1 otherwise
Strings.contains() {
    local string="${1}"
    local substring="${2}"
    local contains="${string//${substring}/}"
    if [ -z "${contains}" ]; then
        return 1
    fi
    return 0
}

# Function that capitalizes the first letter of the string
# Input: string
# Output: string with the first letter capitalized
Strings.capitalize() {
    local string="${1}"
    echo "${string^}"
}

# Function that returns the length of the string
# Input: string
# Output: length of the string
Strings.length() {
    local string="${1}"
    local length="${#string}"
    echo "${length}"
}

# Function that converts the string to lowercase
# Input: string
# Output: string in lowercase
Strings.lowercase() {
    local string="${1}"
    echo "${string,,}"
}

# Function that removes trailing whitespace from the string
# Input: string
# Output: string without trailing whitespace
Strings.rstrip() {
    local string="${1}"
    sed 's/ *$//mg' <<<"$string"
}

# Function that removes leading and trailing whitespace from the string
# Input: string
# Output: string without leading and trailing whitespace
Strings.strip() {
    local string="${1}"
    string=$(Strings.lstrip "${string}")
    string=$(Strings.rstrip "${string}")
    echo "${string}"
}

# Function that removes leading and trailing whitespace from the string
# and removes duplicate whitespace within the string
# Input: string
# Output: string without leading and trailing whitespace and without duplicate whitespace
Strings.trim() {
    local string="${1}"
    string=$(Strings.lstrip "${string}")
    string=$(Strings.rstrip "${string}")
    sed 's/ \{2,\}/ /mg' <<<"$string"
}

# Function that converts the string to uppercase
# Input: string
# Output: string in uppercase
Strings.uppercase() {
    local string="${1}"
    echo "${string^^}"
}

# Function that replaces all occurrences of the old value with the new value in the string
# Input: string, old value, new value
# Output: string with the replacements made
Strings.replace() {
    local string="${1}"
    local old_value="${2}"
    local new_value="${3}"
    echo "${string//${old_value}/${new_value}}"
}

# Function that removes leading whitespace from the string
# Input: string
# Output: string without leading whitespace
Strings.lstrip() {
    local string="${1}"
    sed 's/^ *//mg' <<<"$string"
}
