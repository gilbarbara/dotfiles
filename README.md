# Gil's dotfiles & setup

Personal dotfiles for macOS. Zsh with oh-my-zsh, managed via symlinks to `~/.dotfiles`.

Inspired by [Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles/), [Paul Irish's dotfiles](https://github.com/paulirish/dotfiles), and [Raúl Uranga's powerbook](https://github.com/rauluranga/powerbook).

## Installation

```bash
git clone https://github.com/gilbarbara/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install
```

Launches an interactive multi-select menu to choose which modules to install.

Modules: `brew`, `claude`, `dotfiles`, `pnpm`, `oh_my_zsh`, `structure`, `tools`

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
| `Brewfile` | Homebrew packages, casks, Mac App Store apps, VS Code extensions |
| `PNPMfile` | Global pnpm packages |
| `claude/` | Claude Code config (symlinked into `~/.claude`) |
| `.zshenv` | Every zsh, including scripts (`~/.local/bin` on PATH) |
| `.zprofile` | Login shell setup (PATH, env vars) |
| `.zshrc` | Interactive shell (sources other configs) |
| `.oh-my-zsh-config` | Oh-my-zsh theme and plugins |
| `.aliases` | Command shortcuts |
| `.functions` | Shell functions |
| `.exports` | Environment variables |
| `.extra` | Private config (not in repo) |

## Updating package lists

Regenerate `Brewfile` and `PNPMfile` from the current machine:
```bash
pnpm run dump
```

## GPG setup

Set the pinentry program:
```bash
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
```
