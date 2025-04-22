function install_git() {
    
}

function install_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Installing docker."

        # Add Docker's official GPG key:
        sudo apt update -y
        sudo apt install -y ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        # Add the repository to Apt sources:
        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update -y

        # Install docker debian packages
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    fi
}

function install_python_packages() {
    sudo apt install -y python3-pip python3-bs4 python3-virtualenv
}

function install_misc() {
    sudo apt install -y bat
}

function clone_dotfiles() {
    # Install git
    if ! command -v git &> /dev/null; then
        sudo apt install -y git;
    fi;

    # Clone repo
    if [ ! -d "${HOME}/.dotfiles" ]; then
        git clone http://github.com/XenonIsAwesome/dotfiles.git ~/.dotfiles;
    fi

    # Update repo
    pushd ~/.dotfiles 2>&1 >/dev/null
    git pull
    popd 2>&1 >/dev/null
}

function main() {
    echo "Installing dotfiles.";
    clone_dotfiles;

    install_docker;
    install_misc;

    ln -sf $HOME/.dotfiles/.bashrc.omb $HOME/.bashrc;
    ln -sf $HOME/.dotfiles/scripts $HOME/;
    echo "Installation successful";
}

main "$@"
