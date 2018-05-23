#!/bin/bash

export HOME=/home/$APP_USERNAME

ZMQ_APPS=$(compgen -A variable | grep -E 'ZMQ_APP_[0-9]$' | sort)

function ensure_socket_write () {
    $APP=$1
    echo "Checking directory permissions for $APP"
}

for APP in $ZMQ_APPS; do
    ensure_socket_write $APP
done

exec gosu $APP_USERNAME "$@"
