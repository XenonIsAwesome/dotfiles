export PYTHONDONTWRITEBYTECODE=1

function correct-resolv() {
    # Run this to correct WSL's resolv.conf file (dns issue)
    sudo cp /etc/resolv.conf.correct /etc/resolv.conf
}

source ~/scripts/docker_aliases.sh
