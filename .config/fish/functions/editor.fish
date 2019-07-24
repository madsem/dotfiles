function editor --description 'editor <path>'
    if test (count $argv) -ne 1
        echo "Path argument must be set"
        return 1
    end

    if not test -d $argv
        and not test -f $argv
        echo "$argv does not exist"
    end

    open -n -b "$CODE_EDITOR" --args $argv
end