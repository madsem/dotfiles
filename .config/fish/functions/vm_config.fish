# open custom vagrant box config repository with code editor
function vm_config

    set -l vm "$HOME/.config/dotfiles/vagrant"
    if not test -e $vm"/Vagrantfile"
        echo "Custom Vagrant Box isn't installed."
        return 1
    end
    
    eval ( cd $vm and editor . )
end