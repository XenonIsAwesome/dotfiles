#!/usr/bin/env bash

# Functions
source ~/mcservers/rcon.sh

function correct-resolv() {
    # Run this to correct WSL's resolv.conf file (dns issue)
    sudo cp /etc/resolv.conf.correct /etc/resolv.conf
}

function mansplain () {
    # Extracts data from the explainshell and parses it into a manpage
    if [ $# -eq 0 ]; then
        echo "Usage: mansplain <command>"
        return 1
    fi

    python3 ~/scripts/explainshell_extractor.py $* | man -l -
}

function commando() {
        package_names=()
        for arg in "$@"; do
                pkg_name=$(curl -sSfL "https://command-not-found.com/-/api/package/debian/${arg}")
                package_names+=("$pkg_name")
        done

        packages="${package_names[*]}"
        sudo apt install $packages
}

# Exports
export PYTHONDONTWRITEBYTECODE=1

# Aliases
source ~/scripts/docker_aliases.sh

alias urltool='~/scripts/urlquote_tool.py'
alias cat='batcat'
alias browser='/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe'
