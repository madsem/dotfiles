# . files :fireworks:
My dotfiles to set up, install &amp; manage everything I need on a new mac (or an old one if I broke it).

Feel free to clone it, use it, take it apart or change it to your liking. I use this for my own setup, but tried to build it all in a way so it can easily be re-used or adjusted by someone else. I can't guarantee that it will just work with your setup, so please don't run this blindly on your brand-new mac but instead fork it and adjust everything to your needs.

# What's Included:
- Fish Shell with useful custom functions.
- Spacefish Theme with material design colors.
- Mackup
- Homebrew & Cask
- Karabiner Elements (caps-lock hyper key)
- [Hammerspoon](../hammerspoon/README.md) (workspaces, hotkeys, window management)
- SSH Key management / backup (AWS Secrets Manager)
- Keychain cli helpers to set & get secrets
- AWS Cli with AWS-Vault integration for automated temporary credential management out of the box.
- moar...

# Install:
**For moving existing dotfiles to a new machine - Make sure that:**
- [ ] Mackup's latest Dropbox backup contains everything.
- [ ] Local Keychains were moved to the new machine (Airdrop or so).
- [ ] Everything else that is important, is in iCloud.

1. First, use the remote install script, which automatically takes care of installing `git` & cloning the repo as a bare repository to `~/.dotfiles`, then rsyncs existing files in your `$HOME` directory with the dotfiles to avoid conflicts.  
```shell
$ bash -c "`curl -fsSL https://raw.githubusercontent.com/madsem/dotfiles/master/.config/dotfiles/remote-install.sh`"
```

2. Run the setup script, let it complete and then restart before moving on.
```shell
$ ~/.config/dotfiles/setup
```

3. Log into Dropbox & wait until everything is done syncing.

4. Now restore mackup's backup:  
```shell
$ mackup -fv restore
```

5. Copy Launch Agents:  
**don't do this before mackup restore, it might overwrite files in Dropbox**
```shell
$ cp ~/.config/dotfiles/prefs/macos/launchd/* ~/Library/LaunchAgents/
```

## Final Setup:
1. Now configure `aws-vault` & your `~/.aws/config` - [AWS Setup](#aws-setup)  

2. Then export your SSH keys from AWS Secrets Manager, to your machine:
```shell
$ aws profile <your_admin_role>
$ aws_export_ssh_key <path> <region>
```

If things went as planned, you should have everything the way you had it on your old mac! Or alternatively, a totally broken machine :D


# Concept
The main concept behind these dotfiles, is laziness.  
I want to have everything up & running in no time, and most things to just work automagically in a repeatable way.

- Applications are managed using Homebrew Cask
- Application settings are backed up / synced using Mackup
- Important dotfiles are commited to the repository

The dotfiles are created as a bare repository in `$HOME/.dotfiles` and use `$HOME` as working directory.
This has the advantage that absolutely no symlinks are needed to manage your dotfiles.  
Instead of using the `git` command, you need to manage your dotfiles with a `dot` fish function, that wraps `git` and sets the correct `--work-tree & --git-dir` options. 

_The only drawback is, that only hidden files/dirs should exist in the repo's root, otherwise they would show up in your $HOME folder_

--> Source: <a href="https://www.atlassian.com/git/tutorials/dotfiles" target="_blank">Atlassian</a>


# Day To Day
This is where the fun starts! Since there are no symlinks, you can just work with your dotfiles without having to remember to run an update script for symlinks etc.

The only thing you need to remember, is to use the `dot` function, instead of the `git` command. You can run this from anywhere on your machine also.  

Now all you have to do is to add & push changes, so your dotfiles are always up to date.  

Examples:
```shell
$ dot status

# add something new to your dotfiles
$ dot add ~/.screenrc
$ dot commit -m "added .screenrc"
$ dot push

# add changes to tracked files & push to github
$ dot add .
$ dot commit -m "added updates"
$ dot push
```

## Automation
The following automation is included:
- Brewfile
- Extensions for VS Code
- Mackup backup

The `brew` command is wrapped in a fish function, every time something is installed or uninstalled, a new `Brewfile` is dumped at `~/.config/dotfiles/prefs/Homebrew/Brewfile`.  

Launchd Agents are running to:  
Mackup backup once every day at 10pm.  
Export Virtual Studio Code extensions once per day, at 10pm. 

Launchd agents can be edited, or created at `~/.config/dotfiles/prefs/macos/launchd`.
And then have to be copied to `~/Library/LaunchAgents`. Once there, they are executed automatically when due. (You might have to log out and back in)


# How To Manage Secrets
Anything that is sensitive and used during development in your environment (API Keys etc) should go in the `~/.secrets` file, which is sourced automatically.  

This file is also gitignored just in case, but backed up by Mackup, so it will be restored in a new setup, just not shown publicly on Github.

Secrets can be get/set via macOS keychain, so mackUp won't back them up to Dropbox in plain text format.
```shell
# saves <name> to macOS login keychain, as 'environment_variable' 
$ set_secret <name> <value>
$ get_secret <name>
```

`~/.secrets`:
```shell
set -g -x SOME_API_KEY (get_secret <name>)
```


## Private SSH Keys
Three helper methods are provided to manage SSH keys in AWS Secrets Manager. You can easily back up your private SSH key and then restore it on a new machine, which will also re-generate the public key & set the right permissions. :see_no_evil:
:hear_no_evil:
:speak_no_evil:

```shell
# import a private ssh key into aws secrets manager, save it with a name of <path>
$ aws_import_ssh_key <path> <region>

# export a private key from aws secrets manager, to your machine
# files are created under <path>, permissions set & identity added to ssh-agent
# any existing files of the same name, have .timestamp.old appended as backup.
$ aws_export_ssh_key <path> <region>

# If a private key got compromised, or needs to be rotated
# delete it from AWS secrets manager (Does not delete the files locally)
# by default it deletes keys with a 30 days restore window, use --force to delete without restore.
$ aws_delete_ssh_key <path> <region> [-f --force]
```


# <a name="aws-setup"></a> Set Up AWS-Vault & Config File
Since we use `aws-vault` to manage AWS credentials in a secure way, we never need any credentials in the `~/.aws/credentials` file, by design this should always stay empty.

The only file we need to manage single or multiple AWS ORG accounts via CLI is the `~/.aws/config` file.

## Example AWS Config
Add profiles to `aws-vault`:  
```shell
$ aws-vault add <profile> (master_read_only)
$ enter access key:
$ enter secret key:
```

Then, manually add profiles for account roles along with their Role ARN, and the MFA ARN of your master account user to your `~/.aws/config`:
```config
# read only user
[profile master_read_only]
output=json
region=us-east-1
mfa_serial=arn:aws:iam::XXXXXXXXXXXXX:mfa/myaccount-user

# admin role account 1
[profile account_1_admin]
output=json
region=us-east-1
source_profile=master_read_only
role_arn=arn:aws:iam::XXXXXXXXXXXXX:role/admin

# admin role account 2
[profile account_2_admin]
output=json
region=us-east-1
source_profile=master_read_only
role_arn=arn:aws:iam::YYYYYYYYYYYYY:role/admin
```

