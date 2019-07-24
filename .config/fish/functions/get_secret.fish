# get a secret environment_variable from the macOS keychain by looking up it's name
function get_secret --description 'get_secret <name>'
    if test (count $argv) -ne 1
        echo "Name argument must be set"
        return 1
    end
    
    security find-generic-password -w -a $USER -D "environment_variable" -s "$argv[1]"
end