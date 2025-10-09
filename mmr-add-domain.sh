#!/usr/bin/env bash
set -euo pipefail

USER_NAME="${SUDO_USER:-$USER}"
CONF_DIR="/home/${USER_NAME}"
CONF_FILE="${CONF_DIR}/frpc.toml"

DOMAIN_BASE="mmr-group.pl"

if [[ $# -lt 2 ]]; then
  echo "Usage: mmr-add-domain <subdomain-name> <localPort>"
  echo "Example: mmr-add-domain app 5173"
  exit 1
fi

SUB="$1"
LOCAL_PORT="$2"

if [[ ! -f "$CONF_FILE" ]]; then
  echo "Could not find $CONF_FILE – generate it first with mmr-gen-frpc."
  exit 2
fi

PROXY_NAME="${USER_NAME}-${SUB}"
CUSTOM_DOMAIN="${SUB}.${USER_NAME}.dev.${DOMAIN_BASE}"

cat >>"$CONF_FILE" <<EOF

[[proxies]]
name = "${PROXY_NAME}"
type = "http"
localPort = ${LOCAL_PORT}
customDomains = ["${CUSTOM_DOMAIN}"]
EOF

echo "Added new domain: http://${CUSTOM_DOMAIN} → localPort=${LOCAL_PORT}"

if sudo -u "$USER_NAME" systemctl --user is-active --quiet frpc; then
  sudo -u "$USER_NAME" systemctl --user restart frpc
  echo "frpc.service restarted"
fi
