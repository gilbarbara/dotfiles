# Gil's dotfiles & setup

[Mathias's readme](https://github.com/mathiasbynens/dotfiles/) is awesome. go read it.

This is a mashup between [Paul Irish's dotfiles](https://github.com/paulirish/dotfiles) and [Raúl Uranga's powerbook](https://github.com/rauluranga/powerbook).
This repo is mostly for me but you're welcome to make suggestions. Fork it!

## install the necessary apps

The basic setup is executed in `install.sh` which adds a ton of stuff: [brew](https://github.com/gilbarbara/dotfiles/blob/master/lib/brew) (node, php, mongo, mysql, python, ruby), [cask](https://github.com/gilbarbara/dotfiles/blob/master/lib/apps) and some [gems](https://github.com/gilbarbara/dotfiles/blob/master/lib/rubygems), [npm global packages](https://github.com/gilbarbara/dotfiles/blob/master/lib/npm) and more.

## private config

Toss it into a file called `.extra` which you do not commit to this repo and just keep in your `~/`

```shell
## PATH like a boss
PATH=/opt/local/bin
PATH=$PATH:/opt/local/sbin
PATH=$PATH:/bin
PATH=$PATH:~/.rvm/bin
...

export PATH
```

## Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

## Overview of dotfiles

####  Automatic config
* `.vimrc`, `.vim` - vim config, obv.
* `.ackrc`
* `.editorconfig`
* `.jshintrc`
* `.jscsrc`

#### shell environment
* `.aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.exports`
* `.functions`
* `.extra` - not included, explained above

#### manual run
* `setup.sh` - apps I need
* `.osx` - run on a fresh osx machine

#### git
* `.gitattributes`
* `.gitconfig`
* `.gitignore`

* `.inputrc` - config for bash readline

## Installation

```bash
git clone https://github.com/gilbarbara/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./setup.sh
```

Also you can install the modules individually
```bash
./setup.sh module_name
```

Modules: apps, brew, dotfiles, fonts, npm, quicklook and rubygems

To update later on, just run the install again.

## Configure GPG

Set your pinentry program by adding it to `~/.gnupg/gpg-agent.conf`

```bash
pinentry-program $(brew --prefix)/bin/pinentry-mac
```

## Changing ulimit on Mac OS X 10.12 and up 

```bash
sudo /usr/libexec/PlistBuddy /Library/LaunchAgents/com.launchd.maxfiles.plist \
-c "add Label string com.launchd.maxfiles" \
-c "add ProgramArguments array" \
-c "add ProgramArguments: string launchctl" \
-c "add ProgramArguments: string limit" \
-c "add ProgramArguments: string maxfiles" \
-c "add ProgramArguments: string 20000" \
-c "add ProgramArguments: string unlimited" \
-c "add RunAtLoad bool true"

sudo /usr/libexec/PlistBuddy /Library/LaunchAgents/com.launchd.maxproc.plist \
-c "add Label string com.launchd.maxproc" \
-c "add ProgramArguments array" \
-c "add ProgramArguments: string launchctl" \
-c "add ProgramArguments: string limit" \
-c "add ProgramArguments: string maxproc" \
-c "add ProgramArguments: string 2048" \
-c "add ProgramArguments: string unlimited" \
-c "add RunAtLoad bool true"
```

