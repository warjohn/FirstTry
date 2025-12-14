#!/bin/bash
set -e

IMAGE_TAG="$1"
ARCHIVE_NAME="$2"
USER="$3"
SERVER_IP="$4"

if [[ -z "$IMAGE_TAG" || -z "$ARCHIVE_NAME" || -z "$USER" || -z "$SERVER_IP" ]]; then
  echo "ERROR: One of the required arguments is empty after trimming."
  exit 1
fi

echo "Save docker image -> name: [$IMAGE_TAG] -> archive: [$ARCHIVE_NAME]"
docker save "$IMAGE_TAG" | gzip > "/tmp/${ARCHIVE_NAME}.tar.gz"

echo "Send docker image to server"
scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no \
            /tmp/"$ARCHIVE_NAME".tar.gz \
            "$USER"@"$SERVER_IP":/tmp/