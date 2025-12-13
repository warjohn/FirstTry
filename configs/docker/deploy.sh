#!/bin/bash
set -e

echo "🚀 Deploying MLOps app on $(hostname) at $(date)" >> /opt/mlops-app/builds.log

cd /opt/mlops-app

# Останавливаем старый контейнер
docker-compose down 2>/dev/null || true

# Собираем заново (если нужно)
docker-compose build

# Запускаем
docker-compose up -d

# Проверяем статус
docker-compose ps

echo "✅ Deployment completed at $(date)" >> /opt/mlops-app/builds.log