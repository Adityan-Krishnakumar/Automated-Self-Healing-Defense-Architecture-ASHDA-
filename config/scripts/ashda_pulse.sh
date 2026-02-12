#!/bin/bash
# ASHDA Pulse Relay - Multi-Component Monitor
# Path: config/scripts/ashda_pulse.sh

LOG_FILE="/var/log/ashda-pulse.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)

# Auto-selection logic: Checks Apache if on Web server, MariaDB if on DB server
if [[ "$HOSTNAME" == *"web"* ]]; then
    SERVICES=("apache2" "ssh")
elif [[ "$HOSTNAME" == *"db"* ]]; then
    SERVICES=("mariadb" "ssh")
elif [[ "$HOSTNAME" == *"ansible"* ]]; then
    SERVICES=("ssh")
else
    # Default for management nodes or the Wazuh server itself
    SERVICES=("ssh")
fi

# Iterate through selected services and log health status
for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE"; then
        echo "$TIMESTAMP ASHDA-PULSE: STATUS=HEALTHY node=$HOSTNAME component=$SERVICE message=Service_Running" >> "$LOG_FILE"
    else
        echo "$TIMESTAMP ASHDA-PULSE: STATUS=CRITICAL node=$HOSTNAME component=$SERVICE message=SERVICE_DOWN_DETECTED" >> "$LOG_FILE"
    fi
done