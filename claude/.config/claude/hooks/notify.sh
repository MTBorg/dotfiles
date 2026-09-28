#!/bin/sh
# Claude Code hook: notify which tmux session needs attention.
# Usage: notify.sh <message> [sound]
#  - rings the bell on Claude's pane so tmux flags the window/session
#  - posts a macOS notification that switches to that pane when clicked

[ -z "$TMUX_PANE" ] && exit 0

# The click handler runs with a minimal PATH
TMUX_BIN=/opt/homebrew/bin/tmux

target=$($TMUX_BIN display -p -t "$TMUX_PANE" '#{session_name}:#{window_index}.#{pane_index}')
session=${target%%:*}

printf '\a' > "$($TMUX_BIN display -p -t "$TMUX_PANE" '#{pane_tty}')"

/opt/homebrew/bin/terminal-notifier \
  -title "Claude · $session" \
  -message "$1" \
  -group "claude-$session" \
  ${2:+-sound "$2"} \
  -execute "$TMUX_BIN switch-client -t '$target' && $TMUX_BIN select-pane -t '$target'; open -a Alacritty" \
  >/dev/null 2>&1 &
