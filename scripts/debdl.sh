#!/usr/bin/env bash

set -e

# --- CONFIG ---
IMAGE_TAG="debdl-temp"
WORKDIR="/tmp/debdl"
ARCHIVE="debs.tar.gz"

PYTHON_HELPER="$(dirname $(realpath "$0"))/get_ubuntu_ver.py"

# --- FUNCTIONS ---

# Check if input is a valid Ubuntu version or codename
is_version_string() {
    [[ "$1" =~ ^[0-9]+\.[0-9]+([a-zA-Z]*)$ || "$1" =~ ^[a-z]+$ ]]
}

main() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: debdl [ubuntu-version] <package1> [package2 ...]"
        exit 1
    fi

    if is_version_string "$1"; then
        VERSION="$1"
        shift
    else
        VERSION="$(lsb_release -cs)"
    fi

    if [[ ! -f "$PYTHON_HELPER" ]]; then
        echo "Missing required file: $PYTHON_HELPER"
        exit 1
    fi

    CODENAME=$(python3 "$PYTHON_HELPER" "$VERSION")
    if [[ -z "$CODENAME" ]]; then
        echo "Could not determine Ubuntu codename for version: $VERSION"
        exit 1
    fi

    PACKAGES=("$@")
    if [[ ${#PACKAGES[@]} -eq 0 ]]; then
        echo "No packages specified."
        exit 1
    fi

    mkdir -p "$WORKDIR"
    echo "Downloading packages for Ubuntu $CODENAME: ${PACKAGES[*]}"

    docker run --rm -v "$WORKDIR":/out ubuntu:"$CODENAME" bash -c "
        apt-get update -qq &&
        apt-get install -y -qq apt-utils apt-transport-https &&
        apt-get install -y -qq gdebi-core &&
        cd /out &&
        apt-get download \$(apt-cache depends ${PACKAGES[*]} | grep 'Depends:' | awk '{print \$2}' | sort -u; echo ${PACKAGES[*]}) ||
        apt-get download ${PACKAGES[*]}
    "

    tar -czf "$ARCHIVE" -C "$WORKDIR" .
    echo "✅ Archive created: $ARCHIVE"
    rm -rf "$WORKDIR"
}

main "$@"
