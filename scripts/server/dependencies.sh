#!/bin/bash
set -e

echo "🔍 Проверка и установка зависимостей..."

# === Установка Docker ===
if ! command -v docker &> /dev/null; then
  echo "📦 Установка Docker..."
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sh /tmp/get-docker.sh
  echo "✅ Docker установлен."
else
  echo "✅ Docker уже установлен."
fi

# === Установка kubectl ===
if ! command -v kubectl &> /dev/null; then
  echo "📦 Установка kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/kubectl
  echo "✅ kubectl установлен."
else
  echo "✅ kubectl уже установлен."
fi

# === Установка Minikube ===
if ! command -v minikube &> /dev/null; then
  echo "📦 Установка Minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
  echo "✅ Minikube установлен."
else
  echo "✅ Minikube уже установлен."
fi

# === Добавление пользователя в группу docker (если нужно) ===
# Предполагаем, что скрипт запущен от имени целевого пользователя или известен USER
if [ -n "${SUDO_USER:-}" ] && [ "$SUDO_USER" != "root" ]; then
  TARGET_USER="$SUDO_USER"
else
  TARGET_USER="${USER}"
fi

if ! groups "$TARGET_USER" | grep -q '\bdocker\b'; then
  echo "🔧 Добавление пользователя $TARGET_USER в группу docker..."
  usermod -aG docker "$TARGET_USER"
  echo "ℹ️  Для применения изменений требуется перелогин или перезагрузка."
fi

echo "✨ Подготовка сервера завершена. Теперь можно запускать Minikube!"
echo "📌 Пример запуска: minikube start --driver=docker"