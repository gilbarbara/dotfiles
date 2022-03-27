# Fig pre block. Keep at the top of this file.
export PATH="${PATH}:${HOME}/.local/bin"
eval "$(fig init zsh pre)"

# pyenv
eval "$(pyenv init --path)"

# Fig post block. Keep at the bottom of this file.
eval "$(fig init zsh post)"

# init Volta
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"

