#!/bin/bash

MODE=$1
PANEL_PATH="/var/www/pterodactyl"

read -p "Enter Pterodactyl panel URL (without http/https): " PANEL_URL

if [ ! -d "$PANEL_PATH" ]; then
  echo "[ERROR] Pterodactyl not found"
  exit 1
fi

if [ "$MODE" = "ssl" ]; then
  read -p "Enter domain: " DOMAIN
  apt update -y
  apt install nginx certbot python3-certbot-nginx -y
  certbot --nginx -d $DOMAIN --non-interactive --agree-tos -m admin@$DOMAIN
  echo "[SUCCESS] SSL CREATED"
  exit
fi

mkdir -p $PANEL_PATH/app/Http/Middleware/Lifers
mkdir -p $PANEL_PATH/resources/views/lifers

cp assets/protect.blade.php \
$PANEL_PATH/resources/views/lifers/

cp middleware/ProtectDF.php \
$PANEL_PATH/app/Http/Middleware/Lifers/

cp middleware/SuperProtectDF.php \
$PANEL_PATH/app/Http/Middleware/Lifers/

bash protect-map.sh $MODE

php artisan optimize:clear

echo "=============================="
echo " INSTALL FINISHED SUCCESSFULLY "
echo "=============================="
