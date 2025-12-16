#!/bin/sh
set -e

if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sh /tmp/get-docker.sh
else
  echo "Docker уже установлен."
fi


if ! command -v kubectl &> /dev/null; then
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/kubectl
else
  echo "kubectl уже установлен."
fi

if ! command -v minikube &> /dev/null; then
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
else
  echo "Minikube уже установлен."
fi

if [ -n "${SUDO_USER:-}" ] && [ "$SUDO_USER" != "root" ]; then
  TARGET_USER="$SUDO_USER"
else
  TARGET_USER="${USER}"
fi

if ! groups "$TARGET_USER" | grep -q '\bdocker\b'; then
  usermod -aG docker "$TARGET_USER"
fi


apt install mc
# метрики
wget -O - http://zabbix.repo.timeweb.ru/zabbix-install.sh | bash