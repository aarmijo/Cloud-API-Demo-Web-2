#!/bin/bash
# Load all environment variables from .env.secret
set -a
source ./.env.secret
set +a

# Clean up empty OSS environment variables
for var in CLOUD_OSS_ENABLE CLOUD_OSS_PROVIDER CLOUD_OSS_ENDPOINT CLOUD_OSS_ACCESS_KEY \
           CLOUD_OSS_SECRET_KEY CLOUD_OSS_REGION CLOUD_OSS_BUCKET \
           CLOUD_OSS_OBJECT_DIR_PREFIX CLOUD_OSS_ROLE_SESSION_NAME CLOUD_OSS_ROLE_ARN; do
  [ -z "${!var}" ] && unset "$var"
done

# Determine the host's LAN IP address depending on the operating system.
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS: Try to get the IP address from the primary network interface (en0)
  HOST_LAN_IP=$(ipconfig getifaddr en0)
  # Fallback to en1 if en0 doesn't return an IP.
  if [ -z "$HOST_LAN_IP" ]; then
    HOST_LAN_IP=$(ipconfig getifaddr en1)
  fi
else
  # Linux: Use hostname with -I to get all IP addresses and take the first one.
  HOST_LAN_IP=$(hostname -I | awk '{print $1}')
fi

# Define the external port bound on the host for the nginx service (adjust if needed)
NGINX_PORT=8080

# Override VITE environment variables (which are used in src/api/config/env.ts)
# These values will override the components that reference the local IP (e.g., in status endpoints)
export VITE_BASE_URL="http://$HOST_LAN_IP:$NGINX_PORT/api/"
export VITE_WEBSOCKET_URL="ws://$HOST_LAN_IP:$NGINX_PORT/api/v1/ws"

export MQTT_BASIC_HOST="${HOST_LAN_IP}"
export MQTT_DRC_HOST="${HOST_LAN_IP}"

echo "-----------------------------------------"
echo "Starting Docker Compose with the following settings:"
echo "Host LAN IP: $HOST_LAN_IP"
echo "NGINX External Port: $NGINX_PORT"
echo "VITE_BASE_URL: $VITE_BASE_URL"
echo "VITE_WEBSOCKET_URL: $VITE_WEBSOCKET_URL"
echo "MQTT_BASIC_HOST: $MQTT_BASIC_HOST"
echo "MQTT_DRC_HOST: $MQTT_DRC_HOST"
echo "-----------------------------------------"

# Bring up the containers using relative paths
docker-compose up