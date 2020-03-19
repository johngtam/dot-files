#!/usr/bin/env bash

# Bootstrap script for setting up a new OSX machine for command-line tools.

echo "Starting bootstrapping"

##########################################################################
# Installing rc files and configs
##########################################################################
cp .bash_profile ~/.bash_profile
cp .vimrc ~/.vimrc
cp .bashrc ~/.bashrc
cp .tmux.conf ~/.tmux.conf

##########################################################################
# Installing and updating Homebrew
##########################################################################
# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

##########################################################################
# Installing GNU utilities
##########################################################################

# Install GNU core utilities
brew install coreutils
brew install gnu-sed
brew install gnu-tar
brew install gnu-indent
brew install gnu-which

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

##########################################################################
# Installing Homebrew packages
##########################################################################

PACKAGES=(
    ack
    ansible
    awscli
    aws-elasticbeanstalk
    bash-completion
    bash-git-prompt
    curl
    ctags
    fzf
    git
    graphviz
    htop
    kubernetes-cli
    kubernetes-helm
    markdown
    midnight-commander
    node
    openssl
    postgresql
    pipenv
    pyenv-virtualenv
    python3
    pypy
    terraform
    the_silver_searcher
    tmux
    tree
    vim
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

##########################################################################
# Installing Python packages for Python2 and Python3
##########################################################################

echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}
sudo pip3 install ${PYTHON_PACKAGES[@]}

##########################################################################
# Installing Vim Pathogen + plugins
##########################################################################

echo "Installing Vim Pathogen..."
if [ ! -d "~/.vim/autoload" ]
then
    mkdir -p ~/.vim/autoload
fi

if [ ! -d "~/.vim/bundle" ]
then
    mkdir -p ~/.vim/bundle
fi
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# @TODO: Actually fix this so we don't overwrite everything next time...
echo "This script will display errors if the Vim plugin is already installed."
read -p "Are you sure you want to proceed? y/n " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Overwriting and installing Vim plugins..."
    VIM_PLUGINS=(
        tpope/vim-fugitive
        tpope/vim-surround
        tpope/vim-commentary.git
        tpope/vim-repeat
        scrooloose/nerdtree
        preservim/nerdcommenter.git
        vim-airline/vim-airline
        altercation/vim-colors-solarized
        rking/ag.vim.git
        kien/ctrlp.vim.git
        junegunn/fzf.vim.git
        sjl/gundo.vim.git
        easymotion/vim-easymotion.git
        christoomey/vim-tmux-navigator.git
        jceb/vim-orgmode.git
        jeetsukumaran/vim-buffergator.git
        vim-airline/vim-airline-themes.git
        majutsushi/tagbar.git
    )

    cd ~/.vim/bundle

    for package in "${VIM_PLUGINS[@]}"
    do
        git clone https://github.com/"${package}"
    done

    cd ~

fi
