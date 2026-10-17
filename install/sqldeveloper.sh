#!/usr/bin/env sh

set -eu

# Fails if cookies are not set…
# echo Fetching URL of latest SQLDeveloper version…
# download_url=$(curl -s https://www.oracle.com/database/sqldeveloper/technologies/download/ \
#     | sed -n "s/.*data-file=\"\([^\"]*\)\".*/https:\1/p" \
#     | grep no-jre \
#     | head -1)
# url="https://www.oracle.com/webapps/redirect/signon?nexturl=$download_url"
# echo URL is "$url"
url=https://www.oracle.com/database/sqldeveloper/technologies/download/
sqldeveloper_dir="$HOME/.local/opt/sqldeveloper"

echo "Web browser will open at: $url"
echo "Save SQLDeveloper for Other Platforms into the Downloads folder."
read -p "Press any key to continue…" any_key

echo Opening URL in browser…
xdg-open "$url" > /dev/null 2>&1

read -p "Press any key once SQLDeveloper has been downloaded…" any_key
archive=$(find "$HOME/Downloads" -name 'sqldeveloper-*-no-jre.zip' -printf "%T@ %p\n" | sort -n | head -1 | cut -f2 -d' ')

if [ -z $archive ]
then
    echo Could not find downloaded archive >&2
    exit 1
fi

echo Removing previous version…
rm -rf "$sqldeveloper_dir"

echo Extracting archive…
unzip "$archive" -d "$(dirname "$sqldeveloper_dir")"
rm $archive

echo Overriding launcher…
launcher="$sqldeveloper_dir/sqldeveloper.sh"
echo "#!/usr/bin/env sh" > "$launcher"
echo "nohup \"$sqldeveloper_dir/sqldeveloper/bin/sqldeveloper\" > /dev/null 2>&1 &" >> "$launcher"

echo Linking launcher to "$HOME/.local/bin/sqldev"…
ln -sf "$launcher" "$HOME/.local/bin/sqldev"

echo Done!
