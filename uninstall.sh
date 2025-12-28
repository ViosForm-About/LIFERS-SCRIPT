#!/bin/bash
set -e

PANEL="/var/www/pterodactyl"

rm -f "$PANEL/app/Http/Middleware/LifersProtect.php"
sed -i "/lifers.protect/d" "$PANEL/app/Http/Kernel.php"

php "$PANEL/artisan" view:clear
php "$PANEL/artisan" route:clear
php "$PANEL/artisan" config:clear

echo "[OK] Protection removed"
