# Link a local package to composer, so that it can be required like normal using "composer require..."
# from Caleb Porzio: https://calebporzio.com/bash-alias-composer-link-use-local-folders-as-composer-dependancies/
# Run from the working directory of the package, where composer.json is located.
function composer_link --description 'composer_link <path>'
    if test (count $argv) -ne 1
        echo "Path argument must be set"
        return 1
    end
    
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
end