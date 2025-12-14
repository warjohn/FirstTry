#!/bin/bash
set -e

trim() {
  local var="$*"
  var="${var#"${var%%[![:space:]]*}"}"
  var="${var%"${var##*[![:space:]]}"}"
  printf '%s' "$var"
}

SERVER_IP=$(trim "$1")
USER=$(trim "$2")
IMAGE_NAME=$(trim "$3")
CONTAINER_NAME=$(trim "$4")
ARCHIVE_NAME=$(trim "$5")

if [[ -z "$SERVER_IP" || -z "$USER" || -z "$IMAGE_NAME" || -z "$CONTAINER_NAME" || -z "$ARCHIVE_NAME" ]]; then
  echo "ERROR: One of the arguments is empty after trimming."
  exit 1
fi

echo "Connecting to: [$USER]@[$SERVER_IP]"
echo "Image: [$IMAGE_NAME], Container: [$CONTAINER_NAME], Archive: [$ARCHIVE_NAME]"


ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no "$USER@$SERVER_IP" "
  set -e
  echo 'Loading Docker image...'
  docker load < /tmp/$ARCHIVE_NAME.tar.gz
  echo 'Stopping old container (if exists)...'
  docker stop $CONTAINER_NAME 2>/dev/null || true
  docker rm $CONTAINER_NAME 2>/dev/null || true
  echo 'Running new container...'
  docker run -d \
    --name $CONTAINER_NAME \
    --restart unless-stopped \
    -p 8000:8000 \
    $IMAGE_NAME
  echo 'Cleaning up...'
  rm -f /tmp/$ARCHIVE_NAME.tar.gz
  echo 'Done.'
"
