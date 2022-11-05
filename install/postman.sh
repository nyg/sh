#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Linux
then
    echo Removing existing version…
    rm -rf "$HOME/.$USER-sh/softwares/postman"

    echo Downloading latest Postman version…
    wget -O /tmp/postman.tar.gz https://dl.pstmn.io/download/latest/linux64

    echo Extracting archive…
    tar xvf /tmp/postman.tar.gz -C "$HOME/.$USER-sh/softwares"
    rm /tmp/postman.tar.gz

    mv "$HOME/.$USER-sh/softwares/Postman/app" "$HOME/.$USER-sh/softwares/postman"
    rm -rf "$HOME/.$USER-sh/softwares/Postman"

    echo Creating launcher…
    launcher="$HOME/.$USER-sh/softwares/postman/postman.sh"
    echo "#!/usr/bin/env sh" > "$launcher"
    echo 'nohup $HOME/.$USER-sh/softwares/postman/Postman > /dev/null 2>&1 &' >> "$launcher"
    chmod u+x "$launcher"

    echo Linking launcher to "$HOME/.local/bin/postman"…
    ln -s "$HOME/.$USER-sh/softwares/postman/postman.sh" "$HOME/.local/bin/postman" || echo Link already exists

    echo Done!
else
    echo Could not install Postman >&2
    exit 1
fi
