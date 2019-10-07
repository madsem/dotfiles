# convenience wrapper for vessel docker development environment
# https://github.com/shipping-docker/vessel
function vessel -a cmd

    switch "$cmd"
        case secure

            set -l NGROK_PORT (sed -n -e '/APP_PORT/ s/.*\= *//p' "$PWD/.env")
            or set -l NGROK_PORT 80

            # create ngrok secure url for current vessel project
            ngrok http $NGROK_PORT

        case '*'

            if not test -f "$PWD/vessel"
                echo "No vessel running in this directory."
                return 1
            end

            # pass thru to vessel script
            ./vessel $argv
    end

end