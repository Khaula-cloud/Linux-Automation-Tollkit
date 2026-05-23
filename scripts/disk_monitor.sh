#!/bin/bash
# scripts/disk_monitor.sh
source "$HOME/toolkit/config.sh"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] Running disk check..." >> "$LOG_FILE"

df -H | grep -vE '^Filesystem|tmpfs|cdrom|none|drivers|rootfs|/mnt' | awk '{print $5 " " $1}' | \
while read OUTPUT; do
  USAGE=$(echo "$OUTPUT" | awk '{print $1}' | sed 's/%//')
  PARTITION=$(echo "$OUTPUT" | awk '{print $2}')

  if [ "$USAGE" -ge "$DISK_THRESHOLD" ]; then
    MSG="Disk $PARTITION is at ${USAGE}% (threshold: ${DISK_THRESHOLD}%)"
    echo "[$TIMESTAMP] WARNING: $MSG" >> "$LOG_FILE"
    bash "$HOME/toolkit/scripts/send_alert.sh" \
      "Disk Usage Critical: $PARTITION" "$MSG"
  fi
done
