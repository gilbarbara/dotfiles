# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"

# init fnm
export FNM_DIR=/usr/local/fnm
eval "$(fnm env)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### Paths

# Ruby paths
export RUBY_PATH="$(brew --prefix)/opt/ruby/bin"
export GEM_HOME="$(brew --prefix)/opt/gems"
export GEM_PATH="$GEM_HOME/bin"

# PHP path
# export PHP_PATH="$(brew --prefix)/opt/php/bin"
export PHP_PATH="$(brew --prefix)/opt/php@7.4/bin"

export GOPATH="/Users/gilbarbara/Documents/Go"

PATH="./node_modules/.bin:$PATH"
PATH="$(brew --prefix)/sbin:$PATH"
# PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
PATH="$PHP_PATH:$PATH"
PATH="$RUBY_PATH:$PATH"
PATH="$GEM_PATH:$PATH"
PATH="$GOPATH:$PATH"
# Volta paths
# export VOLTA_HOME="$HOME/.volta"
# PATH="$VOLTA_HOME/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
