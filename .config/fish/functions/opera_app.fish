# Create or delete an applescript launcher for Opera with a custom user directory.
# This creates an independent browser instance which has built-in VPN & shares no data.
#
# And who doesn't need multiple independent browsers to manage various accounts, right, nobody!
function opera_app -a cmd -d 'Create or delete an Opera Applescript Launcher'

    # a name argument is required
    if test -n "$argv[1]"
        and test -z "$argv[2]"
        echo "The <name> argument is required."
        return 1
    end

    # make sure the name is allowed
    string match --quiet --ignore-case "Opera" $argv[2]
    if test $status -eq 0
        echo "This name is not allowed."
        return 1
    end

    # iCloud ftw.
    set -l path "$HOME/Documents/App Launchers/"
    set -l app $argv[2]'.app'

    switch "$cmd"

        case create

            if test -d "$path$app"
                echo "This app already exists"
                return 1
            end

            if not test -d "$path"
                mkdir -p "$path"
            end

            touch /tmp/applescript
            echo 'set opera to "\"/Applications/Opera.app/Contents/MacOS/Opera\""' >>/tmp/applescript
            echo 'set userdatadir to "\"$HOME/Library/Application Support/Opera/'"$argv[2]"'\""' >>/tmp/applescript
            echo 'do shell script opera & " --user-data-dir=" & userdatadir & " > /dev/null 2>&1 &"' >>/tmp/applescript

            # compile the apple script
            osacompile -o "$path$app" /tmp/applescript

            rm /tmp/applescript

            # add custom icon for opera launchers
            cp $HOME/.config/dotfiles/prefs/macos/icons/opera-launcher.icns "$path$app"/Contents/Resources/applet.icns

            # clear icon cache
            touch "$path$app"
            touch "$path$app"/Contents/Info.plist

            # add app launcher dir to dock
            dockutil --remove $path >/dev/null
            dockutil --add $path --view grid --display stack --label "App Launchers" --replacing "App Launchers" >/dev/null

            echo "App created..."
            echo "Enable Ad-Block."
            echo "Enable VPN:"
            echo "Americas/USA ISP is most of the time Opera Software AS (Least trouble with captchas)."

        case delete

            # remove the apple script launcher
            if not test -d "$path$app"
                echo "This app does not exist."
                return 1
            end

            rm -r $path$app

            # remove custom user directory for this opera instance
            set -l userDir "$HOME/Library/Application Support/Opera/$argv[2]"
            if test -d $userDir
                rm -r $userDir
            end

            # remove cache directory for this opera instance
            set -l cacheDir "$HOME/Library/Caches/Opera/$argv[2]"
            if test -d $cacheDir
                rm -r $cacheDir
            end

            echo "App was deleted."

        case '*'

            echo "Usage:"
            echo 'opera_app create "Some Name"'
            echo 'opera_app delete "Some Name"'

    end
end