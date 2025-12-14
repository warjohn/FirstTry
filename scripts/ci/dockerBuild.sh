#!/bin/bash
set -e

IMAGE_TAG=$(echo "$1" | xargs)

if [ -z "$IMAGE_TAG" ]; then
  echo "ERROR: IMAGE_TAG is empty after trimming."
  exit 1
fi

docker build \
            --file configs/docker/Dockerfile \
            --tag "$IMAGE_TAG" \
            .

echo "✅ docker was build successfully"