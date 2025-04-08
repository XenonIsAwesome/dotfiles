function install_git() {
    if ! command -v git &> /dev/null; then
        echo "Installing git.";
        sudo apt install -y git;
    fi
}

function clone_dotfiles() {
    install_git;
    if [ ! -d "${HOME}/.dotfiles" ]; then
        git clone http://github.com/XenonIsAwesome/dotfiles.git ~/.dotfiles;
    fi
}

echo "Installing dotfiles.";
clone_dotfiles;

ln -sf $HOME/.dotfiles/.bashrc $HOME/.bashrc;
ln -sf $HOME/.dotfiles/scripts $HOME/;
echo "Installation successful";