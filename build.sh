#!/bin/bash
set -e

APP_NAME="ecommerce-app"
TAG=${1:-latest}

echo "🚀 Building Docker image..."
docker build -t $APP_NAME:$TAG .

echo "✅ Build complete: $APP_NAME:$TAG"
