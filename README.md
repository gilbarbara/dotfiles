# Gil's dotfiles & setup

Personal dotfiles for macOS. Zsh with oh-my-zsh, managed via symlinks to `~/.dotfiles`.

Inspired by [Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles/), [Paul Irish's dotfiles](https://github.com/paulirish/dotfiles), and [Raúl Uranga's powerbook](https://github.com/rauluranga/powerbook).

## Installation

```bash
git clone https://github.com/gilbarbara/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./setup.sh
```

Install individual modules:
```bash
./setup.sh module_name
```

Modules: `brew`, `dotfiles`, `npm`, `oh_my_zsh`, `rubygems`, `structure`, `tools`

## Private config

Put machine-specific or secret config in `~/.extra` (not tracked in git).

## macOS defaults

Set sensible macOS defaults on a fresh machine:
```bash
./.osx
```

## Key files

| File | Purpose |
|------|---------|
| `Brewfile` | Homebrew packages, casks, Mac App Store apps |
| `NPMfile` | Global npm packages |
| `.zprofile` | Login shell setup (PATH, env vars) |
| `.zshrc` | Interactive shell (sources other configs) |
| `.oh-my-zsh-config` | Oh-my-zsh theme and plugins |
| `.aliases` | Command shortcuts |
| `.functions` | Shell functions |
| `.exports` | Environment variables |
| `.extra` | Private config (not in repo) |

## GPG setup

Add to `~/.gnupg/gpg-agent.conf`:
```bash
pinentry-program $(brew --prefix)/bin/pinentry-mac
```
