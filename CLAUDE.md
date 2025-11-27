# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for macOS setup. Manages shell configuration (zsh with oh-my-zsh), development tools, and system preferences via symlinks to `~/.dotfiles`.

## Setup Commands

```bash
# Full installation (interactive, prompts for each step)
./setup.sh

# Install individual modules
./setup.sh brew       # Homebrew packages (uses Brewfile)
./setup.sh dotfiles   # Symlink dotfiles to home directory
./setup.sh npm        # Global npm packages (uses NPMfile)
./setup.sh oh_my_zsh  # Oh-my-zsh with plugins/themes
./setup.sh rubygems   # Ruby gems
./setup.sh structure  # Create ~/code, ~/repos, etc. directories
./setup.sh tools      # Additional tools

# Apply macOS system preferences
./.osx
```

## Architecture

### Shell Configuration Flow
`.zprofile` runs once per login session:
- Homebrew shellenv, fnm, pnpm
- PATH setup (ruby, php, go, local bins)

`.zshrc` sources files in order (every interactive shell):
1. `.oh-my-zsh-config` - oh-my-zsh setup, theme (`kollectiv`), plugins
2. `.exports` - Environment variables (EDITOR, LANG, GPG_TTY)
3. `.aliases` - Command shortcuts
4. `.functions` - Shell functions
5. `.extra` - Private config (not in repo, for secrets/machine-specific settings)

### Key Files
- `Brewfile` - Homebrew packages, casks, Mac App Store apps, VS Code extensions
- `NPMfile` - Global npm packages (installed via pnpm)
- `lib/` - Installation scripts for each module
- `files/kollectiv.zsh-theme` - Custom oh-my-zsh theme

### Package Managers
- **fnm** for Node.js versions (`/usr/local/fnm`)
- **pnpm** for global npm packages (`/usr/local/pnpm`)
- **uv** for Python versions and packages
- **rbenv** for Ruby versions

### Useful Aliases (defined in `.aliases`)
- `p` function auto-detects package manager (bun/pnpm/yarn/npm) from lockfile
- `reload` - Source `.zshrc`
- Git: `g`, `gs` (status), `gl` (log graph), `gr` (cd to repo root)
- npm scripts: `dev`, `build`, `lint`, `typecheck`, `validate`, `t` (test), `tc` (test:coverage)
- File listing uses `eza`: `l`, `la`, `lsd`, `lt`

### Useful Functions (defined in `.functions`)
- `md` - mkdir + cd
- `tree [level]` - eza tree view
- `extract` - Universal archive extractor
- `check_ports` - Check if common dev ports are in use
