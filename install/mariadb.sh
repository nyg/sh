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
    # https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-ubuntu-22-04

    echo Installing MariaDB…
    sudo apt update
    sudo apt install -y mariadb-server

    echo Starting MariaDB…
    sudo systemctl start mariadb.service

    echo Securing installation (suggesting default, n, n, Y*)…
    sudo mariadb-secure-installation

    echo Creating admin user…
    sudo mariadb <<EOF
grant all on *.* to 'admin'@'localhost' identified by 'admin' with grant option;
flush privileges
EOF

    echo "Use commands mariadb (client) and mysqladmin (administration)."

    # Log in with root db user
    #   sudo mariadb
    # Log in with specific user
    #   mariadb -u admin -p

    # Useful commands/queries:
    # status;
    # select user(), current_user(), database();
    # select user from mysql.user;
    # select user, db, host from mysql.db;
    # show grants for 'admin'@'localhost';
else
    echo Could not install mariadb >&2
    exit 1
fi

echo Done!
