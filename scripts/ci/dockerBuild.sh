#!/bin/bash
set -e

docker build \
            --file configs/docker/Dockerfile \
            --tag ${{ env.IMAGE_TAG }} \
            .