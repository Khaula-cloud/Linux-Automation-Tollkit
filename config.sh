#!/bin/bash
# ~/toolkit/config.sh — shared configuration

ALERT_EMAIL="khaulaazhar125@gmail.com"
LOG_FILE="$HOME/toolkit/logs/toolkit.log"
DISK_THRESHOLD=80      # alert if usage % exceeds this
LOG_DIR="$HOME/toolkit/logs"      # directory to rotate logs from
LOG_MAX_DAYS=7          # keep logs newer than N days
SERVICES=("nginx" "cron" "postfix@-" "docker" "fail2ban")  # services to watch
