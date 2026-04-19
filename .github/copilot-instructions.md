# Copilot Instructions

## Project Overview

This is a personal dotfiles/provisioning repository. It automates machine setup across macOS (Homebrew) and Linux (apt). The repo is cloned to `$HOME/.$USER-sh` via `bootstrap.sh`.

## Architecture

**Lifecycle directories** — each contains one script per tool/software:
- `install/` — first-time installation (e.g., `install/nvm.sh`)
- `configure/` — configures already-installed software (e.g., `configure/git.sh`)
- `update/` — updates installed software
- `uninstall/` — removal scripts
- `bin/` — utility scripts, added to `$PATH`
- `backup/` — OS-specific backup scripts

**Configuration files** live in `etc/`, organized by tool (e.g., `etc/git/config`, `etc/zsh/zshrc`). Scripts symlink these into the user's home directory.

**Shell initialization chain**: `etc/sh/profile` and `etc/sh/rc.d/` contain fragments sourced by the shell. Install/configure scripts add symlinks into `rc.d/` to wire up tool-specific initialization (e.g., nvm, pyenv, jenv).

**`common.sh`** provides shared utilities: `is_installed()`, `is_os()`, `backup_if_exists()`, `append_if_exists()`. It also sets up an error trap.

## Script Conventions

- **Shebang**: Use `#!/usr/bin/env sh` (POSIX shell). Use `bash` or `zsh` only when required by the script's functionality.
- **Strict mode**: Start scripts with `set -eu`.
- **Source common.sh**: `. "$HOME/.$USER-sh/common.sh"` — all install/configure/update scripts must source this.
- **OS branching pattern**:
  ```sh
  if is_os Darwin; then
      # macOS — use brew
  elif is_os Linux && is_installed apt; then
      # Linux — use apt
  fi
  ```
- **Config deployment**: Back up existing files with `backup_if_exists`, then symlink from `etc/` into the home directory.
- **Shell restart**: Scripts that modify shell config end with `exec $SHELL -l`.
- **Architecture detection**: Use `uname -m` and normalize `aarch64` to `arm64` when needed.

## Platform-Specific Docs

- `MACOS.md` — macOS post-install walkthrough
- `RPI5-server.md` / `RPI5-desktop.md` — Raspberry Pi 5 setup guides
- `KEYCHRON.md` — keyboard configuration
