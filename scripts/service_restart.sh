#!/bin/bash
# scripts/service_restart.sh
source "$HOME/toolkit/config.sh"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

for SERVICE in "${SERVICES[@]}"; do
  if ! systemctl is-active --quiet "$SERVICE"; then
    echo "[$TIMESTAMP] $SERVICE is DOWN — attempting restart..." >> "$LOG_FILE"

    sudo systemctl restart "$SERVICE"
    sleep 3

    if systemctl is-active --quiet "$SERVICE"; then
      MSG="$SERVICE was down and has been restarted successfully."
      echo "[$TIMESTAMP] $SERVICE restarted OK." >> "$LOG_FILE"
    else
      MSG="$SERVICE restart FAILED. Manual intervention needed."
      echo "[$TIMESTAMP] ERROR: $SERVICE restart failed." >> "$LOG_FILE"
    fi

    bash "$HOME/toolkit/scripts/send_alert.sh" \
      "Service Event: $SERVICE" "$MSG"
  else
    echo "[$TIMESTAMP] $SERVICE OK." >> "$LOG_FILE"
  fi
done
