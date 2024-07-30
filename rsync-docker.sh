#!/bin/bash

PUSHOVER_URL="https://api.pushover.net/1/messages.json"

notify() {
    local message="$1"
    local title="`whoami`@${HOSTNAME}"
    local body="token=$APP_TOKEN&user=$USER_TOKEN&message=$message&title=$title"
    curl -s "$PUSHOVER_URL" -d "$body" >/dev/null
}

echo "Loading configuration..."
source "$(dirname $0)/.env"

echo "Starting rsync backup of /var/lib/docker/volumes..."
sshpass -p "$RSYNC_PASSWORD" rsync -e ssh -avhH --delete --progress /var/lib/docker/volumes/ rsync@cocoberry.local::NetBackup/docker/

if [ "$?" -eq 0 ];
then
    echo "Backup finished successfully."
    notify "Backup finished successfully."
else
    echo "Backup failed."
    notify "Backup failed."
fi
