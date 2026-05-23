#!/bin/bash
# scripts/log_rotate.sh
source "$HOME/toolkit/config.sh"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] Starting log rotation..." >> "$LOG_FILE"

# Compress logs older than LOG_MAX_DAYS days
find "$LOG_DIR" -name "*.log" -mtime +"$LOG_MAX_DAYS" ! -name "*.gz" \
  -exec gzip {} \; 2>/dev/null

# Delete compressed logs older than 30 days
find "$LOG_DIR" -name "*.gz" -mtime +30 \
  -exec rm {} \; 2>/dev/null

echo "[$TIMESTAMP] Log rotation complete." >> "$LOG_FILE"

