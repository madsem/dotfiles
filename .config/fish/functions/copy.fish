# copy contents of file to clipboard
function copy --description 'copy <path> - copy contents to clipboard'
    if test (count $argv) -ne 1
        echo "Path argument must be set"
        return 1
    end

    if not test -f $argv
        echo "$argv does not exist"
    end

    cat $argv | pbcopy
end