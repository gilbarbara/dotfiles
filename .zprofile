if type /opt/homebrew/bin/brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# init fnm
export FNM_DIR=/usr/local/fnm
eval "$(fnm env)"

### Paths

# Cache brew prefix (avoid multiple subshell calls)
BREW_PREFIX="$(brew --prefix)"

# Brew completions (FPATH must be set before oh-my-zsh runs compinit)
FPATH="$BREW_PREFIX/share/zsh/site-functions:${FPATH}"

# pnpm
export PNPM_HOME="/usr/local/pnpm"

# PHP path
export PHP_PATH="$BREW_PREFIX/opt/php@7.4/bin"

export GO_PATH="$HOME/Documents/Go"
export LOCAL_PATH="$HOME/.local/bin"
export LOCAL_NODE_PATH="./node_modules/.bin"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

PATH="$LOCAL_PATH:$LOCAL_NODE_PATH:$PNPM_HOME/bin:$GO_PATH:$PHP_PATH:$PATH"

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/gilbarbara/.docker/bin"
# End of Docker Desktop section.

# .zshenv adds ~/.local/bin, /etc/zprofile path_helper demotes it, $LOCAL_PATH above re-prepends it; keep first only
typeset -U path PATH
