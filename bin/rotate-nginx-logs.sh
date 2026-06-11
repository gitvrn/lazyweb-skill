#!/usr/bin/env bash
set -euo pipefail

# --- config (override via environment) ---
LOG_DIR="${NGINX_LOG_DIR:-/var/log/nginx}"
KEEP_DAYS="${NGINX_KEEP_DAYS:-14}"
COMPRESS="${NGINX_COMPRESS:-1}"
NGINX_PID_FILE="${NGINX_PID:-/var/run/nginx.pid}"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

die() { echo "ERROR: $*" >&2; exit 1; }

[[ -d "$LOG_DIR" ]] || die "Log directory not found: $LOG_DIR"

# --- rotate: rename current logs, optionally compress yesterday's ---
shopt -s nullglob
for log in "$LOG_DIR"/*.log; do
    rotated="${log%.log}-$TIMESTAMP.log"
    mv "$log" "$rotated"
    echo "Rotated: $log → $rotated"
done

# --- signal nginx to reopen log files ---
if [[ -f "$NGINX_PID_FILE" ]]; then
    nginx_pid=$(cat "$NGINX_PID_FILE")
    kill -USR1 "$nginx_pid" && echo "Sent USR1 to nginx (pid $nginx_pid)"
elif command -v nginx &>/dev/null; then
    nginx -s reopen && echo "Sent reopen signal via nginx -s reopen"
else
    echo "WARNING: Could not signal nginx — new logs won't be written until nginx restarts"
fi

# --- compress logs older than 1 day (skip today's just-rotated files) ---
if [[ "$COMPRESS" == "1" ]]; then
    find "$LOG_DIR" -maxdepth 1 -name "*.log" -not -name "*-$TIMESTAMP.log" \
        -mmin +1440 ! -name "*.gz" -print0 |
        xargs -0 -I{} sh -c 'gzip -f "$1" && echo "Compressed: $1"' -- {}
fi

# --- purge logs older than KEEP_DAYS ---
find "$LOG_DIR" -maxdepth 1 \( -name "*.log" -o -name "*.log.gz" \) \
    -mtime +"$KEEP_DAYS" -print0 |
    xargs -0 -I{} sh -c 'rm "$1" && echo "Deleted: $1"' -- {}

echo "Done. (keep_days=$KEEP_DAYS, compress=$COMPRESS)"
