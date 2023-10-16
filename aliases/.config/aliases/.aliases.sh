# Base/base-devel
alias sudo="doas " # This allows the use of sudo/doas before aliases
alias s="doas "
alias h="history"
alias ll="ls -alh --color=auto"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias grep="grep --color=auto"
which bat > /dev/null && alias cat="bat" # Use bat if installed
which lsd > /dev/null && alias ls="lsd" # Use ls if installed
#Always ask before deleting, preserve root and delete empty directories
alias rm="rm -Id --preserve-root"
alias rm="safe-rm -v -Id --preserve-root" #Comment this if not using safe-rm
alias less="less -FX"
# Use -v option for feedback
alias mv="mv -v"
alias cp="cp -v"

# Systemctl
alias sysstart="systemctl start"
alias sysstop="systemctl stop"
alias sysrestart="systemctl restart"
alias sysstatus="systemctl status"
alias sysenable="systemctl enable"
alias sysdisable="systemctl disable"

# tmux
alias t="tmux"
alias tkill="tmux kill-session -t"
alias tattach="tmux attach-session -t"

# Docker
alias d="docker"
alias dc="docker-compose"

# Arch Linux specific aliases
if [ -f "/etc/arch-release" ]; then
	alias p="pacman"
fi

# Others
alias g="git"
alias tmux='tmux -f "$XDG_CONFIG_HOME/tmux/.tmux.conf"'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias open="xdg-open"
alias o="xdg-open"
alias rw="redwood"
alias rwo="redwood open"
alias rwi="redwood import"
alias kctl="kubectl"
alias godebug="dlv debug --headless --accept-multiclient --listen 127.0.0.1:38697 "
