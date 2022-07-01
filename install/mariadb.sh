#!/usr/bin/env sh

set -eu

. "$HOME/.$USER-sh/common.sh"

if is_os Darwin
then
    echo Installing MariaDB…
    brew install mariadb

elif is_os Linux && is_installed apt
then
    # mariadb vs mysqladmin https://stackoverflow.com/a/22132817
    # https://mariadb.com/kb/en/mysql-command-line-client/
    # https://mariadb.com/kb/en/mysql_secure_installation/

    echo Installing MariaDB…
    sudo apt update
    sudo apt install -y mariadb-server

    echo Starting MariaDB…
    sudo systemctl start mariadb.server

    echo Securing installation…
    sudo mariadb-secure-installation

    echo Creating admin user…
    sudo mariadb <<EOF
grant all on *.* to 'admin'@'localhost' identified by 'admin' with grant option;
flush privileges
EOF

    echo "Use commands mariadb (client) and mysqladmin (administration)."
else
    echo Could not install curl >&2
    exit 1
fi

echo Done!
