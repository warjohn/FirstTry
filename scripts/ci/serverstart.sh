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
ARCHIVE_NAME=$(trim "$4")

if [[ -z "$SERVER_IP" || -z "$USER" || -z "$IMAGE_NAME" || -z "$ARCHIVE_NAME" ]]; then
  echo "ERROR: One of the required arguments is empty after trimming."
  exit 1
fi

echo "Connecting to: [$USER]@[$SERVER_IP]"
echo "Image: [$IMAGE_NAME], Archive: [$ARCHIVE_NAME]"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no "$USER@$SERVER_IP" "
  set -e
  echo 'Loading Docker image...'
  docker load < /tmp/$ARCHIVE_NAME.tar.gz

  echo 'Restarting services via docker-compose...'
  cd /opt/mlops-app
  sed -i 's|image: mlops-app:latest|image: $IMAGE_NAME|g' docker-compose.yml

  docker-compose down
  docker-compose up -d

  echo 'Cleaning up archive...'
  rm -f /tmp/$ARCHIVE_NAME.tar.gz
"