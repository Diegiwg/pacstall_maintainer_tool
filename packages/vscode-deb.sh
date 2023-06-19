#!/bin/bash
source $STD

SCRIPT_PATH="./pacscripts/vscode-deb.pacscript"
SOURCE_BASE_URL="https://packages.microsoft.com/repos/code/pool/main/c/code/"

function get_last_version() {
    curl -s "${SOURCE_BASE_URL}" | grep -oP '(?<=code_)[^-]*' | tail -n 1
}

function get_file_url() {
    e_arch="${1}"

    version=$(get_last_version)
    hash=$(curl -s "${SOURCE_BASE_URL}" | grep -oP "(?<=${version}-)[^.]*(?=_${e_arch})" | tail -n 1)

    if [ "${2}" == '-vars' ]; then
        echo "${SOURCE_BASE_URL}code_\${version}-${hash}_\${arch}.deb"
    else
        echo "${SOURCE_BASE_URL}code_${version}-${hash}_${e_arch}.deb"
    fi
}

function get_hash() {
    e_arch="${1}"
    url=$(get_file_url "${e_arch}")

    Hash.from_url "${url}"
}

function update() {
    current_version=$(Pacscript.get_value $SCRIPT_PATH 'version')
    last_version=$(get_last_version)

    if [ "${current_version}" != "${last_version}" ]; then
        echo "The $(Pacscript.get_value $SCRIPT_PATH 'name') package is not up to date. Upgrade from ${current_version} to ${last_version}."
    else
        echo "The $(Pacscript.get_value $SCRIPT_PATH 'name') package is up to date. Latest version is ${current_version}."
    fi
}

function upgrade() {
    version=$(get_last_version)

    echo "name=\"vscode-deb\"" >${SCRIPT_PATH}
    {
        echo "arch=(\"amd64\" \"arm64\" \"armhf\")"
        echo "gives=\"code\""
        echo "version=\"${version}\""
        echo "homepage=\"https://code.visualstudio.com/\""
        echo "description=\"lightweight but powerful source code editor\""
        echo "project=(\"project: vscode\")"
        echo "maintainer=\"Diegiwg <diegiwg@gmail.com>\""
        echo
        echo "case \"\${CARCH}\" in"
        echo "  amd64)"
        echo "    url=\"$(get_file_url amd64 -vars)\""
        echo "    hash=\"$(get_hash amd64)\""
        echo "    ;;"
        echo "  arm64)"
        echo "    url=\"$(get_file_url arm64 -vars)\""
        echo "    hash=\"$(get_hash arm64)\""
        echo "    ;;"
        echo "  armhf)"
        echo "    url=\"$(get_file_url armhf -vars)\""
        echo "    hash=\"$(get_hash armhf)\""
        echo "    ;;"
        echo "  *) return 1 ;;"
        echo "esac"
    } >>${SCRIPT_PATH}

    echo "Successfully upgraded the $(Pacscript.get_value $SCRIPT_PATH 'name') pacscript."
}

# MAIN #

case "${1}" in
update)
    update
    ;;
upgrade)
    upgrade
    ;;
version)
    Pacscript.get_value $SCRIPT_PATH 'version'
    ;;
*)
    exit 1
    ;;
esac
