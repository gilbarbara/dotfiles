# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{bash_colors,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

if hash fasd 2>/dev/null; then
	eval "$(fasd --init auto)"
	_fasd_bash_hook_cmd_complete sb
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# init rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# init nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# init brew
PATH=/usr/local/sbin:$PATH
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

eval "$(hub alias -s)"

eval "$(gulp --completion=bash)"

if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
	. $(brew --prefix)/share/bash-completion/bash_completion
fi

# added by travis gem
[ -f /Users/gilbarbara/.travis/travis.sh ] && source /Users/gilbarbara/.travis/travis.sh
