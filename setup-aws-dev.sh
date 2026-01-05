#!/bin/bash
set -euo pipefail

echo "======================================"
echo "🚀 AUTO SETUP DEV SERVER (AWS Amazon Linux)"
echo "======================================"

# ===== Detect package manager =====
PKG="yum"
if command -v dnf >/dev/null 2>&1; then
  PKG="dnf"
fi

echo "🔎 Package manager: $PKG"

# ===== 1. Update system =====
echo "🔄 Updating system..."
sudo $PKG -y update

# ===== 2. Install basic packages =====
echo "📦 Installing base packages..."
sudo $PKG -y git

echo "📥 Git version:"
git --version || true

# ===== 3. Install Node.js LTS (NodeSource) =====
echo "📥 Installing Node.js LTS..."
# NodeSource script sẽ tự add repo phù hợp
curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo -E bash -
sudo $PKG -y install nodejs

echo "📌 Node/NPM version:"
node -v
npm -v

# ===== 4. Install PM2 =====
echo "📥 Installing PM2..."
sudo npm install -g pm2

pm2 -v

# ===== 5. Auto enable pm2 startup =====
echo "⚙️ Setting PM2 startup..."
# Lưu ý: nếu bạn chạy script bằng sudo, $USER sẽ là root.
# Ta lấy user thật từ SUDO_USER nếu có.
REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME="$(eval echo "~$REAL_USER")"

# PM2 startup cần chạy với quyền root để tạo systemd service,
# nhưng service sẽ chạy dưới user thật.
sudo env PATH="$PATH" pm2 startup systemd -u "$REAL_USER" --hp "$REAL_HOME"

echo "======================================"
echo "✅ INSTALL DONE"
echo "➡️  Logout & login lại để pm2 startup có hiệu lực"
echo "======================================"
