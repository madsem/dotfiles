##############################################################################
# Manage Important Dotfiles & Configs Easily
##############################################################################
alias edit_fish "editor ~/.config/fish/"
alias edit_hammerspoon "editor ~/.config/hammerspoon/"
alias edit_karabiner "editor ~/.config/karabiner/"
alias edit_macos "editor ~/.config/dotfiles/init/.macos"
alias edit_macdock "editor ~/.config/dotfiles/init/.macdock"

##############################################################################
# Git Stuff
##############################################################################
alias nope "git reset --hard && git clean -df"
alias gs "git status"
alias gl "git log --graph"
alias gp "git push"
alias gaa "git add ."
alias gc "git commit -m "
alias gco "git checkout "
alias master "git checkout master"

##############################################################################
# General Aliases
##############################################################################
alias cask "brew cask"

# Get macOS Software Updates, update Homebrew, yarn, composer, fisher and their installed packages
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; yarn global upgrade; composer global update; fisher self-update; fisher"

# show disk information of all mounted volumes
alias diskspace "df -P -kHl"

# Recursively delete `.DS_Store` files
alias remove_ds "find . -name '*.DS_Store' -type f -ls -delete"

# get my ip
alias myip "dig +short myip.opendns.com @resolver1.opendns.com"

# Go to Code dir
alias codes "cd $HOME/Code"

# Go to Sites dir
alias sites "cd $HOME/Sites"

# clear trash using osascript, with sound and all that
alias clear_trash "osascript -e 'tell app \"Finder\" to empty'"
