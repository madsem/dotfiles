# disable greeting
set fish_greeting

# if there's a .secrets file, source that
set secrets ~/.secrets
if test -e secrets
    source secrets
end

# source global envs / exports
source ~/.config/fish/envs.fish

# source aliases
if status --is-login
    source ~/.config/fish/aliases.fish
end

# source abbreviations
if status --is-login
    source ~/.config/fish/abbreviations.fish
end

# add entries from paths file to $PATH
source ~/.config/fish/paths.fish
for entry in $entries
    set -gx PATH $entry $PATH
end

# activate Docker shell completion
set -l dockerCompletions /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion
if status --is-login
    and test -e $dockerCompletions
    source $dockerCompletions
end


# Fisher Package Manager
# https://github.com/jorgebucaran/fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME
    or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end


# shell integration
source ~/.iterm2_shell_integration.fish

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true

# Starship prompt init
starship init fish | source
