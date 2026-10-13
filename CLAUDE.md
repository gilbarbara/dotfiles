# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for macOS setup. Manages shell configuration (zsh with oh-my-zsh), development tools, and system preferences via symlinks to `~/.dotfiles`.

## Setup Commands

```bash
# Interactive multi-select menu
./install

# Apply macOS system preferences
./.osx

# Regenerate Brewfile and PNPMfile from the current machine
pnpm run dump
```

## Architecture

### Shell Configuration Flow
`.zshenv` runs for every zsh (including non-interactive scripts):
- Prepends `~/.local/bin` (uv Python, uv tools)

`.zprofile` runs once per login session:
- Homebrew shellenv, fnm, pnpm
- PATH setup (php, go, local bins); re-prepends `~/.local/bin` because macOS `path_helper` demotes the `.zshenv` entry, then `typeset -U` drops the duplicate

`.zshrc` sources files in order (every interactive shell):
1. `.oh-my-zsh-config` - oh-my-zsh setup, theme (`kollectiv`), plugins
2. `.aliases` - Command shortcuts
3. `.exports` - Environment variables (EDITOR, LANG, GPG_TTY), history settings; loads after oh-my-zsh so its values override
4. `.extra` - Private config (not in repo, for secrets/machine-specific settings)
5. `.functions` - Shell functions

### Key Files
- `Brewfile` - Homebrew packages, casks, Mac App Store apps, VS Code extensions
- `PNPMfile` - Global pnpm packages
- `modules/` - Installation scripts for each module
- `files/kollectiv.zsh-theme` - Custom oh-my-zsh theme
- `claude/` - Claude Code config; each entry symlinked into `~/.claude/` (`claude/CLAUDE.md` is the global user instructions file)
- `.config/` - App configs; each entry symlinked into `~/.config/`
- `.git-hooks/` - Global git hooks (`core.hooksPath` in `.gitconfig`)
- `bin/` - Helper scripts; the `tools` module copies `chmodr`, `colors`, `create-certificate`, `service` into Homebrew's bin, `pnpmdump.js` writes `PNPMfile` for `pnpm run dump`
- `utils/` - Installer helpers, help text, menu

### Package Managers
- **fnm** for Node.js versions (`/usr/local/fnm`)
- **pnpm** for global npm packages (`/usr/local/pnpm`)
- **uv** for Python versions and packages

### Useful Aliases (defined in `.aliases`)
- `reload` - Source `.zshrc`
- Git: `g`, `gs` (status), `gl` (log graph), `gr` (cd to repo root)
- npm scripts: `dev`, `build`, `lint`, `typecheck`, `validate`, `t` (test), `tc` (test:coverage)
- File listing uses `eza`: `l`, `la`, `lsd`, `lt`

### Useful Functions (defined in `.functions`)
- `p` - auto-detects package manager (bun/pnpm/yarn/npm) from lockfile
- `md` - mkdir + cd
- `tree [level]` - eza tree view
- `extract` - Universal archive extractor
