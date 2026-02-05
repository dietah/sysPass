#!/bin/bash

#
# Quick test script for sysPass local development
#

set -e

echo "========================================"
echo "sysPass Local Testing Setup"
echo "========================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

echo "✅ Docker found"
echo "✅ Docker Compose found"
echo ""

# Check if we're in the right directory
if [ ! -f "docker-compose.local.yml" ]; then
    echo "❌ Error: docker-compose.local.yml not found"
    echo "   Please run this script from the sysPass directory"
    exit 1
fi

echo "Building and starting sysPass..."
echo ""

# Stop existing containers
docker-compose -f docker-compose.local.yml down

# Build and start
docker-compose -f docker-compose.local.yml up -d --build

echo ""
echo "========================================"
echo "✅ sysPass is starting!"
echo "========================================"
echo ""
echo "Access sysPass at:"
echo "  → HTTP:  http://localhost:8080"
echo "  → HTTPS: https://localhost:8443"
echo ""
echo "Database credentials:"
echo "  Host: syspass-db"
echo "  Database: syspass"
echo "  User: syspass"
echo "  Password: syspass_password"
echo ""
echo "To view logs:"
echo "  docker-compose -f docker-compose.local.yml logs -f"
echo ""
echo "To stop:"
echo "  docker-compose -f docker-compose.local.yml down"
echo ""
echo "⏳ Waiting for services to be ready..."
echo ""

# Wait for database
sleep 5

# Check if containers are running
if docker ps | grep -q "syspass-local"; then
    echo "✅ sysPass container is running"
fi

if docker ps | grep -q "syspass-db-local"; then
    echo "✅ Database container is running"
fi

echo ""
echo "🎉 Setup complete! Open http://localhost:8080 in your browser"
echo ""
echo "📖 See TESTING_GUIDE.md for testing instructions"
