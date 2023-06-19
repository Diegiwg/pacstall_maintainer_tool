#!/bin/bash
source $STD

SCRIPT_PATH="./pacscripts/telegram-bin.pacscript"
SOURCE_BASE_URL="https://updates.tdesktop.com/tlinux/"
GIT_RELEASES_URL="https://github.com/telegramdesktop/tdesktop/releases"

function get_last_version() {
    curl -s "${GIT_RELEASES_URL}" | grep -oP '(?<=>v\s)[^<]*' | head -n 1
}

function get_file_url() {
    args="${1}"
    version=$(get_last_version)

    # https://updates.tdesktop.com/tlinux/tsetup.4.8.4.tar.xz

    if [ "${args}" == '-vars' ]; then
        echo "${SOURCE_BASE_URL}tsetup.\${version}.tar.xz"
    else
        echo "${SOURCE_BASE_URL}tsetup.${version}.tar.xz"
    fi
}

function get_hash() {
    url=$(get_file_url none)
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

    echo "name=\"telegram-bin\"" >${SCRIPT_PATH}
    {
        echo "gives=\"telegram\""
        echo "version=\"${version}\""
        echo "homepage=\"https://telegram.org/\""
        echo "description=\"Telegram is a cloud-based mobile and desktop messaging app with a focus on security and speed\""
        echo "url=\"$(get_file_url -vars)\""
        echo "hash=\"$(get_hash)\""
        echo "repology=(\"project: telegram-desktop\")"
        echo "maintainer=\"Diegiwg <diegiwg@gmail.com>\""
        echo
        echo "install() {"
        echo "    sudo install -Dm755 \"Telegram\" \"\${pkgdir}/usr/bin/\${gives}\""
        echo "}"
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
