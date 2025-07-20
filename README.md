# Auto SSL Installer for Ubuntu 22.04

This script automatically installs a Let's Encrypt SSL certificate on your Ubuntu 22.04 server using Certbot.

## ✅ Features
- Supports **Nginx** and **Apache**
- Auto installs Certbot + plugin
- Enables HTTPS with redirect
- Sets up daily **auto-renewal**

## 🛠 Usage

1. Upload the script:
```bash
chmod +x auto_ssl.sh
sudo ./auto_ssl.sh
```

2. Enter your domain and email when prompted.

3. Done ✅

## 📅 Auto-renew
A cron job is created to renew SSL daily:
```bash
0 3 * * * /usr/bin/certbot renew --quiet
```
