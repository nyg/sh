#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

init_jenv() {
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init - $(basename $SHELL))"
}

enable_export_plugin() {
    # keeps JAVA_HOME up-to-date
    jenv enable-plugin export
}

link_config() {
    echo Linking jenv.sh to config/sh/jenv.sh…
    mkdir -p "$HOME/.$USER-sh/config/sh"
    ln -s "$HOME/.$USER-sh/config/jenv.sh" "$HOME/.$USER-sh/config/sh/jenv.sh"
}

if is_os Darwin
then
    echo Installing jenv…
    brew install jenv

    init_jenv
    enable_export_plugin

    echo Installing latest Java version…
    brew install --cask temurin

    echo Installing Java 8…
    brew tap homebrew/cask-versions
    brew install --cask temurin8

    echo Adding installed Java versions to jenv…
    /usr/libexec/java_home -X > /tmp/jvm.plist
    i=0
    while :
    do
        jvm_path=$(/usr/libexec/PlistBuddy -c "print :$i:JVMHomePath" /tmp/jvm.plist 2>/dev/null)
        [ $? -ne 0 ] && break

        jenv add "$jvm_path"
        i=$((i+1))
    done

    link_config

elif is_os Linux
then
    echo Cloning jenv to ~/.jenv…
    git clone https://github.com/jenv/jenv.git ~/.jenv

    init_jenv
    enable_export_plugin
    link_config

else
    echo Unknown OS, aborting… >&2
    exit 1
fi

jenv doctor
echo Done!
