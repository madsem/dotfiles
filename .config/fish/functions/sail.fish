# convenience wrapper for Laravel Sail docker development environment
# https://laravel.com/docs/8.x/sail#introduction
function sail -a cmd

    if not test -f "$PWD/vendor/bin/sail"
        echo "No Laravel Sail running in this directory."
        return 1
    end

    switch "$cmd"

        case install

            php artisan sail:install --with=mysql,redis,meilisearch,mailhog,selenium

        case rebuild

            # rebuild if docker-composer or Dockerfile has changed
            ./vendor/bin/sail build --no-cache && ./vendor/bin/sail up -d

        case up

            # start sail in detached mode
            ./vendor/bin/sail up -d

        case '*'

            # pass thru to vessel script
            ./vendor/bin/sail $argv
    end

end
