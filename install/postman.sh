#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux
then
    postman_dir="$HOME/.local/opt/postman"

    echo Removing existing version…
    rm -rf "$postman_dir"

    echo Downloading latest Postman version…

    arch=$(uname -m)
    if [ "$arch" = "aarch64" -o "$arch" = "arm64" ]
    then
        wget -O /tmp/postman.tar.gz https://dl.pstmn.io/download/latest/linux_arm64
    else
        wget -O /tmp/postman.tar.gz https://dl.pstmn.io/download/latest/linux_64
    fi

    echo Extracting archive…
    mkdir -p "$(dirname "$postman_dir")"
    tar xvf /tmp/postman.tar.gz -C "$(dirname "$postman_dir")"
    rm /tmp/postman.tar.gz

    mv "$(dirname "$postman_dir")/Postman/app" "$postman_dir"
    rm -rf "$(dirname "$postman_dir")/Postman"

    echo Creating launcher…
    launcher="$postman_dir/postman.sh"
    echo "#!/usr/bin/env sh" > "$launcher"
    echo "nohup \"$postman_dir/Postman\" > /dev/null 2>&1 &" >> "$launcher"
    chmod u+x "$launcher"

    echo Linking launcher to "$HOME/.local/bin/postman"…
    ln -sf "$launcher" "$HOME/.local/bin/postman"

    echo Done!
else
    echo Could not install Postman >&2
    exit 1
fi
