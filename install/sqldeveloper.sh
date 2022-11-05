#!/usr/bin/env sh

set -eu

echo Fetching URL of latest SQLDeveloper version…
download_url=$(curl -s https://www.oracle.com/database/sqldeveloper/technologies/download/ \
    | sed -n "s/.*data-file=\"\([^\"]*\)\".*/https:\1/p" \
    | grep no-jre \
    | head -1)
url="https://www.oracle.com/webapps/redirect/signon?nexturl=$download_url"
echo URL is "$url"

read -p "Enter any key to open URL in browser. Log into OTN and save SQLDeveloper to the Downloads folder. Ctrl + C to abort." any_key

echo Opening URL in browser…
python -m webbrowser "$url"

read -p "Press any key once SQLDeveloper has been downloaded. Ctrl + C to abort." any_key
archive=$(find "$HOME/Downloads" -name 'sqldeveloper-*-no-jre.zip' -printf "%T@ %p\n" | sort -n | head -1 | cut -f2 -d' ')

if [ -z $archive ]
then
    echo Could not find downloaded archive >&2
    exit 1
fi

echo Removing previous version…
rm -rf "$HOME/.$USER-sh/softwares/sqldeveloper"

echo Unzipping archive…
unzip "$archive" -d $HOME/.$USER-sh/softwares/
rm $archive

echo Overriding launcher…
launcher="$HOME/.$USER-sh/softwares/sqldeveloper/sqldeveloper.sh"
echo "#!/usr/bin/env sh" > "$launcher"
echo "nohup $HOME/.$USER-sh/softwares/sqldeveloper/sqldeveloper/bin/sqldeveloper > /dev/null 2>&1 &" >> "$launcher"

echo Linking executable to "$HOME/.local/bin/sqldev"…
mkdir -p "$HOME/.local/bin"
ln -s "$HOME/.$USER-sh/softwares/sqldeveloper/sqldeveloper.sh" "$HOME/.local/bin/sqldev"

echo Done!
