#!/usr/bin/env sh

current_version=$(python -V | cut -f2 -d' ')
# TODO: sed -E 's/.*([0-9]+)\.[0-9]+\..*/\1/' for macOS
current_maj_version=$(python -V | sed 's/.*\([0-9]\+\)\.[0-9]\+\..*/\1/')
latest_version=$(pyenv install -l | grep -P "^\s*$current_maj_version\.\d*\.\d*$" | tail -1 | sed 's/ *//')

echo "Current version:        $current_version"
echo "Major version detected: $current_maj_version"
echo "Upgrading to version    $latest_version"

read -p "Press any key to confirm" confirm

echo Generating list of installed packages for version ${current_version}…
pip freeze > /tmp/requirements-${current_version}.txt

echo Installing version $latest_version…
pyenv install $latest_version
pyenv global $current_maj_version

echo Installing packages from previous version…
pip install -r /tmp/requirements-${current_version}.txt
