#!/usr/bin/env sh
# Note: mbeans plugin can be installed from UI easily, stored in ~/.visualvm

set -eu

. "$HOME/.$USER-sh/common.sh"

visualvm_dir="$HOME/.local/opt/visualvm"

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
rm -rf "$visualvm_dir"

echo Extracting archive…
unzip /tmp/visualvm.zip -d "$(dirname "$visualvm_dir")"
rm /tmp/visualvm.zip
mv "$(dirname "$visualvm_dir")"/visualvm* "$visualvm_dir"

echo Creating launcher…
launcher="$visualvm_dir/visualvm.sh"
echo "#!/usr/bin/env sh" > "$launcher"
echo "visualvm_jdkhome=\$JAVA_HOME nohup \"$visualvm_dir/bin/visualvm\" > /dev/null 2>&1 &" >> "$launcher"
chmod u+x "$launcher"

echo Linking launcher to "$HOME/.local/bin/visualvm"…
ln -sf "$launcher" "$HOME/.local/bin/visualvm"

echo Done!
