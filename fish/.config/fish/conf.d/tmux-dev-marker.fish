# Mark the tmux pane running `pnpm dev:backend` / `pnpm dev:hub` (the backend/hub
# abbrs) so the tmux session switcher can show where they run.
status is-interactive; and set -q TMUX_PANE; or exit

function __tmux_dev_marker_set --on-event fish_preexec
    string match -qr 'dev:(?<app>backend|hub)\b' -- $argv[1]; or return
    tmux set -p -t $TMUX_PANE @dev $app
end

function __tmux_dev_marker_unset --on-event fish_postexec
    tmux set -pu -t $TMUX_PANE @dev 2>/dev/null
end
