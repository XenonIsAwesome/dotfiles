#!/usr/bin/env bash

# Functions
if test -f ~/mcservers/rcon.sh; then
    source ~/mcservers/rcon.sh
fi

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

function wtargz() {
    url=$@

    filename=$(basename $url)
    wget -q $url
    
    tar xzf $filename
    rm $filename
}

function wzip() {
    url=$@

    filename=$(basename $url)
    wget -q $url
    
    unzip -q $filename
    rm $filename
}

# Exports
export PYTHONDONTWRITEBYTECODE=1

# Aliases
source ~/scripts/docker_aliases.sh

alias urltool='~/scripts/urlquote_tool.py'
alias cat='batcat'
alias browser='/mnt/c/Program\ Files/BraveSoftware/Brave-Browser/Application/brave.exe'
alias genpush='git add . && git commit -m "updated some files" && git push'
alias hextool='python3 -c "import sys; print(bytes(sys.stdin.buffer.read()).hex())"'
