#!/bin/bash
set -e

MYSQL_CMD="mysql --user=root --password=$MYSQL_ROOT_PASSWORD"

if [ "$MYSQL_DATABASE" ]; then
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | $MYSQL_CMD
fi

if [ "$MYSQL_USER" ] && [ "$MYSQL_PASSWORD" ]; then
    echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | $MYSQL_CMD
    echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" | $MYSQL_CMD
fi

echo 'FLUSH PRIVILEGES ;' | $MYSQL_CMD