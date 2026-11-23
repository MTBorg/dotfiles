#!/bin/sh
# Claude Code hook: keep macOS awake with the lid closed while Claude is working.
# Usage: nosleep.sh start|stop   (hook JSON on stdin)
#  - start: marks this session active and disables sleep
#  - stop:  unmarks it and re-enables sleep once no live session is active
# Needs passwordless sudo for pmset (see /etc/sudoers.d/pmset).

dir="${TMPDIR:-/tmp}/claude-nosleep"
session=$(jq -r '.session_id // "default"')
mkdir -p "$dir"

case "$1" in
  start)
    # Record the Claude process so a crashed session doesn't keep the Mac awake
    pid=$PPID
    while [ "$pid" -gt 1 ] && ! ps -o comm= -p "$pid" | grep -q claude; do
      pid=$(ps -o ppid= -p "$pid" | tr -d ' ')
    done
    echo "$pid" > "$dir/$session"
    sudo -n pmset -a disablesleep 1
    ;;
  stop)
    rm -f "$dir/$session"
    for f in "$dir"/*; do
      [ -f "$f" ] || continue
      if kill -0 "$(cat "$f")" 2>/dev/null; then exit 0; fi
      rm -f "$f"
    done
    sudo -n pmset -a disablesleep 0
    ;;
esac
