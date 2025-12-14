#!/bin/bash
set -e

SERVER_IP="$1"
USER="$2"
IMAGE_NAME="$3"
CONTAINER_NAME="$4"
ARCHIVE_NAME="$5"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no "$USER"@"$SERVER_IP" "
            set -e
            docker load < /tmp/$ARCHIVE_NAME.tar.gz
            docker stop $CONTAINER_NAME 2>/dev/null || true
            docker rm $CONTAINER_NAME 2>/dev/null || true
            docker run -d \
              --name $CONTAINER_NAME \
              --restart unless-stopped \
              -p 8000:8000 \
              $IMAGE_NAME
            rm -f /tmp/$ARCHIVE_NAME.tar.gz
          "
