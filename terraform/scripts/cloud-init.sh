#!/bin/sh

set -e

apt update -y
apt install nginx-core -y
apt install nginx-extras -y
apt install nginx-light -y

mkdir -p /opt/mlops-app

cat > /opt/mlops-app/docker-compose.yml << 'EOF'
version: '3.8'
services:
  mlops-app-1:
    image: mlops-app:latest
    volumes: &volumes
      - /opt/mlops-app/data:/app/data
    environment: &env
      - PYTHONUNBUFFERED=1
    restart: unless-stopped
    ports:
      - "8001:8000"

  mlops-app-2:
    image: mlops-app:latest
    volumes: *volumes
    environment: *env
    restart: unless-stopped
    ports:
      - "8002:8000"

  mlops-app-3:
    image: mlops-app:latest
    volumes: *volumes
    environment: *env
    restart: unless-stopped
    ports:
      - "8003:8000"
EOF

# Записываем nginx.conf
cat > /etc/nginx/nginx.conf << 'EOF'
events {}

http {
    upstream backend {
        server 127.0.0.1:8001;
        server 127.0.0.1:8002;
        server 127.0.0.1:8003;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
EOF

systemctl restart nginx

cd /opt/mlops-app && docker-compose up -d || true
