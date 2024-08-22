# TODO: Colors in fzf preview
# TODO: !! and !*

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share

# Enable fzf for tab completion
# "2" enables using taB to cycle alternati ves
set -U FZF_COMPLETE 2

set -gx PATH "$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
set -gx PATH "$PATH:$HOME/.tfenv/bin"

set -gx FCEDIT nvim
set -gx EDITOR nvim

set -gx REDWOOD_IGNORED_DIRS "node_modules,target,.git,.cargo,.rustup,go"

set fish_greeting

fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block

abbr --add g 'git'
abbr --add t 'tmux'
abbr --add n 'nvim'
abbr --add d 'docker'
abbr --add dc 'docker compose'
abbr --add kctl 'kubectl'
abbr --add s 'sudo '
abbr --add tf 'terraform'

abbr --add rw "redwood"
abbr --add rwo "redwood open"
abbr --add rwi "redwood import"
abbr --add rwd "redwood delete"

abbr --add sysstart "systemctl start"
abbr --add sysstop "systemctl stop"
abbr --add sysrestart "systemctl restart"
abbr --add sysstatus "systemctl status"
abbr --add sysenable "systemctl enable"
abbr --add sysdisable "systemctl disable"

alias ghprs "gh pr list --web" # Open PRs in browser
alias ghpr "gh pr view --web" # Open pr for current branch in browser
alias ghopen "gh browse"

alias tmux 'tmux -f "$XDG_CONFIG_HOME/tmux/.tmux.conf"'

if type -q bat
	alias cat="bat"
end

if type -q lsd
	alias ls="lsd -al"
end

# This enables ctrl+f to be used for accepting auto suggestions. 
# See this for more information
# https://github.com/fish-shell/fish-shell/issues/3541.
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
starship init fish | source

set DEVICE_CONFIG_FILE "$XDG_CONFIG_HOME/fish/config.device.fish"
if test -f $DEVICE_CONFIG_FILE
    source $DEVICE_CONFIG_FILE
end

# Redwood completions
set -l rw_commands delete help list new open version
complete -c redwood --no-files -n "not __fish_seen_subcommand_from $rw_commands"\
	-a 'delete help list new open version'
complete -c redwood -n "__fish_seen_subcommand_from open" \
	-a "(redwood list)"
complete -c redwood -n "__fish_seen_subcommand_from delete" \
    -a "(redwood list --only-worktrees)"
complete -c redwood -n "__fish_seen_subcommand_from new" \
    -a "(redwood list --only-bare-repos)"
