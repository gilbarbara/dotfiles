# Gil's dotfiles & setup

[Mathias's readme](https://github.com/mathiasbynens/dotfiles/) is awesome. go read it.

This is a mashup between [Paul Irish's dotfiles](https://github.com/paulirish/dotfiles) and [Raúl Uranga's powerbook](https://github.com/rauluranga/powerbook)

## install the necessary apps

The basic setup is deployed in `install.sh` which adds a ton of stuff: homebrew (node, php, mongo, mysql), cask, rvm, npm global packages, z, etc.

## private config

Toss it into a file called `.extra` which you do not commit to this repo and just keep in your `~/`


```shell
## PATH like a bawss
PATH=/opt/local/bin
PATH=$PATH:/opt/local/sbin
PATH=$PATH:/bin
PATH=$PATH:~/.rvm/bin
PATH=$PATH:~/code/git-friendly
# ...

export PATH
```

## Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

## Overview of files

####  Automatic config
* `.vimrc`, `.vim` - vim config, obv.
* `.ackrc`
* `.editorconfig`
* `.jshintrc`

#### shell environment
* `.aliases`
* `.bash_profile`
* `.bash_prompt`
* `.bashrc`
* `.exports`
* `.functions`
* `.extra` - not included, explained above

#### manual run
* `install.sh` - apps i need installed
* `.osx` - run on a fresh osx machine

#### git
* `.gitattributes`
* `.gitconfig`
* `.gitignore`

* `.inputrc` - config for bash readline


## Installation

```bash
git clone https://github.com/gilbarbara/dotfiles.git && cd dotfiles && ./install.sh
```

Also you can install the modules individually
```bash
./install.sh module_name
```

Modules: apps, brew, dotfiles, fonts, npm, quicklook, ruby and sublime

To update later on, just run the install again.
