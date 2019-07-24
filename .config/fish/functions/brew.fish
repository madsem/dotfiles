# wraps homebrew, to support automatic generation of Brewfile
function brew -a cmd --wraps brew

    # run brew, and if it's an install or uninstall also update brewfile
    command brew $argv

    if contains install $argv
        or contains uninstall $argv
        
        command brew bundle dump --force --file=~/.config/dotfiles/prefs/Homebrew/Brewfile

        echo "Your Brewfile was automatically updated!"

    end

end