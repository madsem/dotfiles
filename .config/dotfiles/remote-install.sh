#!/usr/bin/env bash

SOURCE="https://github.com/madsem/dotfiles"
TARGET="$HOME/.dotfiles"
TMP_TARGET="$HOME/.tmpdotfiles"

if ! type brew >/dev/null 2>/dev/null; then

    # homebrew automatically installs xcode cli tools, which include git
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

fi

if ! type git >/dev/null 2>/dev/null; then

    echo "Git wasn't installed, aborting..."
    exit 1

else

    echo "Cloning Dotfiles..."

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
