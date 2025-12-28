#!/bin/bash
set -e

# ================================
# LIFERS SCRIPT
# SSL & Certificate Manager
# ================================

clear

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

# ===== BANNER =====
cat assets/banner.txt 2>/dev/null || echo "LIFERS SCRIPT"

# ===== MENU =====
echo ""
echo -e "${YELLOW}[1] Create SSL (Nginx + Certbot)"
echo "[2] Create Certificate Only"
echo "[3] Uninstall SSL"
echo "[4] Uninstall Certificate"
echo "[0] Exit${RESET}"
echo ""

read -p "Select option: " MENU

# ===== INPUT DOMAIN =====
if [[ "$MENU" != "0" ]]; then
  read -p "Enter domain/subdomain (without http/https): " DOMAIN
fi

NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"

# ================================
# FUNCTION: CREATE SSL
# ================================
create_ssl() {
  echo -e "${CYAN}Creating Nginx config...${RESET}"

  if [ -f "$NGINX_CONF" ]; then
    echo -e "${RED}Config already exists.${RESET}"
    cat assets/error.txt
    exit 1
  fi

cat <<EOF > "$NGINX_CONF"
server {
    listen 80;
    server_name $DOMAIN;

    root /var/www/node;
    index index.html;

    location / {
        return 403;
    }
}
EOF

  ln -s "$NGINX_CONF" /etc/nginx/sites-enabled/
  systemctl reload nginx

  echo -e "${CYAN}Requesting SSL...${RESET}"
  certbot --nginx -d "$DOMAIN"

  echo -e "${GREEN}SSL successfully created.${RESET}"
  cat assets/success.txt
}

# ================================
# FUNCTION: CREATE CERT ONLY
# ================================
create_cert() {
  echo -e "${CYAN}Requesting certificate only...${RESET}"
  certbot certonly --standalone -d "$DOMAIN"

  echo -e "${GREEN}Certificate created successfully.${RESET}"
  cat assets/success.txt
}

# ================================
# FUNCTION: REMOVE SSL
# ================================
remove_ssl() {
  echo -e "${CYAN}Removing SSL...${RESET}"
  certbot delete --cert-name "$DOMAIN"

  rm -f "/etc/nginx/sites-enabled/$DOMAIN"
  rm -f "/etc/nginx/sites-available/$DOMAIN"
  systemctl reload nginx

  echo -e "${GREEN}SSL removed.${RESET}"
}

# ================================
# FUNCTION: REMOVE CERT ONLY
# ================================
remove_cert() {
  echo -e "${CYAN}Removing certificate...${RESET}"
  certbot delete --cert-name "$DOMAIN"

  echo -e "${GREEN}Certificate removed.${RESET}"
}

# ================================
# EXECUTION
# ================================
case $MENU in
  1) create_ssl ;;
  2) create_cert ;;
  3) remove_ssl ;;
  4) remove_cert ;;
  0) exit 0 ;;
  *) echo -e "${RED}Invalid option.${RESET}" ;;
esac
