# make a .dmg [$pathToSource, $name]
function make_dmg --description 'make_dmg <path> <name>'
    if test (count $argv) -ne 2
        echo "Path & Name arguments must be set"
        return 1
    end
    
    hdiutil create -fs HFS+ -srcfolder "$1" -volname "$2" "$2.tmp.dmg"
    hdiutil convert "$2.tmp.dmg" -format UDZO -o "$2.dmg"
    rm "$2.tmp.dmg"
end