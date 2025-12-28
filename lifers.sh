#!/bin/bash
# ============================================
# LIFERS SCRIPT V3 - MAIN MENU (FIXED)
# ============================================

clear
echo "================================="
echo "        LIFERS SCRIPT V3"
echo "================================="
echo "[1] Create SSL (Nginx + Certbot)"
echo "[2] Install Protect DF"
echo "[3] Install Super Protect DF"
echo "[4] Uninstall Protect DF"
echo "[5] Uninstall Super Protect DF"
echo "[0] Exit"
echo "================================="

read -p "Select option: " CHOICE

case "$CHOICE" in
  1)
    echo "[INFO] Selected: Create SSL"
    bash install.sh ssl
    ;;
  2)
    echo "[INFO] Selected: Install Protect DF"
    bash install.sh protect
    ;;
  3)
    echo "[INFO] Selected: Install Super Protect DF"
    bash install.sh super
    ;;
  4)
    echo "[INFO] Selected: Uninstall Protect DF"
    bash uninstall.sh protect
    ;;
  5)
    echo "[INFO] Selected: Uninstall Super Protect DF"
    bash uninstall.sh super
    ;;
  0)
    echo "Exit."
    exit 0
    ;;
  *)
    echo "[ERROR] Invalid option"
    ;;
esac
