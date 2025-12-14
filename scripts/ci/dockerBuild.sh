#!/bin/bash
set -e

IMAGE_TAG="$1"

docker build \
            --file configs/docker/Dockerfile \
            --tag "$IMAGE_TAG" \
            .