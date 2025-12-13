#!/bin/bash
set -e

LOG_FILE="/opt/mlops-app/builds.log"
echo "🚀 Deploying MLOps app on $(hostname) at $(date)" >> "$LOG_FILE"

cd /opt/mlops-app/

DOCKER_COMPOSE_FILE="configs/docker/docker-compose.yml"

docker-compose -f "$DOCKER_COMPOSE_FILE" down 2>/dev/null || true

docker-compose -f "$DOCKER_COMPOSE_FILE" build

docker-compose -f "$DOCKER_COMPOSE_FILE" up -d

docker-compose -f "$DOCKER_COMPOSE_FILE" ps

echo "✅ Deployment completed at $(date)" >> "$LOG_FILE"