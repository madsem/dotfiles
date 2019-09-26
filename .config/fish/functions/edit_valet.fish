# open valet config repository with code editor
function edit_valet

    set -l valet "$HOME/.config/valet/"
    if not test -d $valet
        echo "Laravel Valet isn't installed."
        return 1
    end
    
    $CODE_EDITOR $valet
end