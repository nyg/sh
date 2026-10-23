#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

lima_config_dir="${COLIMA_HOME:-$XDG_CONFIG_HOME/colima}/_lima/_config"
backup_if_exists "$lima_config_dir/override.yaml"

echo Linking Lima override for Colima…
mkdir -p "$lima_config_dir"
ln -s "$HOME/.$USER-sh/etc/colima/lima-override.yaml" "$lima_config_dir/override.yaml"

echo Done!
