#!/bin/bash

declare FILE="./pacscripts/vscode-insiders-deb.pacscript"
declare BASE_URL="https://packages.microsoft.com/repos/code/pool/main/c/code-insiders/"

function get_value() {
    key=${1}
    grep "${key}=" <"${FILE}" | cut -d "\"" -f2
}

function get_latest_version() {
    curl -s "${BASE_URL}" | grep -oP '\d+\.\d+\.\d+' | tail -n 1
}

function get_url() {
    arch="${1}"
    version="${2}"

    echo "${BASE_URL}code-insiders_\${version}-$(curl -s "${BASE_URL}" | grep "${version}" | grep "${arch}" | cut -d'>' -f2 | cut -d'<' -f1 | tail -n 1 | cut -d'_' -f2 | cut -d'-' -f2)_${arch}.deb"
}

function get_hash() {
    arch="${1}"
    version="${2}"

    url="${BASE_URL}$(curl -s "${BASE_URL}" | grep "${version}" | grep "${arch}" | cut -d'>' -f2 | cut -d'<' -f1 | tail -n 1)"
    curl -s "${url}" -o - | sha256sum | cut -d' ' -f1
}

function update() {
    current_version=$(get_value 'version')
    latest_version=$(get_latest_version)

    if [ "${current_version}" != "${latest_version}" ]; then
        echo "The $(get_value 'name') package is not up to date. Upgrade from ${current_version} to ${latest_version}."
    else
        echo "The $(get_value 'name') package is up to date. Latest version is ${current_version}."
    fi

}

function upgrade() {
    version=$(get_latest_version)

    echo "name=\"vscode-insiders-deb\"" >${FILE}
    {
        echo "arch=(\"amd64\" \"arm64\" \"armhf\")"
        echo "gives=\"code-insiders\""
        echo "version=\"${version}\""
        echo "homepage=\"https://code.visualstudio.com/\""
        echo "description=\"lightweight but powerful source code editor\""
        echo "project=(\"project: vscode-insiders\")"
        echo "maintainer=\"Diegiwg <diegiwg@gmail.com>\""
        echo
        echo "case \"\${CARCH}\" in"
        echo "  amd64)"
        echo "    url=\"$(get_url amd64 "${version}")\""
        echo "    hash=\"$(get_hash amd64 "${version}")\""
        echo "    ;;"
        echo "  arm64)"
        echo "    url=\"$(get_url arm64 "${version}")\""
        echo "    hash=\"$(get_hash arm64 "${version}")\""
        echo "    ;;"
        echo "  armhf)"
        echo "    url=\"$(get_url armhf "${version}")\""
        echo "    hash=\"$(get_hash armhf "${version}")\""
        echo "    ;;"
        echo "  *) return 1 ;;"
        echo "esac"
    } >>${FILE}

    echo "Successfully upgraded the $(get_value 'name') pacscript."

}

function cli() {
    local args=("${*}")
    command="${1}"

    if [ -z "${command}" ]; then
        echo "Usage: $0 <command>"
        exit 1
    fi

    case "${command}" in
    update)
        update
        ;;
    upgrade)
        upgrade
        ;;
    version)
        get_value 'version'
        ;;
    *)
        exit 1
        ;;
    esac
}

declare args=("${*}")
cli $args
