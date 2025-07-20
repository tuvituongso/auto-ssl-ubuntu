#!/bin/bash

# Script cài đặt SSL Let's Encrypt tự động cho Ubuntu 22.04
# Hỗ trợ: Nginx hoặc Apache

echo "============================"
echo "  AUTO INSTALL SSL UBUNTU"
echo "============================"
sleep 1

# Kiểm tra quyền root
if [[ "$EUID" -ne 0 ]]; then
  echo "Vui lòng chạy script với quyền root."
  exit 1
fi

# Cài đặt Certbot và plugin
echo "Cài đặt Certbot và plugin phù hợp..."
apt update
apt install -y software-properties-common
add-apt-repository universe -y
apt update

echo "Chọn web server bạn đang sử dụng:"
echo "1) Nginx"
echo "2) Apache"
read -p "Lựa chọn (1 hoặc 2): " webserver

if [ "$webserver" == "1" ]; then
  apt install -y certbot python3-certbot-nginx
  plugin="--nginx"
elif [ "$webserver" == "2" ]; then
  apt install -y certbot python3-certbot-apache
  plugin="--apache"
else
  echo "Lựa chọn không hợp lệ."
  exit 1
fi

# Nhập domain và email
read -p "Nhập domain (ví dụ: yourdomain.com): " domain
read -p "Nhập email để nhận thông báo SSL: " email

# Gọi Certbot để tạo chứng chỉ
echo "Cấp chứng chỉ SSL cho $domain ..."
certbot $plugin -d $domain --non-interactive --agree-tos -m $email --redirect

# Tạo cron tự động gia hạn
echo "Thiết lập tự động gia hạn SSL..."
(crontab -l 2>/dev/null; echo "0 3 * * * /usr/bin/certbot renew --quiet") | crontab -

echo "✅ Cài đặt SSL hoàn tất cho $domain"
