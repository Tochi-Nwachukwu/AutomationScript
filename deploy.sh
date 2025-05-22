#!/bin/bash

set -e

APP_DIR="/var/www/python-app"

echo "🧹 Deleting old app (if exists)..."
sudo rm -rf "$APP_DIR"

echo "📁 Creating app folder..."
sudo mkdir -p "$APP_DIR"

echo "📦 Moving files to app folder..."
sudo mv * "$APP_DIR"

cd "$APP_DIR"
sudo mv env .env

sudo chown -R $USER:$USER "$APP_DIR"

echo "🔄 Updating package list..."
sudo apt-get update

echo "🐍 Installing Python and pip..."
sudo apt-get install -y python3 python3-pip python3-venv

echo "💻 Setting up virtual environment..."
python3 -m venv venv
source venv/bin/activate

echo "📦 Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt || pip install flask

echo "🚀 Starting Flask app in background..."
nohup flask run --host=0.0.0.0 --port=5000 > flask.log 2>&1 &
echo "✅ Flask app started in background. Logs: flask.log"