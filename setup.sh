#!/bin/bash

# Homelab File Handler Setup Script
# This script sets up your homelab environment

set -e

echo "🚀 Setting up Homelab File Handler..."

# Check if running on WSL
if grep -q Microsoft /proc/version; then
    echo "✅ Detected WSL environment"
else
    echo "⚠️  This script is designed for WSL. Proceeding anyway..."
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p data config database nginx/ssl

# Set proper permissions
echo "🔐 Setting permissions..."
chmod 755 data config database
chmod 644 docker-compose.yml

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker first."
    echo "   Run: sudo apt update && sudo apt install docker.io"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Compose first."
    echo "   Run: sudo apt install docker-compose"
    exit 1
fi

# Start the services
echo "🐳 Starting FileBrowser with Docker Compose..."
docker-compose up -d

# Wait for services to start
echo "⏳ Waiting for services to start..."
sleep 10

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo "✅ FileBrowser is running!"
    echo ""
    echo "🌐 Access your file handler at:"
    echo "   http://localhost:8080"
    echo ""
    echo "🔑 Default login:"
    echo "   Username: admin"
    echo "   Password: admin"
    echo ""
    echo "⚠️  IMPORTANT: Change the default password immediately!"
    echo ""
    echo "📱 To access from your work laptop:"
    echo "   http://$(hostname -I | awk '{print $1}'):8080"
    echo ""
    echo "🛠️  Useful commands:"
    echo "   View logs: docker-compose logs -f"
    echo "   Stop services: docker-compose down"
    echo "   Restart: docker-compose restart"
else
    echo "❌ Failed to start services. Check logs with: docker-compose logs"
    exit 1
fi

echo "🎉 Setup complete! Happy learning!"
