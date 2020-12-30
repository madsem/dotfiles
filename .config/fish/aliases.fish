##############################################################################
# Manage Important Dotfiles & Configs Easily
##############################################################################
alias edit_dot "$CODE_EDITOR ~/.config/dotfiles/"
alias edit_fish "$CODE_EDITOR ~/.config/fish/"
alias edit_hammerspoon "$CODE_EDITOR ~/.config/hammerspoon/"
alias edit_karabiner "$CODE_EDITOR ~/.config/karabiner/"
alias edit_macos "$CODE_EDITOR ~/.config/dotfiles/prefs/macos/.macos"
alias edit_macdock "$CODE_EDITOR ~/.config/dotfiles/prefs/macos/.macdock"

##############################################################################
# Git Stuff
##############################################################################
alias nope "git reset --hard && git clean -df"
alias gs "git status"
alias gl "git log --oneline"
alias gaa "git add ."
alias push 'git push origin (git branch --show-current)'
alias pull 'git pull origin master'
alias fetch 'git fetch origin master'


##############################################################################
# General Aliases
##############################################################################
alias cask "brew cask"

# Get macOS Software Updates, update Homebrew, yarn, composer, fisher and their installed packages
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; composer global update; fisher self-update; fisher"

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
