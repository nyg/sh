#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

echo Fetching URL of latest VisualVM version…
download_url=$(curl -s https://api.github.com/repos/oracle/visualvm/releases/latest \
   | jq -r '.assets[] | select(.name | test("visualvm.*zip")) | .browser_download_url')

echo Downloading VisualVM from "$download_url"…
(cd /tmp; curl -Lo visualvm.zip "$download_url")

if [ ! -f /tmp/visualvm.zip ]
then
    echo Download failed! >&2
    exit 1
fi

echo Removing previous version…
rm -rf "$HOME/.$USER-sh/softwares/visualvm"

echo Extracting archive…
unzip /tmp/visualvm.zip -d "$HOME/.$USER-sh/softwares/"
rm /tmp/visualvm.zip
mv "$HOME"/".$USER-sh"/softwares/visualvm* "$HOME/.$USER-sh/softwares/visualvm"

echo Creating launcher…
launcher="$HOME/.$USER-sh/softwares/visualvm/visualvm.sh"
echo "#!/usr/bin/env sh" > "$launcher"
echo 'visualvm_jdkhome=$JAVA_HOME nohup $HOME/.$USER-sh/softwares/visualvm/bin/visualvm > /dev/null 2>&1 &' >> "$launcher"
chmod u+x "$launcher"

echo Linking launcher to "$HOME/.local/bin/visualvm"…
ln -s "$HOME/.$USER-sh/softwares/visualvm/visualvm.sh" "$HOME/.local/bin/visualvm" || echo Link already exists

echo Done!
