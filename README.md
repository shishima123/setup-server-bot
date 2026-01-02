# 🚀 Set Up VPS

Bộ script auto setup server: cài đặt nodejs, pm2, git và fix lỗi đồng bộ thời gian 

## 1. Set Timezone + NTP

```bash
curl -fsSL https://raw.githubusercontent.com/shishima123/setup-server-bot/main/set_timezone.sh | bash
```

## 2. Setup Server (Node, Git, PM2)

```bash
curl -fsSL https://raw.githubusercontent.com/shishima123/setup-server-bot/main/setup-dev.sh | bash
```
