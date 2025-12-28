#!/bin/bash

MODE=$1
PANEL_PATH="/var/www/pterodactyl"

rm -rf $PANEL_PATH/app/Http/Middleware/Lifers
rm -rf $PANEL_PATH/resources/views/lifers

sed -i '/LIFERS PROTECT START/,/LIFERS PROTECT END/d' \
$PANEL_PATH/routes/web.php

php artisan optimize:clear

echo "[SUCCESS] PROTECT REMOVED"
