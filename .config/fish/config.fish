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

##
# Fish syntax highlighting - oceanic material color style
##
set -g fish_color_autosuggestion '555' 'brblack'
set -g fish_color_cancel -r
set -g fish_color_command 82aaff --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow' '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator f78c6c
set -g fish_color_param eeffe3
set -g fish_color_quote c3e88d
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow' '--background=brblack'
set -g fish_color_selection 'white' '--bold' '--background=brblack'
set -g fish_color_user yellow
set -g fish_color_valid_path --underline

##
# spacefish theme customization
##
set -g SPACEFISH_DIR_COLOR c792ea
set -g SPACEFISH_GIT_BRANCH_COLOR ffcb6b
set -g SPACEFISH_AWS_SYMBOL "☁️  "


##
# iTerm2
##

# set material design color preset
echo -e "\033]1337;SetColors=preset=material-design-colors\a"

# shell integration
source ~/.iterm2_shell_integration.fish
# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true
