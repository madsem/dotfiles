#!/usr/bin/env bash

SOURCE="https://github.com/madsem/dotfiles"
TARGET="$HOME/.dotfiles"
TMP_TARGET="$HOME/.tmpdotfiles"

is_executable() {
    type "$1" >/dev/null 2>&1
}

if ! is_executable "brew"; then

    # homebrew automatically installs xcode cli tools, which include git
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

fi

if ! is_executable "git"; then

    echo "Git wasn't installed, aborting..."
    exit 1

else

    echo "Cloning Dotfiles..."

    mkdir -p "$TARGET"
    mkdir -p "$TMP_TARGET"

    git clone --separate-git-dir=$TARGET $SOURCE $TMP_TARGET
    rsync --recursive --verbose --exclude '.git' $TMP_TARGET/ $HOME/
    rm -r $TMP_TARGET

    # don't show untracked files for $HOME dir
    git \
        --git-dir=$TARGET \
        --work-tree=$HOME \
        config --local status.showUntrackedFiles no

    # we're done
    echo "Dotfiles repository installed at ${HOME}/.dotfiles & work-tree at ${HOME}"
    echo "Use 'dotfiles' instead of 'git' command to manage."

fi
