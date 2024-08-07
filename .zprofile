if type /opt/homebrew/bin/brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# init fnm
export FNM_DIR=/usr/local/fnm
eval "$(fnm env)"

# pnpm
export PNPM_HOME="/usr/local/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

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

export GOPATH="$HOME/Documents/Go"

PATH="./node_modules/.bin:$PATH"
PATH="$PHP_PATH:$PATH"
PATH="$RUBY_PATH:$PATH"
PATH="$GEM_PATH:$PATH"
PATH="$GOPATH:$PATH"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
