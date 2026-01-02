#!/bin/bash
set -e

echo "======================================"
echo "🚀 AUTO SETUP DEV SERVER"
echo "======================================"

# ===== 1. Update system =====
echo "🔄 Updating system..."
apt update -y && apt upgrade -y

# ===== 2. Install basic packages =====
echo "📦 Installing base packages..."
apt install -y curl wget gnupg ca-certificates build-essential

# ===== 3. Install Git =====
echo "📥 Installing Git..."
apt install -y git

git --version

# ===== 4. Install Node.js LTS (Node 20/22 auto LTS) =====
echo "📥 Installing Node.js LTS..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt install -y nodejs

node -v
npm -v

# ===== 5. Install PM2 =====
echo "📥 Installing PM2..."
npm install -g pm2

pm2 -v

# ===== 6. Auto enable pm2 startup =====
echo "⚙️ Setting PM2 startup..."
pm2 startup systemd -u $USER --hp $HOME

echo "======================================"
echo "✅ INSTALL DONE"
echo "➡️  Logout & login lại để pm2 startup có hiệu lực"
echo "======================================"
