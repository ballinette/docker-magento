#!/bin/bash

ORIGPASSWD=$(cat /etc/passwd | grep www-data)
ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)
ORIG_HOME=$(echo "$ORIGPASSWD" | cut -f6 -d:)
DEV_UID=${DEV_UID:=$ORIG_UID}
DEV_GID=${DEV_GID:=$ORIG_GID}

if [ "$DEV_UID" -ne "$ORIG_UID" ] || [ "$DEV_GID" -ne "$ORIG_GID" ]; then
    groupmod -o -g "$DEV_GID" www-data
    usermod -o -u "$DEV_UID" -g "$DEV_GID" www-data
fi

/usr/sbin/apache2ctl -D FOREGROUND
