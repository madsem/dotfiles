# open valet config repository with code editor
function valet_config

    set -l valet "$HOME/.config/valet/"
    if not test -d $valet
        echo "Laravel Valet isn't installed."
        return 1
    end
    
    eval ( editor valet )
end