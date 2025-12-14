#!/bin/bash
set -e

SSH_KEY="$1"
SERVER_IP="$2"

mkdir -p ~/.ssh
echo "$SSH_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ssh-keyscan "$SERVER_IP" >> ~/.ssh/known_hosts

echo "✅ ssh was prepared successfully"