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

### Paths

# Cache brew prefix (avoid multiple subshell calls)
BREW_PREFIX="$(brew --prefix)"

# Brew completions (FPATH must be set before oh-my-zsh runs compinit)
FPATH="$BREW_PREFIX/share/zsh/site-functions:${FPATH}"

# Ruby paths
export RUBY_PATH="$BREW_PREFIX/opt/ruby/bin"
export GEM_HOME="$BREW_PREFIX/opt/gems"
export GEM_PATH="$GEM_HOME/bin"

# PHP path
export PHP_PATH="$BREW_PREFIX/opt/php@7.4/bin"

export GO_PATH="$HOME/Documents/Go"
export LOCAL_PATH="$HOME/.local/bin"
export LOCAL_NODE_PATH="./node_modules/.bin"

PATH="$LOCAL_PATH:$LOCAL_NODE_PATH:$GO_PATH:$GEM_PATH:$RUBY_PATH:$PHP_PATH:$PATH"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
