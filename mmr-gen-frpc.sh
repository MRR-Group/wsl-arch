#!/usr/bin/env bash

set -euo pipefail
USER_NAME="${1:-$USER}"
DOMAIN_BASE="mrrgroup.pl"  
SERVER_ADDR="194.9.6.83"     
SERVER_PORT="7000"

API_HOST="api.${USER_NAME}.${DOMAIN_BASE}"

cat >"/home/${USER_NAME}/frpc.toml" <<EOF
serverAddr = "${SERVER_ADDR}"
serverPort = ${SERVER_PORT}

[[proxies]]
name = "${USER_NAME}-api"
type = "http"
localPort = 80
customDomains = ["${API_HOST}"]
EOF

chown -R "${USER_NAME}:${USER_NAME}" "/home/${USER_NAME}/frpc.toml"
echo "Generated: /home/${USER_NAME}/frpc.toml (API: http://${API_HOST})"
