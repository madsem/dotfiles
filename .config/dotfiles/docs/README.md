# . files :fireworks:
My dotfiles to set up, install &amp; manage everything I need on a new mac (or an old one if I broke it).

Feel free to clone it, use it, take it apart or change it to your liking. I use this for my own setup, but tried to build it all in a way so it can easily be re-used or adjusted by someone else. I can't guarantee that it will just work with your setup, so please don't run this blindly on your brand-new mac but instead fork it and adjust everything to your needs.

# Install:
**For moving existing dotfiles to a new machine - Make sure that:**
- [ ] Mackup's latest iCloud backup contains everything.
- [ ] Local Keychains were moved to the new machine.
- [ ] Everything important is in iCloud

First, use the remote install script, which automatically takes care of installing `git` & cloning the repo as a bare repository to `~/.dotfiles`, then rsync to sync existing files in your `$HOME` directory with the dotfiles, and then does a `git checkout`.  
```shell
$ bash -c "`curl -fsSL https://raw.githubusercontent.com/madsem/dotfiles/master/.config/dotfiles/init/remote-install.sh`"
```

Now run the setup & restore mackup's backup:  
```shell
$ ~/.dotfiles/.init/setup
$ mackup restore
```

Now configure `aws-vault` & your `~/.aws/config` - [AWS Setup](#aws-setup)  
Then export your SSH keys from AWS Secrets Manager, to your machine:
```shell
$ aws profile <your_admin_role>
$ aws_export_ssh_key <name> <region>
```

If things went as planned, you should have everything the way you had it on your old mac! Or alternatively, a totally broken machine :D

### Further Set Up:
-
-


# Important Files & Directories
...


# Concept
The main concept behind these dotfiles, is laziness.  
I want to have everything up & running in no time, and most things to just work automagically in a repeatable way.

- Applications are managed using Homebrew Cask
- Application settings are backed up / synced using Mackup
- Important dotfiles are commited to the repository

The dotfiles are created as a bare repository in `$HOME/.dotfiles` and use `$HOME` as working directory.
This has the advantage that absolutely no symlink or rsync management is needed to manage your dotfiles, you can manage your dotfiles through an `alias` to add & push any config file under your `$HOME` dir to make it part of your dotfiles. 

_The only drawback is, that only hidden files/dirs should exist in the repo's root, otherwise they would show up in your $HOME folder_

--> Source: <a href="https://www.atlassian.com/git/tutorials/dotfiles" target="_blank">Atlassian</a>

How the system should look like once the `~/.dotfiles/setup` completed:
- Everything from the Brewfile was installed
- a local NGINX/PHP/Redis server with all the bells & whistles is running
- Laravel Valet is running to make things easy for me.
- a Vagrant VM with my own personal Homestead version is on stand-by, for whenever I need that.
- Fish Shell is the default shell (and I don't need another, I'm faithful)
- AWS CLI is fully integrated with auto-completion, and all interactions are secure without using any plain text keys.


# Day To Day
This is where the fun starts! Since there are no symlinks, you can just work with your dotfiles without having to remember to run an update script for symlinks etc.

The only thing you need to remember, is to use the alias `dotfiles`, instead of the `git` command. You can run this from anywhere on your machine also.

For example, to add something to your dotfiles, simply do this: 
```shell
$ dotfiles status
$ dotfiles add ~/.screenrc
$ dotfiles commit -m "added .screenrc"
$ dotfiles add ~/.config/something/
$ dotfiles commit -m "added something"
$ dotfiles push

# whenever new files / applications were added to mackup:
$ mackup backup
```

# How To Manage Secrets
Anything that is sensitive and used during development in your environment (API Keys etc) should go in the `~/.secrets` file, which is sourced automatically.  

This file is also gitignored just in case, but backed up by Mackup, so it will be restored in a new setup, just not shown publicly on Github.

Secrets can be get/set via macOS keychain, so mackUp won't back them up to iCloud in plain text format.
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
Three helper methods are provided to manage SSH keys in AWS Secrets Manager. You can easily back up your private SSH key and then restore it on a new machine, which will also re-generate the public key as well as set the right permissions. :see_no_evil:
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
$ aws_delete_ssh_key <path> <region>
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
source_profile=master_read_only
role_arn=arn:aws:iam::XXXXXXXXXXXXX:role/admin

# admin role account 2
[profile account_2_admin]
source_profile=master_read_only
role_arn=arn:aws:iam::YYYYYYYYYYYYY:role/admin
```


# Confessions
People I've stolen parts of their dotfiles, and then, shamelessly included those parts into mine:  
- [Holman's Dotfiles](https://github.com/holman/dotfiles) (snuck in through the backdoor, and stole a bunch of code)
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) (stole sudo timestamp script, as well as the .macos file, all in broad daylight)
- [Webpro's Dotfiles](https://github.com/webpro/dotfiles) (Grabbed this juicy remote-install script, was like taking candy from a baby)
