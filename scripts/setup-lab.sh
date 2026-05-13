#!/bin/bash
set -e

echo "🚀 Starting Resilience Lab Setup (Bash)..."

# Check for Kind
if ! command -v kind &> /dev/null; then
    echo "❌ Kind is not installed."
    exit 1
fi

kind create cluster --name resilience-lab || echo "Cluster already exists"

# Install Chaos Mesh
curl -sSL https://mirrors.chaos-mesh.org/v2.6.2/install.sh | bash

echo "✅ Lab is ready!"