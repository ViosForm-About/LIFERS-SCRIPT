#!/bin/bash
clear

echo "=============================="
echo "        LIFERS SCRIPT V3"
echo "=============================="
echo "[1] Create SSL (Nginx + Certbot)"
echo "[2] Install Protect DF"
echo "[3] Install Super Protect DF"
echo "[4] Uninstall Protect DF"
echo "[5] Uninstall Super Protect DF"
echo "[0] Exit"
echo "=============================="

read -p "Select option: " opt

case $opt in
  1) bash install.sh ssl ;;
  2) bash install.sh protect ;;
  3) bash install.sh super ;;
  4) bash uninstall.sh protect ;;
  5) bash uninstall.sh super ;;
  0) exit ;;
  *) echo "Invalid option";;
esac
