#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/.env"
cd "$SCRIPT_DIR"

LOG_DIR="$SCRIPT_DIR/logs"
LOG_FILE="$LOG_DIR/start.log"
mkdir -p "$LOG_DIR"

echo "[$(date)] Starting claw-ark..." >> "$LOG_FILE"

pkill -f 'node.*claw-ark.js' 2>/dev/null || true
sleep 2

if lsof -ti:${PORT:-4000} 2>/dev/null; then
    echo "[$(date)] Port ${PORT:-4000} in use, killing..." >> "$LOG_FILE"
    lsof -ti:${PORT:-4000} | xargs kill -9 2>/dev/null || true
    sleep 1
fi

echo "[$(date)] Starting node process..." >> "$LOG_FILE"
exec node claw-ark.js >> "$LOG_FILE" 2>&1
