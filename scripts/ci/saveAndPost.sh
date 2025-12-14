#!/bin/bash
set -e

IMAGE_TAG="$1"
ARCHIVE_NAME="$2"
USER="$3"
SERVER_IP="$4"

echo "Save docker image -> name : $ARCHIVE_NAME"
docker save "$IMAGE_TAG" | gzip > /tmp/"$ARCHIVE_NAME".tar.gz

echo "Send docker image to server"
scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no \
            /tmp/"$ARCHIVE_NAME".tar.gz \
            "$USER"@"$SERVER_IP":/tmp/