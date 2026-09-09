# AGENTS.md

Personal dotfiles and machine provisioning repository, cloned to `$HOME/.$USER-sh` by `bootstrap.sh`. Targets macOS (brew), Linux (apt) and, occasionally, OpenBSD.

## Layout

* `common.sh` shared helpers: `is_installed`, `is_os`, `backup_if_exists`, `append_if_exists`,
* `install`, `configure`, `update`, `uninstall` one script per software,
* `etc` configuration files, one directory per software, symlinked into `$HOME` or the XDG directories,
* `bin` utility scripts, added to the path,
* `backup` backup scripts for specific OSes,
* root markdown files, per-machine setup walkthroughs.

## Shell initialization

* `etc/sh/profile` login shells, environment only, linked as `$HOME/.profile` and sourced by `etc/zsh/zprofile`,
* `etc/sh/profile.d/*` sourced by the profile, numbered, mainly path entries,
* `etc/sh/rc.d/*` sourced by interactive shells, bash skips the `zsh*` files,
* `etc/bash/bashrc`, `etc/zsh/zshrc` interactive configuration of each shell.

Install scripts wire a software into the shell by symlinking `etc/<software>/rc` to `etc/sh/rc.d/<software>.sh`, and `etc/<software>/profile` to `etc/sh/profile.d/<software>.sh` when the software also needs to be reachable outside an interactive shell.

Version managers are split along that line: the `profile` half exports the root variable and puts the shims on the path, so hooks, launchd jobs and GUI applications resolve the right `python`, `java` or `node`, while the `rc` half runs `init` for the shell function and completions. `nvm` has no shims of its own, so `etc/nvm/shims` provides wrappers resolving its `default` alias.

Everything under `etc/sh` must be POSIX and work in dash, bash and zsh, as all three source it, and `configure/xdg.sh` sources the profile under `set -eu`. Shell specific syntax belongs in `etc/bash` or `etc/zsh`.

## Script conventions

* `#!/usr/bin/env sh`, then `set -eu`, then `. "$HOME/.$USER-sh/common.sh"`,
* a `bash` or `zsh` shebang only when the script needs their syntax,
* branch on the OS with `is_os Darwin` or `is_os Linux && is_installed apt`,
* call `backup_if_exists` before symlinking over an existing file,
* end with `exec $SHELL -l` when the shell configuration changed,
* detect the architecture with `uname -m`, handling both `aarch64` and `arm64`.

## XDG base directories

The profile exports the base directories with a `${VAR:-default}` fallback so that an inherited value is never overridden, then the per software variables, alphabetically. Creating directories belongs in `configure/xdg.sh`, not in the profile, and is only needed for softwares which do not create their own.

macOS GUI applications inherit their environment from launchd rather than from the profile, so these variables only reach softwares started from a terminal.

## Checks

```sh
sh -n etc/sh/profile
dash -eu -c '. ./etc/sh/profile'
zsh -n etc/zsh/zshrc
```

## Commits

Short imperative subject, no prefix. A body only when the reason is not obvious, explaining why rather than what. Never hard-wrap.
