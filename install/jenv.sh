#!/usr/bin/env bash
# jEnv files generated for bash are not sh-compatible.
# https://whichjdk.com/ -> Adoptium Temurin by Eclipse (formerly AdoptOpenJdk)
# https://adoptium.net/installation/linux

set -eu

. "$HOME/.$USER-sh/common.sh"

export JENV_ROOT="$HOME/.config/jenv"

init_jenv() {
    eval "$(jenv init - $(basename $SHELL))"
}

enable_export_plugin() {
    # keeps JAVA_HOME up-to-date
    jenv enable-plugin export
}

if is_os Darwin
then
    echo Installing jenv…
    brew install jenv

    init_jenv
    enable_export_plugin

    echo Installing Java 8 \& 17…
    brew tap homebrew/cask-versions
    brew install --cask temurin8 temurin17

    echo Finding installed versions with /usr/libexec/java_home…
    /usr/libexec/java_home -X > /tmp/jvm.plist
    i=0
    while :
    do
        jvm_path=$(/usr/libexec/PlistBuddy -c "print :$i:JVMHomePath" /tmp/jvm.plist 2>/dev/null || echo end)
        [ "$jvm_path" = "end" ] && break

        echo Adding $jvm_path to jenv…
        jenv add "$jvm_path"
        i=$((i+1))
    done

    jenv rehash

elif is_os Linux
then
    echo Cloning jenv to ${JENV_ROOT}…
    git clone https://github.com/jenv/jenv.git "$JENV_ROOT"

    PATH="$PATH:$JENV_ROOT/bin"
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
    echo Could not install jenv >&2
    exit 1
fi

echo Try setting global version to Java 17…
jenv global 17 || echo Could not set global version to 17

echo Linking jenv configuration files…
ln -s "$HOME/.$USER-sh/etc/jenv/profile" "$HOME/.$USER-sh/etc/sh/profile.d/jenv.sh"
ln -s "$HOME/.$USER-sh/etc/jenv/rc" "$HOME/.$USER-sh/etc/sh/rc.d/jenv.sh"

echo Done! Check everything is ok with \'jenv doctor\'.
exec $SHELL -l
