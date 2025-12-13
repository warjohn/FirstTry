#!/bin/bash
set -e

echo "▶️ Starting model training..."
python train_model.py

echo "✅ Training completed. Starting API..."
exec python run.py