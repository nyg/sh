#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux && is_installed apt
then
    gitdeck_dir="$HOME/.local/opt/gitdeck"
    env_file="$XDG_CONFIG_HOME/gitdeck/env"
    unit_file="$XDG_CONFIG_HOME/systemd/user/gitdeck.service"

    if ! is_installed pnpm
    then
        echo pnpm not found, install it first >&2
        exit 1
    fi

    node_bin=$(command -v node || true)

    if [ -z "$node_bin" ]
    then
        echo Node.js not found in PATH, install it first >&2
        exit 1
    fi

    node_major=$("$node_bin" -p 'process.versions.node.split(".")[0]')

    if [ "$node_major" -lt 22 ]
    then
        echo Node.js 22 or later required, found "$("$node_bin" -v)" >&2
        exit 1
    fi

    if [ ! -d "$gitdeck_dir" ]
    then
        echo Cloning gitdeck into "$gitdeck_dir"…
        mkdir -p "$(dirname "$gitdeck_dir")"
        git clone https://github.com/debba/gitdeck.git "$gitdeck_dir"
    fi

    echo Building gitdeck…
    (cd "$gitdeck_dir"; pnpm install --frozen-lockfile; pnpm run build)

    echo Creating directories…
    mkdir -p "$XDG_CONFIG_HOME/gitdeck" \
             "$XDG_CONFIG_HOME/systemd/user" \
             "$HOME/.gitdeck"

    if [ ! -f "$env_file" ]
    then
        echo Creating "$env_file"…
        cp "$HOME/.$USER-sh/etc/gitdeck/env.example" "$env_file"
    fi

    chmod 600 "$env_file"

    echo Linking service file…
    backup_if_exists "$unit_file"
    ln -s "$HOME/.$USER-sh/etc/gitdeck/gitdeck.service" "$unit_file"

    echo Enabling lingering so the service survives logout…
    sudo loginctl enable-linger "$USER"

    echo Enabling gitdeck.service…
    systemctl --user daemon-reload
    systemctl --user enable --now gitdeck.service
    systemctl --user --no-pager status gitdeck.service

    echo Done! Set GITHUB_TOKEN in "$env_file" then run: systemctl --user restart gitdeck
else
    echo Unsupported OS >&2
    exit 1
fi
