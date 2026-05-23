#!/bin/bash
# scripts/send_alert.sh
source "$HOME/toolkit/config.sh"

SUBJECT="$1"
BODY="$2"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Log the alert
echo "[$TIMESTAMP] ALERT: $SUBJECT" >> "$LOG_FILE"

# Send email
echo "$BODY" | mail -s "[TOOLKIT] $SUBJECT" "$ALERT_EMAIL"
