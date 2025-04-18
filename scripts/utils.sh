#!/usr/bin/env bash

# Functions
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

# Exports
export PYTHONDONTWRITEBYTECODE=1

# Aliases
source ~/scripts/docker_aliases.sh

alias urltool='~/scripts/urlquote_tool.py'
alias cat='batcat'
alias browser='/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe'
