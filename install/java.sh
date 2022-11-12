#!/usr/bin/env bash
# jEnv files generated for bash are not sh-compatible.
# https://whichjdk.com/ -> Adoptium Temurin by Eclipse (formerly AdoptOpenJdk)
# https://adoptium.net/installation/linux

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
    echo Linking jenv/init.sh and jenv/path.sh…
    ln -s "$HOME/.$USER-sh/etc/jenv/init.sh" "$HOME/.$USER-sh/etc/sh/jenv.sh"
    ln -s "$HOME/.$USER-sh/etc/jenv/path.sh" "$HOME/.$USER-sh/etc/path/jenv.sh"
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

    jenv rehash

elif is_os Linux
then
    echo Cloning jenv to ~/.jenv…
    git clone https://github.com/jenv/jenv.git ~/.jenv

    init_jenv
    enable_export_plugin

    read -p "Install Adoptium JDK 8 and 17? (y/n) " confirm
    if [ $confirm = y ]
    then
        echo Downloading Adoptium GPG key…
        sudo mkdir -p /etc/apt/keyrings
        wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public \
            | sudo tee /etc/apt/keyrings/adoptium.asc

        echo Configuring Adoptium apt repository…
        echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" \
            | sudo tee /etc/apt/sources.list.d/adoptium.list

        echo Installing Java 8 \& 17…
        sudo apt update
        sudo apt install -y apt-transport-https temurin-8-jdk temurin-17-jdk

        if is_installed update-alternatives
        then
            echo Removing alternatives for java…
            sudo update-alternatives --remove-all java || echo No java alternatives removed
        fi

        echo Adding JDKs to jenv…
        jenv add /usr/lib/jvm/temurin-8-jdk-amd64/
        jenv add /usr/lib/jvm/temurin-17-jdk-amd64/
        jenv rehash
    fi

else
    echo Unknown OS, aborting… >&2
    exit 1
fi

echo 17 > "$HOME/.jenv/version"
link_config

echo Done! Check everything is ok with \'jenv doctor\'.
exec $SHELL -l
