#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/.env"
cd "$SCRIPT_DIR"

pkill -f 'node claw-ark.js' 2>/dev/null || true
sleep 1

exec node claw-ark.js
