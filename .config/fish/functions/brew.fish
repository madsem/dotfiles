# wraps homebrew, to support automatic generation of Brewfile
function brew -a cmd

    # run brew, and if it's an install or uninstall also update brewfile
    command brew $argv

    if contains install $argv
        or contains uninstall $argv
        
        command brew bundle dump --force --file=~/.config/dotfiles/prefs/brew/Brewfile

        echo "Your Brewfile was automatically updated!"

    end

end