#!/usr/bin/env zsh

libs=(brew dotfiles npm rubygems tools)

# Help text
source ./lib/help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    run_help
    exit
fi

source ./lib/utils
# Source the necessary files and helper scripts
for i in "${libs[@]}"; do
    source ./lib/"$i"
done

if ! type_exists gcc; then
	echo "GCC is missing"
fi

if array_contains "$1" "${libs[@]}"; then
    seek_confirmation "Do you want to install $1"

    if is_confirmed; then
        run_"$1"
    fi

  	source "$HOME/.zshrc"
    exit
else
  seek_confirmation "Do you want to proceed with the installation"

  if ! is_confirmed; then
    exit
  fi
fi

echo "Authentication required..."

sudo -v

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ln -s "$HOME/.dotfiles/files/kollectiv.zsh-theme" ~/.oh-my-zsh/themes/kollectiv.zsh-theme
fi

#        __      __  _____ __
#   ____/ /___  / /_/ __(_) /__  _____
#  / __  / __ \/ __/ /_/ / / _ \/ ___/
# / /_/ / /_/ / /_/ __/ / /  __(__  )
# \__,_/\____/\__/_/ /_/_/\___/____/

# Ask before potentially overwriting files
seek_confirmation "Overwrite your existing dotfiles"

if is_confirmed; then
    # Symlink all necessary files

    run_dotfiles

    e_success "All files have been symlinked"

else
    e_error "This step is required. When you're ready, run this script to start up again"
    exit 1
fi

#           __                  __
#     _____/ /________  _______/ /___  __________
#    / ___/ __/ ___/ / / / ___/ __/ / / / ___/ _ \
#   (__  ) /_/ /  / /_/ / /__/ /_/ /_/ / /  /  __/
#  /____/\__/_/   \__,_/\___/\__/\__,_/_/   \___/

mkdir -p "$HOME/code"
mkdir -p "$HOME/demos"
mkdir -p "$HOME/forks"
mkdir -p "$HOME/packages"
mkdir -p "$HOME/repos"
mkdir -p "$HOME/works"

sudo mkdir -p /usr/local/pnpm
sudo chown -R $(whoami) /usr/local/pnpm

sudo mkdir -p /usr/local/fnm
sudo chown -R $(whoami) /usr/local/fnm

# Before relying on Homebrew, check that packages can be compiled
if ! type_exists 'gcc'; then
    e_error "The XCode Command Line Tools must be installed first."
    printf "  run 'xcode-select --install' and follow the instrucctions\n"
    printf "  Then run this setup script again.\n"
    exit 1
fi

#     __  __                     __
#    / / / /___  ____ ___  ___  / /_  ________ _      __
#   / /_/ / __ \/ __ `__ \/ _ \/ __ \/ ___/ _ \ | /| / /
#  / __  / /_/ / / / / / /  __/ /_/ / /  /  __/ |/ |/ /
# /_/ /_/\____/_/ /_/ /_/\___/_.___/_/   \___/|__/|__/

if ! type_exists 'brew'; then
    e_process "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

e_process "Installing Homebrew packages"
run_brew

#     ____        __
#    / __ \__  __/ /_  __  __
#   / /_/ / / / / __ \/ / / /
#  / _, _/ /_/ / /_/ / /_/ /
# /_/ |_|\__,_/_.___/\__, /
#                   /____/

e_process "Installing Ruby gems"
run_rubygems

#     _   ______  __  ___
#    / | / / __ \/  |/  /
#   /  |/ / /_/ / /|_/ /
#  / /|  / ____/ /  / /
# /_/ |_/_/   /_/  /_/
#

e_process "Installing NPM packages"
run_npm

#    ______            __
#   /_  __/___  ____  / /____
#    / / / __ \/ __ \/ / ___/
#   / / / /_/ / /_/ / (__  )
#  /_/  \____/\____/_/____/
#

e_process "Installing Tools"
run_tools

e_success "Your Mac is ready to rock!"

exec zsh -l
