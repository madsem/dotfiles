# make title more useful
function fish_title

    # display user @ host only if we're on a remote SSH connection
    # or user is different from logname
    if [ "$USER" != "$LOGNAME" -o -n "$SSH_CLIENT" ]
        set -l IFS .
        hostname | read -l hostname __
        echo -ns (whoami) '@' $hostname ': '
    end

    # display process only if it's not fish
    if not test $_ = 'fish'
        echo $_" "
        prompt_pwd
    else
        prompt_pwd
    end

end