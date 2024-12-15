#!/usr/bin/env bash
# https://whichjdk.com/ -> Adoptium Temurin by Eclipse (formerly AdoptOpenJdk)
# https://adoptium.net/installation/linux

set -eu

. "$HOME/.$USER-sh/common.sh"

export JENV_ROOT="$XDG_DATA_HOME/jenv"
PATH="$PATH:$JENV_ROOT/bin"

# TODO we could do like with nvm and clone only the last tag
# TODO update script
echo Cloning jenv into ${JENV_ROOT}…
git clone https://github.com/jenv/jenv.git "$JENV_ROOT"

# `jenv init -` output is not compatible for sh shell
echo Loading jenv…
eval "$(jenv init - $(basename $SHELL))"

# keeps JAVA_HOME up-to-date
echo Enable jenv export plugin…
jenv enable-plugin export

if is_os Darwin
then
    echo Installing latest Java version…
    brew install --cask temurin

    echo Finding installed versions with /usr/libexec/java_home…
    /usr/libexec/java_home -X > /tmp/jvm.plist
    i=0
    while :
    do
        jvm_path=$(/usr/libexec/PlistBuddy -c "print :$i:JVMHomePath" /tmp/jvm.plist 2>/dev/null || echo end)
        [ "$jvm_path" = "end" ] && break

        jvm_version=$(/usr/libexec/PlistBuddy -c "print :$i:JVMPlatformVersion" /tmp/jvm.plist | cut -d'.' -f1)

        echo Adding "$jvm_path" to jenv…
        jenv add "$jvm_path"
        i=$((i+1))
    done

    jenv rehash

elif is_os Linux
then
    read -p "Install Adoptium JDK 8 and 21? (y/n) " confirm
    if [ "$confirm" = y ]
    then
        echo Downloading Adoptium GPG key…
        key=/etc/apt/keyrings/adoptium.gpg
        curl -fsS https://packages.adoptium.net/artifactory/api/gpg/key/public \
            | gpg --dearmor \
            | sudo tee $key > /dev/null

        echo Configuring Adoptium apt repository…
        echo "deb [signed-by=$key] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" \
            | sudo tee /etc/apt/sources.list.d/adoptium.list

        echo Installing Java 8 \& 21…
        sudo apt update
        sudo apt install -y apt-transport-https temurin-8-jdk temurin-21-jdk
        jvm_version=21

        if is_installed update-alternatives
        then
            echo Removing alternatives for java…
            sudo update-alternatives --remove-all java || echo No java alternatives removed
        fi

        arch=$(uname -m)
        if [ "$arch" = "aarch64" ]
        then
            arch=arm64
        fi

        echo Adding JDKs to jenv…
        jenv add /usr/lib/jvm/temurin-8-jdk-$arch/
        jenv add /usr/lib/jvm/temurin-21-jdk-$arch/
        jenv rehash

    fi
else
    echo Could not install jenv >&2
    exit 1
fi

echo Linking jenv configuration file…
ln -s "$HOME/.$USER-sh/etc/jenv/rc" "$HOME/.$USER-sh/etc/sh/rc.d/jenv.sh"

echo Setting global version to Java ${jvm_version}…
jenv global $jvm_version

echo Done! Check everything is ok with \'jenv doctor\'.
exec $SHELL -l
