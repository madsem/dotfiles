# manage the dotfiles repository, wraps git command 
# and includes options to run .macos & .macdock files separately
function dotfiles -a cmd -d 'dotfiles [any git command] | [macos] install .macos file | [dock] install .macdock file' --wraps git

    switch "$cmd"
        case macos

            # (re-)install .macos defaults file
            exec bash -c "source $HOME/.config/dotfiles/init/.macos; exec fish"

        case dock

            # (re-)install .macdock file
            exec bash -c "source $HOME/.config/dotfiles/init/.macdock; exec fish"

        case '*'

            # manage dotfiles
            command git \
                --git-dir=$HOME/.dotfiles/ \
                --work-tree=$HOME \
                $argv
    end

end