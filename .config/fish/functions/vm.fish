# convenience wrapper for vagrant
# using my custom box
function vm --wraps vagrant

    set -l vm "$HOME/.config/dotfiles/vagrant"
    if not test -e $vm"/Vagrantfile"
        echo "Custom Vagrant Box isn't installed."
        return 1
    end
    
    eval ( cd $vm and eval vagrant $argv )
end