#######################################################
# Global ENVs
#######################################################

# preferred editor, I'm a noob, deal with it :)
set -gx EDITOR nano

# my preferred code editor
# command-line shortcut to open editor
set -gx CODE_EDITOR code

# Set Locale
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

##
# AWS Vault
##
set -gx AWS_VAULT_PROMPT osascript
set -gx AWS_VAULT_KEYCHAIN_NAME login
set -gx AWS_SESSION_TTL 12h
set -gx AWS_ASSUME_ROLE_TTL 15m
