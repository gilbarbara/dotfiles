# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{bash_colors,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

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

# init nvm
export NVM_DIR=/usr/local/nvm
export NVM_SYMLINK_CURRENT=true
source $(brew --prefix nvm)/nvm.sh

# Ruby paths
export GEM_HOME="$(brew --prefix)/opt/gems"
export GEM_PATH="$GEM_HOME/bin"

# PHP path
export PHP_PATH="$(brew --prefix)/opt/php@7.1/bin"

# init brew
PATH="./node_modules/.bin:$PATH"
PATH="$(brew --prefix)/sbin:$PATH"
PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
PATH="$PHP_PATH:$PATH"
PATH="$GEM_PATH:$PATH"

if hash fasd 2>/dev/null; then
	eval "$(fasd --init auto)"
	_fasd_bash_hook_cmd_complete sb
fi

eval $(thefuck --alias)

eval "$(hub alias -s)"

if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
	. $(brew --prefix)/share/bash-completion/bash_completion
fi

eval "$(gulp --completion=bash)"

# travis
[ -f /Users/gilbarbara/.travis/travis.sh ] && source /Users/gilbarbara/.travis/travis.sh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
