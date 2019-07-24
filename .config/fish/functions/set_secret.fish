# add a new secret environment_variable to macOS keychain in key/value format
function set_secret --description 'set_secret <name> <value>'
    if test (count $argv) -ne 2
        echo "Name & Value arguments must be set"
        return 1
    end
    
    security add-generic-password -U -a $USER -D "environment_variable" -s "$argv[1]" -w "$argv[2]"
end